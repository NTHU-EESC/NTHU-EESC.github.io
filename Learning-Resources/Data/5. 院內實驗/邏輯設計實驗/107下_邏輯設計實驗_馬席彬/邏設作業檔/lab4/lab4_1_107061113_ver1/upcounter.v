`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/14 21:02:13
// Design Name: 
// Module Name: upcounter
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


module upcounter(
    input globalclk,
    input rst_n,
    output reg [3:0]b
    );
    wire clk;
    
freq_div U0 (.clk(globalclk),.rst_n(rst_n),.clk_out(clk));
always @(posedge clk or negedge rst_n)
    if (~rst_n)  b = 4'd0;
    else b = b + 4'd1;
endmodule
