`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/06/07 17:46:18
// Design Name: 
// Module Name: FSM_scroll
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

`define STATE_SCROLL 1
`define STATE_PAUSE 0
`define MODE_SCROLL 1
`define MODE_PAUSE 0
     
module FSM_scroll(
    input pulse,
    input clk,
    input rst_n,
    output reg mode
);

reg next_state;
reg state;     
always@*  begin
    if (state == `STATE_SCROLL) mode <= `MODE_SCROLL;
    else mode <= `MODE_PAUSE;
              
    case (state)
        `STATE_PAUSE:  begin
            if (pulse)  next_state <= `STATE_SCROLL;
            else next_state <= `STATE_PAUSE;
        end
        `STATE_SCROLL: begin
             if (pulse)  next_state <= `STATE_PAUSE;
             else next_state <= `STATE_SCROLL;
         end
    endcase
end
    
    always@(posedge clk or negedge rst_n)
        if (~rst_n)  state <= `STATE_PAUSE;
        else state <= next_state;
endmodule
