`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/24 17:51:23
// Design Name: 
// Module Name: hw3a_2a_2
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

module hw3a_2a_2(f,x,y,z);
    input x,y,z;
    output f;
     assign f = x | (~y) & z;
endmodule
