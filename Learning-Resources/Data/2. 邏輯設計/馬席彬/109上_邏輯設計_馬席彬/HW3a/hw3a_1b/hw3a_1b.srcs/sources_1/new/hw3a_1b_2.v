`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/24 17:21:24
// Design Name: 
// Module Name: hw3a_1b_2
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


module hw3a_1b_2(f,w,x,y,z);
   input w,x,y,z;
   output f;
  assign f = (~x) | (~(w | y | z)) ;

endmodule
