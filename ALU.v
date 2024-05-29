`timescale 1ns / 1ps

module ALU #(parameter N=16) (
    input [N-1:0] a, b,
    input [2:0] control,
    output reg [N-1:0] result,
    output zero
);
    always @(*) begin
        case(control)
            3'd0: result = a + b;
            3'd1: result = a - b;
            3'd2: result = a & b;
            3'd3: result = a | b;
            3'd4: result = ((a < b) ? 'd1 : 'd0);
            default: result = a + b;
        endcase
    end

    assign zero = ((result == 'd0) ? 1'b1 : 1'b0);
endmodule
