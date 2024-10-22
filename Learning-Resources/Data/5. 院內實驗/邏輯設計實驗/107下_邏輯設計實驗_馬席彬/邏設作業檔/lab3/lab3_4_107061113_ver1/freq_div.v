`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/09 16:18:34
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


`define FREQ_DIV_BIT 27
module freq_div27(
output reg clk_out, // divided clock output
output reg clk_ctl, // divided clock output for scan freq
input clk, // global clock input
input rst_n // active low reset
);

reg [14:0] cnt_l; // temp buf of the counter
reg [8:0] cnt_h; // temp buf of the counter
reg [`FREQ_DIV_BIT-2:0] cnt_tmp; // input to dff (in always block)
// Combinational logics: increment, neglecting overflow
always @*
cnt_tmp = {clk_out,cnt_h,clk_ctl,cnt_l} + 1'b1;
// Sequential logics: Flip flops
always @(posedge clk or negedge rst_n)
if (~rst_n) {clk_out, cnt_h, clk_ctl, cnt_l}<=`FREQ_DIV_BIT'd0;
else {clk_out,cnt_h, clk_ctl, cnt_l}<=cnt_tmp;

endmodule
