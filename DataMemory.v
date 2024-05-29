`timescale 1ns / 1ps

module DataMemory #(parameter depth=256, width=16, BPW=2) (
    input clk, reset_n,
    input [$clog2(depth*BPW)-1:0] read_address, write_address,
    input [width-1:0] write_data,
    input write_en, read_en,
    output [width-1:0] read_data
);
    integer i;
    wire [$clog2(depth)-1:0] address_r = read_address >> (BPW / 2);
    wire [$clog2(depth)-1:0] address_w = write_address >> (BPW / 2);
    reg [width-1:0] memory [depth-1:0];

    always @(posedge clk, negedge reset_n) begin
        if(~reset_n) begin
            for(i=0; i<=depth-1; i=i+1) begin
                memory[i] <= 'd0;
            end
        end
        else begin
            if(write_en) begin
                memory[address_w] <= write_data;
            end
        end
    end

    assign read_data = (read_en == 1'b1) ? memory[address_r] : 'd0;
endmodule
