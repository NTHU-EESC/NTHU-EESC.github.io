`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/28 18:07:58
// Design Name: 
// Module Name: tone_ctl
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


module tone_ctl(
    input clk_100hz,
    input rst_n,
    input do_pulse,
    input re_pulse,
    input mi_pulse,
    input vol_up_pulse,
    input vol_down_pulse,
    output reg [21:0]tone_freq,
    output reg [15:0]vol_pos,
    output reg [15:0]vol_neg,
    output reg [3:0]val_volume
    );
    
    reg [1:0]freq_sel;
    reg [1:0]freq_sel_next;
    reg [3:0]vol_in_next;
    reg [3:0]vol_in;
    
    always @*
        if (do_pulse) freq_sel_next = 2'd1;
        else if (re_pulse) freq_sel_next = 2'd2;
        else if (mi_pulse) freq_sel_next = 2'd3;
        else freq_sel_next = freq_sel;
    always @(posedge clk_100hz or negedge rst_n)
        if (~rst_n) freq_sel <= 2'd1;
        else freq_sel <= freq_sel_next;
    always @*
        case (freq_sel)
            2'd1: tone_freq = 22'd191571;
            2'd2: tone_freq = 22'd170648;
            2'd3: tone_freq = 22'd151515;
            default: tone_freq = 22'd191571;
        endcase
    always @* begin
        if (vol_down_pulse) vol_in_next = val_volume - 4'd1;
        else vol_in_next = val_volume;
        if (vol_up_pulse) vol_in = vol_in_next + 4'd1;
        else vol_in = vol_in_next;
    end
    always @(posedge clk_100hz or negedge rst_n)
        if (~rst_n) val_volume <= 4'd0;
        else val_volume <= vol_in;
    always @* begin
        vol_pos = val_volume * 16'd200;
        vol_neg = ~vol_pos + 16'd1;
    end
        
endmodule
