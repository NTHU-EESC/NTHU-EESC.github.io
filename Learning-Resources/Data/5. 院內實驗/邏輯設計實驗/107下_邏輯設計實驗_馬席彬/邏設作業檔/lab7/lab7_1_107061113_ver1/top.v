`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/17 14:45:06
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
    input pb_lap,
    input pb_mode,
    input pb_rst,
    input clk_100mhz,
    output [3:0]dis,
    output [7:0]segs
    );
    
    wire clk_1hz;
    wire clk_100hz;
    wire lap_debounced;
    wire mode_debounced;
    wire rst_debounced;
    wire lap_pulse;
    wire mode_pulse;
    wire rst_pulse_next;
    wire rst_pulse;
    wire memory;
    wire mode;
    wire [3:0]value[3:0];
    wire [3:0]memory_value[3:0];
    
    freq_div_1 clk_1 (.clk(clk_100mhz),.rst_n(rst_pulse),.clk_out(clk_1hz));
    freq_div_100 clk_100 (.clk(clk_100mhz),.rst_n(rst_pulse),.clk_out(clk_100hz));
    debounce A0 (.pb_in(pb_lap),.rst_n(rst_pulse),.clk(clk_100hz),.pb_debounced(lap_debounced));
    debounce B0 (.pb_in(pb_mode),.rst_n(rst_pulse),.clk(clk_100hz),.pb_debounced(mode_debounced));
    debounce C0 (.pb_in(pb_rst),.rst_n(rst_pulse),.clk(clk_100hz),.pb_debounced(rst_debounced));
    one_pulse A1 (.in_trig(lap_debounced),.clk(clk_100hz),.rst_n(rst_pulse),.one_pulse(lap_pulse));
    one_pulse B1 (.in_trig(mode_debounced),.clk(clk_100hz),.rst_n(rst_pulse),.one_pulse(mode_pulse));
    one_pulse C1 (.in_trig(rst_debounced),.clk(clk_100hz),.rst_n(rst_pulse),.one_pulse(rst_pulse_next));
    assign rst_pulse = ~rst_pulse_next;
    FSM_lap fsm_lap (.pulse(lap_pulse),.clk(clk_100hz),.rst_n(rst_pulse),.memory(memory));
    FSM_mode fsm_mode (.pulse(mode_pulse),.clk(clk_100hz),.rst_n(rst_pulse),.mode(mode));
    upcounter_1h count (.clk(clk_1hz),.rst_n(rst_pulse),.mode(mode),.value0_1h(value[0]),.value1_1h(value[1]),.value2_1h(value[2]),.value3_1h(value[3]));
    memory memory0 (.clk(clk_100hz),.rst_n(rst_pulse),.memory(memory)
                     ,.value0_in(value[0]),.value1_in(value[1]),.value2_in(value[2]),.value3_in(value[3])
                     ,.value0_out(memory_value[0]),.value1_out(memory_value[1]),.value2_out(memory_value[2]),.value3_out(memory_value[3]));
    monitor_ctl display (.digit3(memory_value[3]),.digit2(memory_value[2]),.digit1(memory_value[1]),.digit0(memory_value[0])
                         ,.clk(clk_100mhz),.dot(1'd0),.rst_n(rst_pulse),.dis(dis),.segs(segs));
    
    
endmodule
