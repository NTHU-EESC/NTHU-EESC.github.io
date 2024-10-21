`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/24 16:38:13
// Design Name: 
// Module Name: hw3a_1a_2
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


module hw3a_1a_2(w, x, y, f);
    input w, x, y;    
    output f;
    assign f = (~y) | x & (~w);
endmodule
