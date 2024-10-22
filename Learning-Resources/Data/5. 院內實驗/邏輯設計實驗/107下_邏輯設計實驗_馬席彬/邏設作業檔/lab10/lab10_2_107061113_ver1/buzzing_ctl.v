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
    input [21:0]note_div,
    input [3:0]letter,
    output reg [15:0]audio_left,
    output reg [15:0]audio_right
    );
    
    reg [15:0]audio_right_next;
    reg [15:0]audio_left_next;
    reg [21:0]clk_cnt;
    reg [21:0]cnt_next;
    reg ampli_next;
    reg ampli;
    
    always @*
        if (clk_cnt >= note_div) begin
            cnt_next = 22'd0;
            ampli_next = ~ampli;
        end
        else begin
            cnt_next = clk_cnt + 22'd1;
            ampli_next = ampli;
        end
    always @(posedge clk_100mhz or negedge rst_n)
        if (~rst_n) clk_cnt = 22'd0;
        else clk_cnt <= cnt_next;
        
    always @(posedge clk_100mhz or negedge rst_n)
        if (~rst_n) ampli <= 1'd0;
        else ampli <= ampli_next;
    always @*
        if (ampli) begin
            audio_right_next = 16'h1FFF;
            audio_left_next = 16'h1FFF;
        end
        else begin
            audio_right_next = 16'hE000;
            audio_left_next = 16'hE000;
        end
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
