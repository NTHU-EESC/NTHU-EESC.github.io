`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/17 18:21:14
// Design Name: 
// Module Name: FSM_start
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


`define STATE_DECREASE 1
`define STATE_INCREASE 0
`define MODE_DECREASE 1
`define MODE_INCREASE 0
     
module FSM_increase(
    input increase_pulse,
    input decrease_pulse,
    input clk,
    input rst_n,
    output reg mode
);

reg next_state;
reg state;    
 
always@*  begin
    if (state == `STATE_DECREASE) 
        mode <= `MODE_DECREASE;
    else mode <= `MODE_INCREASE;  
            
	if (increase_pulse)  next_state <= `MODE_INCREASE;
	else if (decrease_pulse)  next_state <= `MODE_DECREASE;
	else next_state <= state;
end
    
    always@(posedge clk or negedge rst_n)
        if (~rst_n)  state <= `STATE_INCREASE;
        else state <= next_state;
endmodule
