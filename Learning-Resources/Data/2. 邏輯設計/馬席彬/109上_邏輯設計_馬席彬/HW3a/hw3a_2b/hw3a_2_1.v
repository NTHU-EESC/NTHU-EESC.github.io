`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/24 17:55:00
// Design Name: 
// Module Name: hw3a_2_1
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


module hw3a_2_1(f,x,y,z);
    input x,y,z;
    output f;
  assign f =( x &(~y)) | ( (~y) & z) | ( x & z ) | ( x & y & (~z));
endmodule
