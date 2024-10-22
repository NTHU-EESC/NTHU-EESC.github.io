`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/24 15:11:05
// Design Name: 
// Module Name: freq_div_1
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
`define FREQ_DIV_1_NUM 50000000  //  divide 2 first
module freq_div_1(
output reg clk_out, // divided clock output
input clk, // global clock input
input rst_p // active low reset
);
reg [`FREQ_DIV_BIT-1:0] clk_rec; // count numbers
reg [`FREQ_DIV_BIT-1:0] cnt_tmp; // input to dff (in always block)
// Combinational logics: increment, neglecting overflow

always @*    cnt_tmp <= clk_rec + 1'b1;

always @(posedge clk or posedge rst_p)
    if (rst_p) begin
        clk_rec <= `FREQ_DIV_BIT'd0;
        clk_out <= 1'd0;
    end
    else if (clk_rec >= `FREQ_DIV_1_NUM)  begin
        clk_rec <= `FREQ_DIV_BIT'd0;
        clk_out <= (~clk_out);
    end
    else clk_rec <= cnt_tmp;

endmodule
