`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/27 13:54:28
// Design Name: 
// Module Name: speaker_ctl
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


module speaker_ctl(
    input [15:0]audio_left,
    input [15:0]audio_right,
    input clk_100mhz,
    input rst_n,
    output audio_mclk,
    output audio_lrck,
    output audio_sck,
    output reg audio_sdin
    );
    wire clk_25mdiv4hz;
    reg [4:0]audio_cnt;
    reg [4:0]audio_cnt_next;
    reg audio_sdin_next;
    
    assign audio_sck = clk_25mdiv4hz;
    clk_divider clk_m (.clk_100mhz(clk_100mhz),.rst_n(rst_n)
                       ,.clk_25mdiv4hz(clk_25mdiv4hz),.clk_25mhz(audio_mclk),.clk_25mdiv128hz(audio_lrck));
    always @(negedge clk_25mdiv4hz or negedge rst_n)
        if (~rst_n) audio_cnt <= 5'd30;
        else audio_cnt <= audio_cnt_next;
    always @*
        if (audio_cnt >= 5'd31) audio_cnt_next = 5'd0;
        else audio_cnt_next = audio_cnt + 5'd1;
    always @*
        case (audio_cnt)
            5'd0: audio_sdin_next = audio_left[15];
            5'd1: audio_sdin_next = audio_left[14];
            5'd2: audio_sdin_next = audio_left[13];
            5'd3: audio_sdin_next = audio_left[12];
            5'd4: audio_sdin_next = audio_left[11];
            5'd5: audio_sdin_next = audio_left[10];
            5'd6: audio_sdin_next = audio_left[9];
            5'd7: audio_sdin_next = audio_left[8];
            5'd8: audio_sdin_next = audio_left[7];
            5'd9: audio_sdin_next = audio_left[6];
            5'd10: audio_sdin_next = audio_left[5];
            5'd11: audio_sdin_next = audio_left[4];
            5'd12: audio_sdin_next = audio_left[3];
            5'd13: audio_sdin_next = audio_left[2];
            5'd14: audio_sdin_next = audio_left[1];
            5'd15: audio_sdin_next = audio_left[0];
            5'd16: audio_sdin_next = audio_right[15];
            5'd17: audio_sdin_next = audio_right[14];
            5'd18: audio_sdin_next = audio_right[13];
            5'd19: audio_sdin_next = audio_right[12];
            5'd20: audio_sdin_next = audio_right[11];
            5'd21: audio_sdin_next = audio_right[10];
            5'd22: audio_sdin_next = audio_right[9];
            5'd23: audio_sdin_next = audio_right[8];
            5'd24: audio_sdin_next = audio_right[7];
            5'd25: audio_sdin_next = audio_right[6];
            5'd26: audio_sdin_next = audio_right[5];
            5'd27: audio_sdin_next = audio_right[4];
            5'd28: audio_sdin_next = audio_right[3];
            5'd29: audio_sdin_next = audio_right[2];
            5'd30: audio_sdin_next = audio_right[1];
            5'd31: audio_sdin_next = audio_right[0];
        endcase
    always @*
        if (~rst_n) audio_sdin = 1'd0;
        else audio_sdin = audio_sdin_next;
endmodule
