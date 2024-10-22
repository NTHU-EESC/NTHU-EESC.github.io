`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/16 21:25:41
// Design Name: 
// Module Name: FSM_num_dis
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

`define STATE_FIRST 2'd0
`define STATE_SECOND 2'd1
`define STATE_RESULT 2'd2
module FSM_num_dis(
    input [3:0]key_in,
    input clk,
    input rst_n,
    output reg [1:0]mode_num_dis
    );
    
    reg [1:0]mode_num_dis_next;
    
    always @(posedge clk or negedge rst_n)
        if (~rst_n) mode_num_dis <= `STATE_FIRST;
        else mode_num_dis <= mode_num_dis_next;
    always @* 
        if (mode_num_dis == `STATE_FIRST && 
            (key_in == 4'd10 || key_in == 4'd11 || key_in == 4'd12)) mode_num_dis_next = `STATE_SECOND;
        else if (key_in == 4'd14) mode_num_dis_next = `STATE_RESULT;
        else mode_num_dis_next = mode_num_dis;
        
    endmodule
