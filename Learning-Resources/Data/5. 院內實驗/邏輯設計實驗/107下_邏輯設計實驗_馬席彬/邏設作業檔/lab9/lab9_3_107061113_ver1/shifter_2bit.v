`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/16 21:22:53
// Design Name: 
// Module Name: shifter_2bit
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


module num_shifter(
    input [3:0]key_in,
    input shift_valid,
    input clk,
    input rst_n,
    output reg [3:0]tenth,
    output reg [3:0]oneth
    );
    reg [3:0]oneth_next;
    reg [3:0]tenth_next;

    always @(posedge clk or negedge rst_n)
        if (~rst_n) oneth <= 4'd0;
        else oneth <= oneth_next;
    always @(posedge clk or negedge rst_n)
        if (~rst_n) tenth <= 4'd0;
        else tenth <= tenth_next;
        
    always @* begin
        if (shift_valid)
            oneth_next <= key_in;
        else oneth_next <= oneth;
        if (shift_valid)
            tenth_next <= oneth;
        else tenth_next <= tenth;
    end
endmodule
