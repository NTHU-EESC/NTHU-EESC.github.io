`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/14 21:24:24
// Design Name: 
// Module Name: bcdupcounter
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


module bcdupcounter(
    input globalclk,
    input rst_n,
    output [7:0]seg
    );
    reg [3:0]b;
    wire clk;
freq_div U0 (.clk(globalclk),.rst_n(rst_n),.clk_out(clk));
display U1 (.bin(b),.segs(seg));
always @ ( posedge clk or negedge rst_n)
    if (~rst_n)  b = 4'd0;
    else if ( b >= 4'd9) b = 4'd0;
    else b = b + 4'd1;
endmodule
