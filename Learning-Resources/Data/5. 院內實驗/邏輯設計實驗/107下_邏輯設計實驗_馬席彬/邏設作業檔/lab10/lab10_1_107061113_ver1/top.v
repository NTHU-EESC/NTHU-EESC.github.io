`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/26 09:01:48
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
    input rst_n,
    output audio_mclk,
    output audio_lrck,
    output audio_sck,
    output audio_sdin
    );
    
    wire clk_1hz;
    reg [3:0]tone_ctl;
    reg [3:0]tone_ctl_next;
    reg [21:0]note_div;  // 100m/frequency
    wire [15:0]audio_left;
    wire [15:0]audio_right;
    
    freq_div_1 clk1 (.clk(clk_100mhz),.rst_n(rst_n),.clk_out(clk_1hz));
    
    always @ (posedge clk_1hz or negedge rst_n)
        if (~rst_n) tone_ctl <= 4'd0;
        else tone_ctl <= tone_ctl_next;
    always @*
        if (tone_ctl >= 4'd13) tone_ctl_next = 4'd0;
        else tone_ctl_next = tone_ctl + 4'd1;
    always @*
        case (tone_ctl)
            4'd0: note_div = 22'd191571;
            4'd1: note_div = 22'd170648;
            4'd2: note_div = 22'd151515;
            4'd3: note_div = 22'd143266;
            4'd4: note_div = 22'd127551;
            4'd5: note_div = 22'd113636;
            4'd6: note_div = 22'd101215;
            4'd7: note_div = 22'd95420;
            4'd8: note_div = 22'd85034;
            4'd9: note_div = 22'd75758;
            4'd10: note_div = 22'd71633;
            4'd11: note_div = 22'd63776;
            4'd12: note_div = 22'd56818;
            4'd13: note_div = 22'd50607;
            default: note_div = 22'd500000;
        endcase
    
    buzzing_ctl U1 (.clk_100mhz(clk_100mhz),.rst_n(rst_n),.note_div(note_div)  // note do
                    ,.audio_left(audio_left),.audio_right(audio_right));
    speaker_ctl U2 (.clk_100mhz(clk_100mhz),.rst_n(rst_n),.audio_left(audio_left),.audio_right(audio_right)
                    ,.audio_mclk(audio_mclk),.audio_lrck(audio_lrck),.audio_sck(audio_sck),.audio_sdin(audio_sdin));
endmodule
