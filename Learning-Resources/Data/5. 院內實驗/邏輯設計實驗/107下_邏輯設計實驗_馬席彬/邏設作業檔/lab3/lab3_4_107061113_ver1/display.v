`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/09 20:41:18
// Design Name: 
// Module Name: display
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


module display(
    input [2:0]bin,
    output reg [7:0]seg
    );
always @*
    case (bin)
        3'd1:  seg <= 8'b11010101;
        3'd2:  seg <= 8'b11100001;
        3'd3:  seg <= 8'b10010001;
        3'd4:  seg <= 8'b10000011;
        3'd5:  seg <= 8'b01100001;
        3'd6:  seg <= 8'b01100001;
        default:  seg <= 8'b00000000;
    endcase
endmodule
