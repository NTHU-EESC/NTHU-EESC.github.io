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
    input [1:0]mode_num_dis,
    input rst_n,
    output reg [3:0]output_digit3,
    output reg [3:0]output_digit2,
    output reg [3:0]output_digit1,
    output reg [3:0]output_digit0
    );
    wire shift_valid0;
    wire shift_valid1;
    wire [3:0]first_digit[1:0];
    wire [3:0]second_digit[1:0];
    wire [6:0]first_bin;
    wire [6:0]second_bin;
    reg [7:0]sum;
    reg [7:0]subtract;
    reg negative;
    reg [15:0]multiply;
    reg [13:0]result;
    wire [3:0]result_digit[3:0];
    reg [3:0]result_digit_next;
    assign shift_valid0 = num_valid && (mode_num_dis == 2'd0);
    assign shift_valid1 = num_valid && (mode_num_dis == 2'd1);
    num_shifter shift0 (.clk(clk),.rst_n(rst_n),.key_in(key_in),.shift_valid(shift_valid0)
                        ,.tenth(first_digit[1]),.oneth(first_digit[0]));
    num_shifter shift1 (.clk(clk),.rst_n(rst_n),.key_in(key_in),.shift_valid(shift_valid1)
                        ,.tenth(second_digit[1]),.oneth(second_digit[0]));
    dec_to_bin change0 (.digit1(first_digit[1]),.digit0(first_digit[0]),.bin(first_bin));
    dec_to_bin change1 (.digit1(second_digit[1]),.digit0(second_digit[0]),.bin(second_bin));
    
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
        else result = 14'd0;
        
    bin_to_dec change2 (.bin(result),.thousand(result_digit[3]),.hundred(result_digit[2]),.tenth(result_digit[1]),.oneth(result_digit[0]));
    always @*
        if (negative && mode_arith == 2'd1) result_digit_next = 4'd13;
        else result_digit_next = result_digit[3];
    always @*
        if (mode_num_dis == 0)  begin
            {output_digit3,output_digit2,output_digit1,output_digit0} = 
            {4'd0, 4'd0, first_digit[1], first_digit[0]};
        end
        else if (mode_num_dis == 1)  begin
            {output_digit3,output_digit2,output_digit1,output_digit0} = 
            {4'd0, 4'd0, second_digit[1], second_digit[0]};
        end
        else if (mode_num_dis == 2)  begin
            {output_digit3,output_digit2,output_digit1,output_digit0} = 
            {result_digit_next, result_digit[2], result_digit[1], result_digit[0]};
        end 
        else {output_digit3,output_digit2,output_digit1,output_digit0} = 16'd0;
endmodule
