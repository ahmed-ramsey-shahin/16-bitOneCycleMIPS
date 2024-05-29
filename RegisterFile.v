`timescale 1ns / 1ps

module RegisterFile #(parameter depth=8, width=16) (
    input clk, reset_n,
    input write_en,
    input [$clog2(depth)-1:0] write_address, read_address_1, read_address_2,
    input [width-1:0] write_data,
    output [width-1:0] read_data_1, read_data_2
);
    reg [width-1:0] reg_file [depth-1:0];
    integer i;
    
    always @(posedge clk, negedge reset_n) begin
        if(~reset_n) begin
            for(i = 0; i < depth; i=i+1) begin
                reg_file[i] <= 'b0;
            end
        end
        else begin
            if(write_en) begin
                if(write_address != 'd0) begin
                    reg_file[write_address] <= write_data;
                end
            end
        end
    end

    assign read_data_1 = (read_address_1 == 0) ? 'b0 : reg_file[read_address_1];
    assign read_data_2 = (read_address_2 == 0) ? 'b0 : reg_file[read_address_2];
endmodule
