`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/24 18:06:25
// Design Name: 
// Module Name: hw3a_2b_2
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


module hw3a_2b_2(f, x, y, z);
    input x, y, z;
     output f;
  assign f = (x | z) & (x | (~y));
endmodule
