`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/23 11:01:33
// Design Name: 
// Module Name: one_pulse
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


module one_pulse(
    input in_trig,
    input clk,
    input rst_p,
    output reg one_pulse
    );
    reg in_trig_delay;
    reg one_pulse_next;
always @(posedge clk or posedge rst_p)
    if (rst_p)  in_trig_delay <= 0;
    else  in_trig_delay <= in_trig;
always @*
    one_pulse_next <= (~in_trig_delay) && in_trig;
always @(posedge clk or posedge rst_p)
    if (rst_p)  one_pulse <= 0;
    else  one_pulse <= one_pulse_next;
endmodule
