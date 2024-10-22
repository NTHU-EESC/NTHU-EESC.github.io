`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/17 19:13:24
// Design Name: 
// Module Name: dec_to_bin
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


module dec_to_bin(
    input [3:0]digit1,
    input [3:0]digit0,
    output [7:0]bin
    );
    assign bin = digit1 * 4'd10 + digit0;
endmodule
