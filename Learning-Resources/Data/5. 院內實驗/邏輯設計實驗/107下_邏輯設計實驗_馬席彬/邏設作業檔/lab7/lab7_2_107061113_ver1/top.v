`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/19 07:36:58
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
    input sw_set,
    input pb_stop,
    input pb_mode,  // pause / resume
    input pb_hour,
    input pb_min,
    input pb_rst,
    input clk_100mhz,
    output [3:0]dis,
    output [7:0]segs,
    output [15:0]led
    );
    
    wire clk_1hz;
    wire clk_100hz;
    wire hour_debounced;
    wire min_debounced;
    wire mode_debounced;
    wire rst_debounced;
    wire stop_debounced;
    wire hour_pulse;
    wire min_pulse;
    wire mode_pulse;
    wire stop_pulse;
    wire rst_pulse;
    wire rst_pulse_next;
    wire mode;
    wire [3:0]value[5:2];
    
    freq_div_1 clk_1 (.clk(clk_100mhz),.rst_n(rst_pulse),.clk_out(clk_1hz));
    freq_div_100 clk_100 (.clk(clk_100mhz),.rst_n(rst_pulse),.clk_out(clk_100hz));
    debounce A0 (.pb_in(pb_mode),.rst_n(rst_pulse),.clk(clk_100hz),.pb_debounced(mode_debounced));
    debounce B0 (.pb_in(pb_rst),.rst_n(rst_pulse),.clk(clk_100hz),.pb_debounced(rst_debounced));
    debounce C0 (.pb_in(pb_min),.rst_n(rst_pulse),.clk(clk_100hz),.pb_debounced(min_debounced));
    debounce D0 (.pb_in(pb_hour),.rst_n(rst_pulse),.clk(clk_100hz),.pb_debounced(hour_debounced));
    debounce E0 (.pb_in(pb_stop),.rst_n(rst_pulse),.clk(clk_100hz),.pb_debounced(stop_debounced));
    one_pulse A1 (.in_trig(mode_debounced),.clk(clk_100hz),.rst_n(rst_pulse),.one_pulse(mode_pulse));
    one_pulse B1 (.in_trig(rst_debounced),.clk(clk_100hz),.rst_n(rst_pulse),.one_pulse(rst_pulse_next));
    one_pulse C1 (.in_trig(min_debounced),.clk(clk_100hz),.rst_n(rst_pulse),.one_pulse(min_pulse));
    one_pulse D1 (.in_trig(hour_debounced),.clk(clk_100hz),.rst_n(rst_pulse),.one_pulse(hour_pulse));
    one_pulse E1 (.in_trig(stop_debounced),.clk(clk_100hz),.rst_n(rst_pulse),.one_pulse(stop_pulse));
    assign rst_pulse = ~rst_pulse_next;
    FSM_mode fsm_mode (.pulse(mode_pulse),.clk(clk_100hz),.rst_n(rst_pulse),.stop(stop_pulse),.mode(mode));
    setcounter_24h count (.clk_100hz(clk_100hz),.clk_1hz(clk_1hz),.rst_n(rst_pulse),.mode(mode),.set_min_next(min_pulse),.set_hour_next(hour_pulse)
                          ,.stop(stop_pulse),.setting_next(sw_set),.val2_24h(value[2]),.val3_24h(value[3]),.val4_24h(value[4]),.val5_24h(value[5]),.led(led));
    monitor_ctl display (.digit3(value[5]),.digit2(value[4]),.digit1(value[3]),.digit0(value[2])
                         ,.clk(clk_100mhz),.dot(1'd0),.rst_n(rst_pulse),.dis(dis),.segs(segs));
    
endmodule
