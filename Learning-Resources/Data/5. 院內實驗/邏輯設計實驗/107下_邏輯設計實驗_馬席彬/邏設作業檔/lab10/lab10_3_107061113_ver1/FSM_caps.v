`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/20 09:28:31
// Design Name: 
// Module Name: FSM_caps
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

`define STATE_LOWERCASE 1'd0
`define STATE_UPPERCASE 1'd1

module FSM_caps(
    input caps_valid,
    input clk,
    input rst_n,
    output reg mode_caps
);
reg mode_caps_next;
    
always @(posedge clk or negedge rst_n)
    if (~rst_n) mode_caps <= `STATE_LOWERCASE;
    else mode_caps <= mode_caps_next;
    
always @* 
    if (caps_valid == 1'd1 && mode_caps == `STATE_UPPERCASE) mode_caps_next = `STATE_LOWERCASE;
    else if (caps_valid == 1'd1 && mode_caps == `STATE_LOWERCASE) mode_caps_next = `STATE_UPPERCASE;
    else mode_caps_next = mode_caps;
    
endmodule
