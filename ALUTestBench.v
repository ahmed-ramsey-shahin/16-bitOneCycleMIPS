`timescale 1ns / 1ps

module ALUTestBench();
    localparam N = 8;
    reg [N-1:0] a, b;
    reg [2:0] selector;
    wire [N-1:0] alu_output;
    wire zero;
    integer i;

    // UUT
    ALU #(N) UUT (a, b, selector, alu_output, zero);

    initial begin
        a = 8'h02;
        b = 8'h02;
        selector = 4'd0;
        for(i = 0; i < 8; i=i+1) begin
            #10;
            selector = selector + 1'b1;
        end
        $finish;
    end
endmodule
