`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/11 18:55:22
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


`define FREQ_DIV_BIT 27    // must bigger than divide num /
`define FREQ_DIV_NUM  50000000  // need /2  first
`define FREQ_DIV_CTL_BIT 15
module freq_div(
output reg clk_out, // divided clock output
output reg clk_ctl, // divided clock output for scan freq
input clk, // global clock input
input rst_n // active low reset
);
reg [`FREQ_DIV_CTL_BIT - 3:0] cnt_l; // temp buf of the counter
reg [(`FREQ_DIV_BIT - `FREQ_DIV_CTL_BIT) :0] cnt_h; // temp buf of the counter
reg [`FREQ_DIV_BIT - 1:0] cnt_tmp; // input to dff (in always block)

always @*
    cnt_tmp = {cnt_h,clk_ctl,cnt_l} + 1'b1;

always @(posedge clk or negedge rst_n)
if (~rst_n) begin
    {cnt_h, clk_ctl, cnt_l} <= `FREQ_DIV_BIT'd0;
    clk_out <= 1;
end
else if ( {cnt_h, clk_ctl, cnt_l} >= `FREQ_DIV_NUM )  begin
    {cnt_h, clk_ctl, cnt_l} <= `FREQ_DIV_BIT'd0;
    clk_out <= ~clk_out;
    end
else {cnt_h, clk_ctl, cnt_l} <= cnt_tmp;
endmodule
