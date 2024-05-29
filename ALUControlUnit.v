`timescale 1ps/1ps

module ALUControlUnit (
    input [1:0] alu_op,
    input [3:0] funct,
    output reg [2:0] alu_control
);
    always @(*) begin
        casex ({alu_op, funct})
            6'b11xxxx: alu_control = 3'd0;
            6'b01xxxx: alu_control = 3'd1;
            6'b10xxxx: alu_control = 3'd4;
            6'b000000: alu_control = 3'd0;
            6'b000001: alu_control = 3'd1;
            6'b000010: alu_control = 3'd2;
            6'b000011: alu_control = 3'd3;
            6'b000100: alu_control = 3'd4;
            default: alu_control = 3'd0;
        endcase
    end
endmodule
