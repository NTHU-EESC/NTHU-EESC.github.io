`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/24 16:24:08
// Design Name: 
// Module Name: hw3a_1a_1
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


module hw3a_1a_1(f, w, x, y, z);
   output f;
   input w, x, y, z;
   assign f = ~(((~x) | w) & y | w & y & z | (~x) & z & (x | y));
endmodule