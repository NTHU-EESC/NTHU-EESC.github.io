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


module numvalid_pulse(
    input clk,
    input rst_n,
    input [9:0]keys,
    output reg one_pulse
    );
    reg [9:0]key_down_temp;
    reg one_pulse_next;
    reg trig;
       
always @(posedge clk or negedge rst_n)
    if (~rst_n)  key_down_temp <= 0;
    else key_down_temp <= keys;
always @*
    if (key_down_temp < keys)  one_pulse = 1'd1;
    else  one_pulse <= 1'd0;
endmodule
