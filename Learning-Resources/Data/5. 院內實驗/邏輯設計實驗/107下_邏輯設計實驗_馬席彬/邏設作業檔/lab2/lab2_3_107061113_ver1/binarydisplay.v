`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/04 10:40:25
// Design Name: 
// Module Name: bcddisplay
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


module bcddisplay(
    input [3:0]i,
    output [7:0]D_ssd,
    output [3:0]d
    );
    
display U0 (.bin(i), .segs(D_ssd));
assign d = i;
endmodule