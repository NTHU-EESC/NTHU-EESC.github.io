`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/06/03 15:48:46
// Design Name: 
// Module Name: FSM_people_num
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


`define STATE_THOUSAND 1
`define STATE_HUNDRED 0
`define MODE_THOUSAND 1
`define MODE_HUNDRED 0
     
module FSM_people_num(
    input hundred_pulse,
    input thousand_pulse,
    input clk,
    input rst_n,
    output reg people_num
);

reg next_state;
reg state;     

always@*  begin
    if (state == `STATE_THOUSAND) 
        people_num <= `MODE_THOUSAND;
    else people_num <= `MODE_HUNDRED;   
           
	if (thousand_pulse)  next_state <= `MODE_THOUSAND;
    else if (hundred_pulse)  next_state <= `MODE_HUNDRED;
    else next_state <= state;
end

always@(posedge clk or negedge rst_n)
    if (~rst_n)  state <= `STATE_HUNDRED;
    else state <= next_state;
    
endmodule

