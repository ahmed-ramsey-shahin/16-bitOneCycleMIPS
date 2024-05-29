`timescale 1ns / 1ps

module RegisterFileTestBench();
    // inputs and outputs
    localparam depth = 32, width=16;
    reg clk, reset_n, write_en;
    reg [$clog2(depth)-1:0] write_address, read_address_1, read_address_2;
    reg [width-1:0] write_data;
    wire [width-1:0] read_data_1, read_data_2;

    // UUT
    RegisterFile #(.depth(32), .width(16)) UUT (
        clk, reset_n, write_en,
        write_address, read_address_1, read_address_2,
        write_data,
        read_data_1, read_data_2
    );

    // clock generation
    always begin
        clk = 1'b0;
        #10;
        clk = 1'b1;
        #10;
    end

    initial begin
        reset_n = 1'b0;
        write_en = 1'b0;
        write_address = 'h0;
        read_address_1 = 'h0;
        read_address_2 = 'h0;
        write_data = 'h0;
        #2;
        reset_n = 1'b1;
        #2;
        @(negedge clk);
        write_data = 16'hFA0;
        write_address = 8'h01;
        write_en = 1'b1;
        @(negedge clk);
        write_data = 16'hFA1;
        write_address = 8'h02;
        write_en = 1'b1;
        @(negedge clk);
        write_data = 16'hFA2;
        write_address = 8'h03;
        write_en = 1'b1;
        @(negedge clk);
        write_data = 16'hFA3;
        write_address = 8'h04;
        write_en = 1'b1;
        @(negedge clk);
        write_en = 1'b0;
        read_address_1 = 8'h00;
        read_address_2 = 8'h01;
        #5;
        read_address_1 = 8'h02;
        read_address_2 = 8'h03;
        #10;
        read_address_1 = 8'h04;
        read_address_2 = 8'h00;
        #15;
        $finish;
    end
endmodule
