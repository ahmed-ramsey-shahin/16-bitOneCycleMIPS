`timescale 1ns / 1ps

module InstructionMemory #(parameter depth=4096, width=16, BPW=2) (
    input [$clog2(depth*BPW)-1:0] pc,
    output [width-1:0] instruction
);
    reg [width-1:0] rom [depth-1:0];
    wire [$clog2(depth)-1:0] address = pc >> (BPW / 2);
    initial begin
        $readmemb("instructions.mem", rom);
    end
    assign instruction = rom[address];
endmodule
