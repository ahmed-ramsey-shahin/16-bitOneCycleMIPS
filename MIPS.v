`timescale 1ns / 1ps

module MIPS(
    input clk, reset_n,
    output reg [15:0] pc,
    output [15:0] alu_result
);
    // Wires
    wire [15:0] instruction, register_file_out_1, register_file_out_2, data_memory_out, result;
    wire [2:0] alu_selector;
    wire [1:0] alu_op, reg_dst, mem_to_reg;
    wire reg_write, mem_read, mem_write, jump, branch, alu_src, alu_zero_result, jr_control;

    // Instantiating the register file
    RegisterFile #(
        .depth(8),
        .width(16)
    ) register_file (
        .clk(clk), .reset_n(reset_n),
        .write_en(reg_write),
        .write_address((reg_dst == 2'b00) ? (instruction[9:7]) : ((reg_dst == 2'b01) ? (instruction[6:4]) : ('h7))),
        .read_address_1(instruction[12:10]),
        .read_address_2(instruction[9:7]),
        .write_data((mem_to_reg == 2'b00) ? (pc+'d2) : ((mem_to_reg == 2'b01) ? (data_memory_out) : (result))),
        .read_data_1(register_file_out_1),
        .read_data_2(register_file_out_2)
    );

    // Instantiating the instruction memory
    InstructionMemory #(
        .depth(4096),
        .width(16),
        .BPW(2)
    ) instruction_memory (
        .pc(pc),
        .instruction(instruction)
    );

    // Instantiating the control unit
    ControlUnit control_unit (
        .opcode(instruction[15:13]),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .reg_write(reg_write),
        .jump(jump),
        .branch(branch),
        .alu_src(alu_src),
        .alu_op(alu_op),
        .reg_dst(reg_dst),
        .mem_to_reg(mem_to_reg)
    );
    
    // Instantiating the ALU
    ALU #(.N(16)) alu (
        .a(register_file_out_1),
        .b((alu_src == 1'b0) ? (register_file_out_2) : ({{9{instruction[6]}}, instruction[6:0]})),
        .control(alu_selector),
        .result(result),
        .zero(alu_zero_result)
    );

    // Instantiating the ALU control unit
    ALUControlUnit alu_control_unit (
        .alu_op(alu_op),
        .funct(instruction[3:0]),
        .alu_control(alu_selector)
    );

    // Instantiating the data memory
    DataMemory #(
        .depth(256),
        .width(16),
        .BPW(2)
    ) data_memory (
        .clk(clk), .reset_n(reset_n),
        .read_address(result),
        .write_address(result),
        .write_data(register_file_out_2),
        .read_en(mem_read),
        .write_en(mem_write),
        .read_data(data_memory_out)
    );

    // Instantiating the JR control unit
    JrControlUnit jr_control_unit (
        .alu_op(alu_op),
        .funct(instruction[3:0]),
        .jr_control(jr_control)
    );

    always @(posedge clk, negedge reset_n) begin
        if(~reset_n) begin
            pc <= 'd0;
        end
        else begin
            if(jr_control) begin
                pc <= register_file_out_1;
            end
            else begin
                if(jump) begin
                    pc <= pc + 'd2;
                    pc <= {pc[15:14], (instruction[6:0] << 1)};
                end
                else begin
                    if(branch & alu_zero_result) begin
                        pc <= pc + 'd2 + ({{9{instruction[6]}}, instruction[6:0]});
                    end
                    else begin
                        pc <= pc + 'd2;
                    end
                end
            end
        end
    end
    
    assign alu_result = result;
endmodule
