`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/20 09:04:59
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
    output [3:0]dis,
    output [7:0]segs,
    output led
    );
    wire [511:0] key_down;
    wire [8:0] last_change;
    wire key_valid;
    wire rst_p;
    wire [7:0]key_in;
    wire letter_valid_pulse;
    wire caps_valid_pulse;
    reg [7:0]unprocess_asc;
    reg [7:0]unprocess_asc_next;
    wire mode_caps;
    reg uppercase;
    reg [7:0]processed_asc;
    wire [3:0]display_digit[3:0];
    
    assign led = uppercase;
    assign rst_p = ~rst_n;
    KeyboardDecoder U0 (.PS2_DATA(PS2_DATA),.PS2_CLK(PS2_CLK),.rst(rst_p),.clk(clk_100mhz)
                        ,.key_down(key_down),.last_change(last_change),.key_valid(key_valid));  
    letter_valid U1 (.clk(clk_100mhz),.rst_n(rst_n),.keys({key_down[28],key_down[50],key_down[33],key_down[35], 
                        key_down[36],key_down[43],key_down[52],key_down[51],key_down[67],key_down[59],key_down[66]
                        ,key_down[75],key_down[58],key_down[49],key_down[68],key_down[77],key_down[21],key_down[45]
                        ,key_down[27],key_down[44],key_down[60],key_down[42],key_down[29],key_down[34],key_down[53]
                        ,key_down[26]}) ,.one_pulse(letter_valid_pulse));
    letter_valid U4 (.clk(clk_100mhz),.rst_n(rst_n),.keys({25'd0,key_down[88]}) ,.one_pulse(caps_valid_pulse));
    pb_decoder U2 (.sig_keyboard(last_change) ,.key_in(key_in));
    
    always @ (posedge clk_100mhz or negedge rst_n)
        if (~rst_n) unprocess_asc <= 8'd0;
        else unprocess_asc <= unprocess_asc_next;
    always @*
        if  (letter_valid_pulse) unprocess_asc_next = key_in;
        else unprocess_asc_next = unprocess_asc;
        
    FSM_caps U3 (.clk(clk_100mhz) ,.rst_n(rst_n) ,.caps_valid(caps_valid_pulse) ,.mode_caps(mode_caps));
    
    always @*
        if  (key_down[18]) uppercase = ~mode_caps;
        else uppercase = mode_caps;
        
    always @*
        if (uppercase) processed_asc = unprocess_asc;
        else processed_asc = unprocess_asc + 8'd32;
    
    bin_to_dec change0 (.bin({8'd0,processed_asc}),. thousand(display_digit[3]),.hundred(display_digit[2]),.tenth(display_digit[1]),.oneth(display_digit[0]));
    monitor_ctl display (.clk(clk_100mhz),.rst_n(rst_n),.dot(1'd0)
                    ,.digit3(display_digit[3]),.digit2(display_digit[2]),.digit1(display_digit[1]),.digit0(display_digit[0])
                    ,.segs(segs),.dis(dis));
endmodule
