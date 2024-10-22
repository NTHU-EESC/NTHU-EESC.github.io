`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/06/01 14:34:53
// Design Name: 
// Module Name: calculate
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

module calculate(
    inout PS2_DATA,
    inout PS2_CLK,
    input clk_100MHz,
    input rst_n,
    output [1:0]mode_arith,
    output [3:0]first_digit1,
    output [3:0]first_digit0,
    output [3:0]second_digit1,
    output [3:0]second_digit0,
    output [3:0]result_digit3,
    output [3:0]result_digit2,
    output [3:0]result_digit1,
    output [3:0]result_digit0
    );
    wire [511:0] key_down;
    wire [8:0] last_change;
    wire key_valid;
    wire mode_num_dis;
    wire rst_p;
    wire [3:0]key_in;
    wire num_valid_pulse;
    
    assign rst_p = ~rst_n;
    KeyboardDecoder U0 (.PS2_DATA(PS2_DATA),.PS2_CLK(PS2_CLK),.rst(rst_p),.clk(clk_100MHz)
                        ,.key_down(key_down),.last_change(last_change),.key_valid(key_valid));  
    numvalid_pulse U1 (.clk(clk_100MHz),.rst_n(rst_n),.keys({key_down[112],key_down[105],key_down[114],key_down[122], 
                        key_down[107],key_down[115],key_down[116],key_down[108],key_down[117],key_down[125]}),.one_pulse(num_valid_pulse));
    pb_decoder U2 (.sig_keyboard(last_change),.bin(key_in));
    FSM_arith U3 (.clk(clk_100MHz),.rst_n(rst_n),.key_in(key_in),.mode_arith(mode_arith));
    FSM_num_dis U4 (.clk(clk_100MHz),.rst_n(rst_n),.key_in(key_in),.mode_num_dis(mode_num_dis));
    calculator calc (.clk(clk_100MHz),.rst_n(rst_n),.key_in(key_in),.num_valid(num_valid_pulse),.mode_arith(mode_arith),.mode_num_dis(mode_num_dis)
                     ,.first_digit1(first_digit1),.first_digit0(first_digit0),.second_digit1(second_digit1),.second_digit0(second_digit0)
                     ,.result_digit3(result_digit3),.result_digit2(result_digit2),.result_digit1(result_digit1),.result_digit0(result_digit0));
endmodule
