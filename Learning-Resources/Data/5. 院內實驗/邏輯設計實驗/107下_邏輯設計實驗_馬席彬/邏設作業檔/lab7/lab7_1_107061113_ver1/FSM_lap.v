`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/17 18:21:14
// Design Name: 
// Module Name: FSM_lap
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
    
`define STATE_MEMORY 1
`define STATE_NOT_MEMORY 0
`define SSD_MEMORY 1
`define SSD_NOT_MEMORY 0
     
module FSM_lap(
    input pulse,
    input clk,
    input rst_n,
    output reg memory
);

reg next_state;
reg state;     
always@*  begin
    if (state == `STATE_MEMORY) 
        memory <= `SSD_MEMORY;
    else memory <= `SSD_NOT_MEMORY;          
    case (state)
        `STATE_NOT_MEMORY:  begin
            if (pulse)
                next_state <= `STATE_MEMORY;
                else next_state <= `STATE_NOT_MEMORY;
            end
        `STATE_MEMORY: begin
             if (pulse)
                 next_state <= `STATE_NOT_MEMORY;
             else next_state <= `STATE_MEMORY;
             end
    endcase
    end
    always@(posedge clk or negedge rst_n)
        if (~rst_n)  state <= `STATE_NOT_MEMORY;
        else state <= next_state;
endmodule
