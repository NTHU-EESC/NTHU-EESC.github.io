`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/09 10:42:22
// Design Name: 
// Module Name: fredivider
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


`define FREQ_DIV_BIT 27
module freq_div27(
output reg clk_out, // divided clock output
input clk, // global clock input
input rst_n // active low reset
);
reg [`FREQ_DIV_BIT-2:0] clk_rec; // count numbers
reg [`FREQ_DIV_BIT-1:0] cnt_tmp; // input to dff (in always block)
// Combinational logics: increment, neglecting overflow
always @*
cnt_tmp = {clk_out,clk_rec} + 1'b1;
// Sequential logics: Flip flops
always @(posedge clk or negedge rst_n)
if (~rst_n) {clk_out,clk_rec} <= `FREQ_DIV_BIT'd0;
else {clk_out,clk_rec} <= cnt_tmp;
endmodule
