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
    inout PS2_DATA,
    inout PS2_CLK,
    input clk_100mhz,
    input rst_n,
    output audio_mclk,
    output audio_lrck,
    output audio_sck,
    output audio_sdin,
    output [3:0]dis,
    output [7:0]segs
    );
    
    wire [511:0] key_down;
    wire [8:0] last_change;
    wire key_valid;
    wire rst_p;
    wire [3:0]key_in;
    wire caps_valid;
    wire mode_caps;
    reg uppercase;
    reg [3:0]letter;
    reg [21:0]note_div;  // 100m/frequency
    wire [15:0]audio_left;
    wire [15:0]audio_right;
    wire [3:0]letter_digit[3:0];

    assign rst_p = ~rst_n;
    KeyboardDecoder U0 (.PS2_DATA(PS2_DATA),.PS2_CLK(PS2_CLK),.rst(rst_p),.clk(clk_100mhz)
                        ,.key_down(key_down),.last_change(last_change),.key_valid(key_valid));  
    letter_valid U2 (.clk(clk_100mhz),.rst_n(rst_n),.keys({6'd0,key_down[88]}) ,.one_pulse(caps_valid));
    pb_decoder U3 (.keys({key_down[28],key_down[50],key_down[33],key_down[35], 
                          key_down[36],key_down[43],key_down[52]}) ,.key_in(key_in));
    FSM_caps U4 (.clk(clk_100mhz) ,.rst_n(rst_n) ,.caps_valid(caps_valid) ,.mode_caps(mode_caps));
    
    always @*
        if  (key_down[18]) uppercase = ~mode_caps;
        else uppercase = mode_caps;
        
    always @*
        if  (key_in != 4'd0 && uppercase) letter = key_in + 4'd7;
        else letter = key_in;
        
    always @*
        case (letter)
            4'd1: note_div = 22'd191571;
            4'd2: note_div = 22'd170648;
            4'd3: note_div = 22'd151515;
            4'd4: note_div = 22'd143266;
            4'd5: note_div = 22'd127551;
            4'd6: note_div = 22'd113636;
            4'd7: note_div = 22'd101215;
            4'd8: note_div = 22'd95420;
            4'd9: note_div = 22'd85034;
            4'd10: note_div = 22'd75758;
            4'd11: note_div = 22'd71633;
            4'd12: note_div = 22'd63776;
            4'd13: note_div = 22'd56818;
            4'd14: note_div = 22'd50607;
            default: note_div = 22'd500000;
        endcase
    
    buzzing_ctl S1 (.clk_100mhz(clk_100mhz),.rst_n(rst_n),.note_div(note_div),.letter(letter)
                    ,.audio_left(audio_left),.audio_right(audio_right));
    speaker_ctl S2 (.clk_100mhz(clk_100mhz),.rst_n(rst_n),.audio_left(audio_left),.audio_right(audio_right)
                    ,.audio_mclk(audio_mclk),.audio_lrck(audio_lrck),.audio_sck(audio_sck),.audio_sdin(audio_sdin));
    bin_to_dec change1 (.bin({12'd0,letter}),.thousand(letter_digit[3]),.hundred(letter_digit[2]),.tenth(letter_digit[1]),.oneth(letter_digit[0]));
    monitor_ctl display (.clk(clk_100mhz),.rst_n(rst_n),.dot(1'd0)
                         ,.digit3(letter_digit[3]),.digit2(letter_digit[2]),.digit1(letter_digit[1]),.digit0(letter_digit[0])
                         ,.segs(segs),.dis(dis));
endmodule
