`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/08 09:52:22
// Design Name: 
// Module Name: calculator
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


module calculator(
    input [3:0]key_in,
    input clk,
    input num_valid,
    input [1:0]mode_arith,
    input mode_num_dis,
    input rst_n,
    output [3:0]first_digit1,
    output [3:0]first_digit0,
    output [3:0]second_digit1,
    output [3:0]second_digit0,
    output reg [3:0]result_digit3,
    output [3:0]result_digit2,
    output [3:0]result_digit1,
    output [3:0]result_digit0
    );
    
    wire shift_valid0;
    wire shift_valid1;
    wire [7:0]first_bin;
    wire [7:0]second_bin;
    reg [7:0]sum;
    reg [7:0]subtract;
    reg negative;
    reg [15:0]multiply;
    reg [15:0]result;
    wire [3:0]result_digit_next;
    
    assign shift_valid0 = num_valid && (mode_num_dis == 2'd0);
    assign shift_valid1 = num_valid && (mode_num_dis == 2'd1);
    num_shifter shift0 (.clk(clk),.rst_n(rst_n),.key_in(key_in),.shift_valid(shift_valid0)
                        ,.tenth(first_digit1),.oneth(first_digit0));
    num_shifter shift1 (.clk(clk),.rst_n(rst_n),.key_in(key_in),.shift_valid(shift_valid1)
                        ,.tenth(second_digit1),.oneth(second_digit0));
    dec_to_bin change0 (.digit1(first_digit1),.digit0(first_digit0),.bin(first_bin));
    dec_to_bin change1 (.digit1(second_digit1),.digit0(second_digit0),.bin(second_bin));
    
    always @* begin
        sum = first_bin + second_bin;
        if (first_bin >= second_bin)  begin
            subtract = first_bin - second_bin;
            negative = 0;
        end
        else begin
            subtract = second_bin - first_bin;
            negative = 1;
        end
        multiply = first_bin * second_bin;
    end
    always @*
        if (mode_arith == 2'd0)  result = sum;
        else if (mode_arith == 2'd1)  result = subtract;
        else if (mode_arith == 2'd2)  result = multiply;
        else result = 16'd0;
        
    bin_to_dec change2 (.bin(result),.thousand(result_digit_next),.hundred(result_digit2),.tenth(result_digit1),.oneth(result_digit0));
    always @*
        if (negative && mode_arith == 2'd1) result_digit3 = 4'd11;
        else result_digit3 = result_digit_next;
endmodule
