`timescale 1ns / 1ps

module DataMemoryTestBench();
    localparam depth=50, width=32, BPW=4;
    reg clk, reset_n;
    reg [$clog2(depth*BPW)-1:0] read_address, write_address;
    reg [width-1:0] write_data;
    reg write_en, read_en;
    wire [width-1:0] read_data;

    // UUT
    DataMemory #(.depth(depth), .width(width), .BPW(BPW)) UUT (
        clk, reset_n,
        read_address, write_address,
        write_data,
        write_en, read_en,
        read_data
    );

    // Clock Generation
    always begin
        clk = 1'b0;
        #10;
        clk = 1'b1;
        #10;
    end

    initial begin
        reset_n = 'b0;
        read_address = 'd0;
        write_address = 'd0;
        write_en = 'd0;
        read_en = 'd0;
        write_data = 'd0;
        #15;
        reset_n = 1'b1;
        @(negedge clk);
        write_data = 'hFAB0;
        write_address = 'd0;
        write_en = 1'd1;
        @(negedge clk);
        write_data = 'hFAB1;
        write_address = 'd4;
        write_en = 1'd1;
        @(negedge clk);
        write_data = 'hFAB2;
        write_address = 'd8;
        write_en = 1'd1;
        @(negedge clk);
        write_data = 'hFAB3;
        write_address = 'd12;
        write_en = 1'd1;
        @(negedge clk);
        write_data = 'hFAB4;
        write_address = 'd16;
        write_en = 1'd1;
        @(negedge clk);
        write_data = 'hFAB5;
        write_address = 'd20;
        write_en = 1'd1;
        @(negedge clk);
        write_en = 1'b0;
        read_en = 1'b1;
        read_address = 'd4;
        #15 read_address = 'd16;
        #15 read_address = 'd20;
        #15 read_address = 'd12;
        #15 $finish;
    end
endmodule
