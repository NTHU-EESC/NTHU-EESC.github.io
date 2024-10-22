`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/06/03 15:44:45
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
    input hundred,
    input thousand,
    input increase,
    input decrease,
    input clk_100mhz,
    input rst_n,
    output [3:0]dis,
    output [7:0]segs,
    output [15:0]led
    );
    
    wire clk_1hz;
    wire hundred_debounced;
    wire thousand_debounced;
    wire increase_debounced;
    wire decrease_debounced;
    wire hundred_pulse;
    wire thousand_pulse;
    wire increase_pulse;
    wire decrease_pulse;
    wire mode_people_unit;
    wire mode_people_tendency;
    wire [3:0]output_digit[3:0];
    
    freq_div_1 clk1 (.clk(clk_100mhz),.rst_n(rst_n),.clk_out(clk_1hz));
    debounce D0 (.pb_in(hundred),.clk(clk_100mhz),.rst_n(rst_n),.pb_debounced(hundred_debounced));
    debounce D1 (.pb_in(thousand),.clk(clk_100mhz),.rst_n(rst_n),.pb_debounced(thousand_debounced));
    debounce D2 (.pb_in(increase),.clk(clk_100mhz),.rst_n(rst_n),.pb_debounced(increase_debounced));
    debounce D3 (.pb_in(decrease),.clk(clk_100mhz),.rst_n(rst_n),.pb_debounced(decrease_debounced));
    one_pulse P0 (.in_trig(hundred_debounced),.clk(clk_100mhz),.rst_n(rst_n),.one_pulse(hundred_pulse));
    one_pulse P1 (.in_trig(thousand_debounced),.clk(clk_100mhz),.rst_n(rst_n),.one_pulse(thousand_pulse));
    one_pulse P2 (.in_trig(increase_debounced),.clk(clk_100mhz),.rst_n(rst_n),.one_pulse(increase_pulse));
    one_pulse P3 (.in_trig(decrease_debounced),.clk(clk_100mhz),.rst_n(rst_n),.one_pulse(decrease_pulse));
    FSM_people_num in (.hundred_pulse(hundred_pulse),.thousand_pulse(thousand_pulse),.clk(clk_100mhz),.rst_n(rst_n),.people_num(mode_people_unit));
    FSM_increase mode (.increase_pulse(increase_pulse),.decrease_pulse(decrease_pulse),.clk(clk_100mhz),.rst_n(rst_n),.mode(mode_people_tendency));
    people_counter count (.clk_1hz(clk_1hz),.rst_n(rst_n),.mode_people_unit(mode_people_unit),.mode_people_tendency(mode_people_tendency)
    					  ,.digit3(output_digit[3]),.digit2(output_digit[2]),.digit1(output_digit[1]),.digit0(output_digit[0]),.led(led));
    monitor_ctl DISPLAY (.digit3(output_digit[3]),.digit2(output_digit[2]),.digit1(output_digit[1]),.digit0(output_digit[0]),.dot(1'd0)
    					 ,.clk(clk_100mhz),.rst_n(rst_n),.dis(dis),.segs(segs));
    
endmodule
