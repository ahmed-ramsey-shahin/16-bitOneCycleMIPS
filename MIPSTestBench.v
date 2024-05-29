`timescale 1ns / 1ps

module MIPSTestBench();
    reg clk, reset_n;
    wire [15:0] pc, result;
    
    //UUT
    MIPS processor (
        .clk(clk), .reset_n(reset_n),
        .pc(pc), .alu_result(result)
    );

    // Clock generation
    always begin
        clk = 1'b0;
        #10;
        clk = 1'b1;
        #10;
    end

    initial begin
        reset_n = 1'b0;
        #2;
        reset_n = 1'b1;
        repeat(20) @(negedge clk);
        $finish;
    end
endmodule
