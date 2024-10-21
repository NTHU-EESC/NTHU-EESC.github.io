`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/24 16:50:53
// Design Name: 
// Module Name: hw_3a_1b_1
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


module hw3a_1b_1(f,w,x,y,z);
    input w,x,y,z;
    output f;
   assign f = ~(x & (y |(~y) & (z | w)));
endmodule
