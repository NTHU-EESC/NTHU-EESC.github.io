`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/27 13:25:34
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
    input rst_n,  //switch rst
    input pb_do,
    input pb_re,
    input pb_mi,
    input pb_vol_up,
    input pb_vol_down,
    output audio_mclk,
    output audio_lrck,
    output audio_sck,
    output audio_sdin,
    output [3:0]dis,
    output [7:0]segs
    );
    wire [15:0]audio_left;
    wire [15:0]audio_right;
    wire clk_100hz;
    wire do_debounced;
    wire re_debounced;
    wire mi_debounced;
    wire vol_up_debounced;
    wire vol_down_debounced;
    wire do_pulse;
    wire re_pulse;
    wire mi_pulse;
    wire vol_up_pulse;
    wire vol_down_pulse;
    wire [21:0]tone_freq;
    wire [15:0]vol_pos;
    wire [15:0]vol_neg;
    wire [3:0]val_volume;
    wire [3:0]val_volume_digit[1:0];
    freq_div_100 clk100 (.clk(clk_100mhz),.rst_n(rst_n),.clk_out(clk_100hz));
    debounce A0 (.pb_in(pb_do),.rst_n(rst_n),.clk(clk_100hz),.pb_debounced(do_debounced));
    debounce A1 (.pb_in(pb_re),.rst_n(rst_n),.clk(clk_100hz),.pb_debounced(re_debounced));
    debounce A2 (.pb_in(pb_mi),.rst_n(rst_n),.clk(clk_100hz),.pb_debounced(mi_debounced));
    debounce A3 (.pb_in(pb_vol_up),.rst_n(rst_n),.clk(clk_100hz),.pb_debounced(vol_up_debounced));
    debounce A4 (.pb_in(pb_vol_down),.rst_n(rst_n),.clk(clk_100hz),.pb_debounced(vol_down_debounced));
    one_pulse B0 (.in_trig(do_debounced),.clk(clk_100hz),.rst_n(rst_n),.one_pulse(do_pulse));
    one_pulse B1 (.in_trig(re_debounced),.clk(clk_100hz),.rst_n(rst_n),.one_pulse(re_pulse));
    one_pulse B2 (.in_trig(mi_debounced),.clk(clk_100hz),.rst_n(rst_n),.one_pulse(mi_pulse));
    one_pulse B3 (.in_trig(vol_up_debounced),.clk(clk_100hz),.rst_n(rst_n),.one_pulse(vol_up_pulse));
    one_pulse B4 (.in_trig(vol_down_debounced),.clk(clk_100hz),.rst_n(rst_n),.one_pulse(vol_down_pulse));
    tone_ctl U0 (.clk_100hz(clk_100hz),.rst_n(rst_n),.do_pulse(do_pulse),.re_pulse(re_pulse),.mi_pulse(mi_pulse)
                 ,.vol_up_pulse(vol_up_pulse),.vol_down_pulse(vol_down_pulse)
                 ,.tone_freq(tone_freq),.vol_pos(vol_pos),.vol_neg(vol_neg),.val_volume(val_volume));
    buzzing_ctl U1 (.clk_100mhz(clk_100mhz),.rst_n(rst_n),.note_div(tone_freq)  // note do
                    ,.vol_pos(vol_pos),.vol_neg(vol_neg),.audio_left(audio_left),.audio_right(audio_right));
    speaker_ctl U2 (.clk_100mhz(clk_100mhz),.rst_n(rst_n),.audio_left(audio_left),.audio_right(audio_right)
                    ,.audio_mclk(audio_mclk),.audio_lrck(audio_lrck),.audio_sck(audio_sck),.audio_sdin(audio_sdin));
    bin_to_dec_5bit U3 (.bin(val_volume),.digit1(val_volume_digit[1]),.digit0(val_volume_digit[0]));
    monitor_ctl display (.digit3(4'd0),.digit2(4'd0),.digit1(val_volume_digit[1]),.digit0(val_volume_digit[0])
                         ,.clk(clk_100mhz),.dot(1'd0),.rst_n(rst_n),.dis(dis),.segs(segs));
endmodule
