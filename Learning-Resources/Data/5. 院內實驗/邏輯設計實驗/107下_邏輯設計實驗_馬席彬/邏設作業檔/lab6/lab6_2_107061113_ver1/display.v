`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/14 21:26:21
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


    `define SS_0 8'b0000001
    `define SS_1 8'b1001111
    `define SS_2 8'b0010010
    `define SS_3 8'b0000110
    `define SS_4 8'b1001100
    `define SS_5 8'b0100100
    `define SS_6 8'b0100000
    `define SS_7 8'b0001111
    `define SS_8 8'b0000000
    `define SS_9 8'b0000100
    `define SS_A 8'b0001000
    `define SS_b 8'b1100000
    `define SS_C 8'b0110001
    `define SS_d 8'b1000010
    `define SS_E 8'b0110000
    `define SS_F 8'b0111000
    
module display(
    input [3:0]bin,
    input dot,
    output reg [7:0]segs
    ); 
always @*  begin
    case (bin)
        4'd0: segs[7:1] <= `SS_0;
        4'd1: segs[7:1] <= `SS_1;
        4'd2: segs[7:1] <= `SS_2;
        4'd3: segs[7:1] <= `SS_3;
        4'd4: segs[7:1] <= `SS_4;
        4'd5: segs[7:1] <= `SS_5;
        4'd6: segs[7:1] <= `SS_6;
        4'd7: segs[7:1] <= `SS_7;
        4'd8: segs[7:1] <= `SS_8;
        4'd9: segs[7:1] <= `SS_9;
        4'd10: segs[7:1] <= `SS_A;
        4'd11: segs[7:1] <= `SS_b;
        4'd12: segs[7:1] <= `SS_C;
        4'd13: segs[7:1] <= `SS_d;
        4'd14: segs[7:1] <= `SS_E;
        4'd15: segs[7:1] <= `SS_F;
        default: segs[7:1] <= 7'b0000000;
    endcase
     
        if (dot) segs[0] <= 1'd0;
        else segs[0] <= 1'd1;
    end
endmodule
