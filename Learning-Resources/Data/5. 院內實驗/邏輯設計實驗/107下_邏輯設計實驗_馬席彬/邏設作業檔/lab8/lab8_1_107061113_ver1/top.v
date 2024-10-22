`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/29 13:39:10
// Design Name: 
// Module Name: top
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


module top(
    input clk_100mhz,
    input sw_rst,
    output audio_mclk,
    output audio_lrck,
    output audio_sck,
    output audio_sdin
    );
    
    wire [15:0]audio_left;
    wire [15:0]audio_right;
    wire [15:0]vol_pos;
    wire [15:0]vol_neg;
    wire [21:0]tone_freq;
    assign tone_freq = 22'd151515;
    assign vol_pos = 16'h7000;
    assign vol_neg = 16'h8FFF;
    buzzing_ctl U1 (.clk_100mhz(clk_100mhz),.rst_n(sw_rst),.note_div(tone_freq)  // note do
                    ,.vol_pos(vol_pos),.vol_neg(vol_neg),.audio_left(audio_left),.audio_right(audio_right));
    speaker_ctl U2 (.clk_100mhz(clk_100mhz),.rst_n(sw_rst),.audio_left(audio_left),.audio_right(audio_right)
                     ,.audio_mclk(audio_mclk),.audio_lrck(audio_lrck),.audio_sck(audio_sck),.audio_sdin(audio_sdin));
endmodule
