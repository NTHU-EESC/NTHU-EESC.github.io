`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/27 13:54:28
// Design Name: 
// Module Name: buzzing_ctl
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


module buzzing_ctl(
    input clk_100mhz,
    input rst_n,
    input [21:0]note_div_right,
    input [21:0]note_div_left,
    input [3:0]letter,
    output reg [15:0]audio_left,
    output reg [15:0]audio_right
    );

    reg [15:0]audio_right_next;
    reg [15:0]audio_left_next;
    reg [21:0]cnt_right;
    reg [21:0]cnt_left;
    reg [21:0]cnt_right_next;
    reg [21:0]cnt_left_next;
    reg ampli_right;
    reg ampli_right_next;
    reg ampli_left;
    reg ampli_left_next;
    
    always @*
        if (cnt_right >= note_div_right) begin
            cnt_right_next = 22'd0;
            ampli_right_next = ~ampli_right;
        end
        else begin
            cnt_right_next = cnt_right + 22'd1;
            ampli_right_next = ampli_right;
        end
    always @(posedge clk_100mhz or negedge rst_n)
        if (~rst_n) cnt_right = 22'd0;
        else cnt_right <= cnt_right_next;
        
    always @(posedge clk_100mhz or negedge rst_n)
        if (~rst_n) ampli_right <= 1'd0;
        else ampli_right <= ampli_right_next;
        
    always @*
        if (cnt_left >= note_div_left) begin
            cnt_left_next = 22'd0;
            ampli_left_next = ~ampli_left;
        end
        else begin
            cnt_left_next = cnt_left + 22'd1;
            ampli_left_next = ampli_left;
        end
    always @(posedge clk_100mhz or negedge rst_n)
        if (~rst_n) cnt_left = 22'd0;
        else cnt_left <= cnt_left_next;      
    always @(posedge clk_100mhz or negedge rst_n)
        if (~rst_n) ampli_left <= 1'd0;
        else ampli_left <= ampli_left_next;
        
    always @*
        if (ampli_right) audio_right_next = 16'h1FFF;
        else audio_right_next = 16'hE000;
    always @*
        if (ampli_left) audio_left_next = 16'h1FFF;
        else audio_left_next = 16'hE000;
        
    always @*
        if (letter == 4'd0) begin
            audio_right = 16'h0;
         	audio_left = 16'h0;
        end
        else begin
            audio_right = audio_right_next;
            audio_left = audio_left_next;
        end
        
endmodule
