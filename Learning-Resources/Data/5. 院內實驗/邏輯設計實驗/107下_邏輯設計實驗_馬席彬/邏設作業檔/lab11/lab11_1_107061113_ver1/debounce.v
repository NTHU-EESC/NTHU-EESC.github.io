`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/20 08:43:27
// Design Name: 
// Module Name: FSM
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


module debounce(
    input pb_in,
    input clk,
    input rst_n,
    output reg pb_debounced
    );
    reg pb_debounced_next;
    reg [3:0]debounce_window;
    
always @(posedge clk or negedge rst_n)
    if (~rst_n)
        debounce_window <= 4'd0;
    else
        debounce_window <= {debounce_window[2:0], pb_in};
// debounce circuit
always @*
    if (debounce_window == 4'b1111)
        pb_debounced_next = 1'b1;
    else
        pb_debounced_next = 1'b0;
always @(posedge clk or negedge rst_n)
    if (~rst_n)
        pb_debounced <= 1'b0;
    else
        pb_debounced <= pb_debounced_next;    
    
endmodule
