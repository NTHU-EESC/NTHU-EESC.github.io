`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/13 13:59:01
// Design Name: 
// Module Name: FSM_mode
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

`define STATE_12HR 0
`define STATE_24HR 1
`define DIS_12HR 0
`define DIS_24HR 1
 
module FSM_mode(
    input pulse,
    input clk,
    input rst_n,
    output reg dis_hour
    );
    reg next_state;
    reg state;
    
    always@*  begin
        if (state == `STATE_12HR) 
            dis_hour <= `DIS_12HR;
        else dis_hour <= `DIS_24HR;
        
        case (state)
            `STATE_12HR:  begin
                if (pulse)
                    next_state <= `STATE_24HR;
                else next_state <= `STATE_12HR;
                end
            `STATE_24HR: begin
                if (pulse)
                    next_state <= `STATE_12HR;
                else next_state <= `STATE_24HR;
                end
        endcase
    end
    always@(posedge clk or negedge rst_n)
        if (~rst_n)  state <= `STATE_12HR;
        else state <= next_state;
        
endmodule
