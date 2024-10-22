`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/14 20:36:09
// Design Name: 
// Module Name: freq_div
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


`define FREQ_DIV_BIT 26
`define FREQ_DIV_100_NUM 20000  //  divide 2 first
module freq_div_100(
output reg clk_out, // divided clock output
input clk, // global clock input
input rst_n // active low reset
);
reg [`FREQ_DIV_BIT-1:0] clk_rec; // count numbers
reg [`FREQ_DIV_BIT-1:0] cnt_tmp; // input to dff (in always block)
// Combinational logics: increment, neglecting overflow

always @*    cnt_tmp <= clk_rec + 1'b1;

always @(posedge clk or negedge rst_n)
    if (~rst_n) begin
        clk_rec <= `FREQ_DIV_BIT'd0;
        clk_out <= 1'd0;
    end
    else if (clk_rec >= `FREQ_DIV_100_NUM)  begin
        clk_rec <= `FREQ_DIV_BIT'd0;
        clk_out <= (~clk_out);
    end
    else clk_rec <= cnt_tmp;

endmodule
