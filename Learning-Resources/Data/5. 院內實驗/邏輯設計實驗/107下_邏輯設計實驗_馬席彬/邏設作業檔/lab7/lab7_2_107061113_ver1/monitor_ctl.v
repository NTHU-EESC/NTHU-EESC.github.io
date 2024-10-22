`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/24 08:44:42
// Design Name: 
// Module Name: monitor_ctl
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

`define FREQ_DIV_SEG_BIT  14
module monitor_ctl(
    input [3:0]digit3,
    input [3:0]digit2,
    input [3:0]digit1,
    input [3:0]digit0,
    input dot,
    input clk,
    input rst_n,
    output reg [3:0]dis,
    output [7:0]segs
    );
    
    reg [3:0]bin_next;
    reg [`FREQ_DIV_SEG_BIT - 3:0] clk_rec;
    reg [`FREQ_DIV_SEG_BIT - 1:0] cnt_tmp;
    reg [1:0]clk_out;
    reg [3:0]bin_out;
    
    display display_0 (.bin(bin_out),.dot(dot),.segs(segs));
    
    always @*
    cnt_tmp = {clk_out,clk_rec} + 1'b1;
    // Sequential logics: Flip flops
    always @(posedge clk or negedge rst_n)
    if (~rst_n) {clk_out,clk_rec} <= `FREQ_DIV_SEG_BIT'd0;
    else {clk_out,clk_rec} <= cnt_tmp;
    
    always @*
        case (clk_out)
            2'b00:  begin
                dis <= 4'b0111;
                bin_next <= digit3;
                end
            2'b01:  begin
                dis <= 4'b1011;
                bin_next <= digit2;
                end
            2'b10:  begin
                dis <= 4'b1101;
                bin_next <= digit1;
                end
            2'b11:  begin
                dis <= 4'b1110;
                bin_next <= digit0;
                end
            default:  begin
                dis <= 4'b0000;
                bin_next <= 4'b0000;
                end
        endcase
    always @*
        bin_out <= bin_next;
endmodule

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

