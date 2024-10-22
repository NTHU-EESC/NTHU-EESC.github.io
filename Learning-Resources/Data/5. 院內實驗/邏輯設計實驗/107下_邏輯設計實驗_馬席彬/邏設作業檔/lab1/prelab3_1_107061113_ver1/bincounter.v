`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/08 08:52:37
// Design Name: 
// Module Name: bincounter
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


module bincounter(
    input rst,
    input clk,
    output reg [3:0]s
    );
reg [3:0]s_tmp;

always @*
    s_tmp = s + 4'd1;
always @ (posedge clk)
    if (~rst) s <= 4'd0;
    else s <= s_tmp;
endmodule
