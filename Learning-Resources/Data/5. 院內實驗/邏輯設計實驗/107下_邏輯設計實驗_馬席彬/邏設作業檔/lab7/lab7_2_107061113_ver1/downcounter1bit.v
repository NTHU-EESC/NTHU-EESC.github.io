`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/13 09:02:18
// Design Name: 
// Module Name: upcounter1bit
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


module downcounter1bit(
    input [3:0]inivalue,
    input [3:0]highbound,
    input [3:0]lowbound,
    input decrease,
    input set,
    input [3:0]set_val,
    input clk,
    input rst_n,
    output reg [3:0]value,
    output reg borrow
    );
    reg [3:0]value_next;
    reg [3:0]value_in;
    
    always@*
        if (value <= lowbound  && decrease)
            value_next <= highbound;
        else if (decrease)
            value_next <= value - 4'd1;
        else 
            value_next <= value;

    always@(posedge clk or negedge rst_n or posedge set)
        if (~rst_n)  value <= inivalue;
        else if (set)  value <= set_val;
        else value <= value_next;
        
    always@* 
        if (value <= lowbound && decrease)
            borrow <= 1'd1;
        else
            borrow <= 1'd0;      
endmodule
