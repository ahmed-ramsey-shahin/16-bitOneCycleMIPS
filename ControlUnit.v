`timescale 1ps/1ps

module ControlUnit (
    input [2:0] opcode,
    output reg mem_read, mem_write, reg_write, jump, branch, alu_src,
    output reg [1:0] alu_op, reg_dst, mem_to_reg
);
    always @(*) begin
        case(opcode)
            3'b000: begin // add
                alu_op = 2'b00;
                reg_dst = 2'b01;
                mem_to_reg = 2'b10;
                mem_read = 1'b0;
                mem_write = 1'b0;
                reg_write = 1'b1;
                jump = 1'b0;
                branch = 1'b0;
                alu_src = 1'b0;
            end
            3'b001: begin // slti
                alu_op = 2'b10;
                reg_dst = 2'b00;
                mem_to_reg = 2'b10;
                mem_read = 1'b0;
                mem_write = 1'b0;
                reg_write = 1'b1;
                jump = 1'b0;
                branch = 1'b0;
                alu_src = 1'b1;
            end
            3'b010: begin // j
                alu_op = 2'b11;
                reg_dst = 2'b00;
                mem_to_reg = 2'b00;
                mem_read = 1'b0;
                mem_write = 1'b0;
                reg_write = 1'b0;
                jump = 1'b1;
                branch = 1'b0;
                alu_src = 1'b0;
            end
            3'b011: begin // jal
                alu_op = 2'b11;
                reg_dst = 2'b10;
                mem_to_reg = 2'b00;
                mem_read = 1'b0;
                mem_write = 1'b0;
                reg_write = 1'b1;
                jump = 1'b1;
                branch = 1'b0;
                alu_src = 1'b0;
            end
            3'b100: begin // lw
                alu_op = 2'b11;
                reg_dst = 2'b00;
                mem_to_reg = 2'b01;
                mem_read = 1'b1;
                mem_write = 1'b0;
                reg_write = 1'b1;
                jump = 1'b0;
                branch = 1'b0;
                alu_src = 1'b1;
            end
            3'b101: begin // sw
                alu_op = 2'b11;
                reg_dst = 2'b00;
                mem_to_reg = 2'b00;
                mem_read = 1'b0;
                mem_write = 1'b1;
                reg_write = 1'b0;
                jump = 1'b0;
                branch = 1'b0;
                alu_src = 1'b1;
            end
            3'b110: begin // beq
                alu_op = 2'b01;
                reg_dst = 2'b00;
                mem_to_reg = 2'b00;
                mem_read = 1'b0;
                mem_write = 1'b0;
                reg_write = 1'b0;
                jump = 1'b0;
                branch = 1'b1;
                alu_src = 1'b0;
            end
            3'b111: begin // addi
                alu_op = 2'b11;
                reg_dst = 2'b00;
                mem_to_reg = 2'b10;
                mem_read = 1'b0;
                mem_write = 1'b0;
                reg_write = 1'b1;
                jump = 1'b0;
                branch = 1'b0;
                alu_src = 1'b1;
            end
            default: begin
                alu_op = 2'b01;
                reg_dst = 2'b00;
                mem_to_reg = 2'b00;
                mem_read = 1'b0;
                mem_write = 1'b0;
                reg_write = 1'b0;
                jump = 1'b0;
                branch = 1'b1;
                alu_src = 1'b0;
            end
        endcase
    end
endmodule
