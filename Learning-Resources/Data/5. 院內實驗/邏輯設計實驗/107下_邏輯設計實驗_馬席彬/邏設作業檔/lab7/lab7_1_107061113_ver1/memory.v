`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/17 15:06:08
// Design Name: 
// Module Name: memory
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


module memory(
    input [3:0]value0_in,
    input [3:0]value1_in,
    input [3:0]value2_in,
    input [3:0]value3_in,
    input rst_n,
    input memory,
    input clk,
    output [3:0]value0_out,
    output [3:0]value1_out,
    output [3:0]value2_out,
    output [3:0]value3_out
    );
    
    reg [3:0]memory_val[3:0];
    reg [3:0]memory_val_next[3:0];
    
    assign value0_out = memory_val[0];
    assign value1_out = memory_val[1];
    assign value2_out = memory_val[2];
    assign value3_out = memory_val[3];
    
    always @*
        if (~memory)  begin
            memory_val_next[0] <= value0_in;
            memory_val_next[1] <= value1_in;
            memory_val_next[2] <= value2_in;
            memory_val_next[3] <= value3_in;
        end
        else begin
            memory_val_next[0] <= memory_val[0];
            memory_val_next[1] <= memory_val[1];
            memory_val_next[2] <= memory_val[2];
            memory_val_next[3] <= memory_val[3];
        end
    always@(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            memory_val[0] <= 4'd0;
            memory_val[1] <= 4'd0;
            memory_val[2] <= 4'd0;
            memory_val[3] <= 4'd0;
        end
        else begin
            memory_val[0] <= memory_val_next[0];
            memory_val[1] <= memory_val_next[1];
            memory_val[2] <= memory_val_next[2];
            memory_val[3] <= memory_val_next[3];
        end
    end
    
endmodule
