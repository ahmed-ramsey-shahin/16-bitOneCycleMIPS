`timescale 1ns / 1ps

module InstructionMemoryTestBench();
    localparam depth=16, width=16, BPW=2;
    reg [4:0] pc;
    wire [15:0] instruction;
    integer i;

    // UUT
    InstructionMemory #(.depth(depth), .width(16), .BPW(BPW)) UUT (pc, instruction);

    initial begin
        for(i=0; i<32; i=i+2) begin
            pc = i[15:0];
            #15;
        end
        $finish;
    end
endmodule
