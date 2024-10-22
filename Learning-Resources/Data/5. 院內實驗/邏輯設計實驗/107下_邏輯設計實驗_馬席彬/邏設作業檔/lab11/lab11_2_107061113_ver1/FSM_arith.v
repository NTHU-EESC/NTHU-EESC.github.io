`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/16 21:25:41
// Design Name: 
// Module Name: FSM_arith
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


module FSM_arith(
    input [3:0]key_in,
    input clk,
    input rst_n,
    output reg [1:0]mode_arith
    );
    
    reg [1:0]mode_arith_next;
    
    always @(posedge clk or negedge rst_n)
        if (~rst_n) mode_arith <= 2'd0;
        else mode_arith <= mode_arith_next;
    always @* 
        if (key_in == 4'd10) mode_arith_next = 2'd0;
        else if (key_in == 4'd11) mode_arith_next = 2'd1;
        else if (key_in == 4'd12) mode_arith_next = 2'd2;
        else mode_arith_next = mode_arith;
    
endmodule
