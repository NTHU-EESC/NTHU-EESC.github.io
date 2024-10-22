`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/16 20:44:10
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
    output [7:0]segs
    );
    wire [511:0] key_down;
    wire [8:0] last_change;
    wire key_valid;
    wire rst_p;
    wire [1:0]mode_arith;
    wire [1:0]mode_num_dis;
    wire [3:0]key_in;
    wire [3:0]display_digit[3:0];
    wire num_valid_pulse;
    
    assign rst_p = ~rst_n;
    KeyboardDecoder U0 (.PS2_DATA(PS2_DATA),.PS2_CLK(PS2_CLK),.rst(rst_p),.clk(clk_100mhz)
                        ,.key_down(key_down),.last_change(last_change),.key_valid(key_valid));  
    numvalid_pulse U1 (.clk(clk_100mhz),.rst_n(rst_n),.keys({key_down[112],key_down[105],key_down[114],key_down[122], 
                        key_down[107],key_down[115],key_down[116],key_down[108],key_down[117],key_down[125]}),.one_pulse(num_valid_pulse));
    pb_decoder U2 (.sig_keyboard(last_change),.bin(key_in));
    FSM_arith U3 (.clk(clk_100mhz),.rst_n(rst_n),.key_in(key_in),.mode_arith(mode_arith));
    FSM_num_dis U4 (.clk(clk_100mhz),.rst_n(rst_n),.key_in(key_in),.mode_num_dis(mode_num_dis));
    calculator calc (.clk(clk_100mhz),.rst_n(rst_n),.key_in(key_in),.num_valid(num_valid_pulse),.mode_arith(mode_arith),.mode_num_dis(mode_num_dis)
                     ,.output_digit3(display_digit[3]),.output_digit2(display_digit[2]),.output_digit1(display_digit[1]),.output_digit0(display_digit[0]));
    monitor_ctl display (.clk(clk_100mhz),.rst_n(rst_n),.dot(1'd0)
                    ,.digit3(display_digit[3]),.digit2(display_digit[2]),.digit1(display_digit[1]),.digit0(display_digit[0])
                    ,.segs(segs),.dis(dis));
endmodule
