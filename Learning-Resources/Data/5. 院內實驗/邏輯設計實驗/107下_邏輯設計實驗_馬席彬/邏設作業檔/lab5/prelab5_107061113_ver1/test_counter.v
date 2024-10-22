`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/28 22:06:00
// Design Name: 
// Module Name: test_counter
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


module test_counter();
    reg start_debounced;
    reg rst_p;
    reg clk_1hz;
    reg clk_100hz;
    wire [3:0]digit0;
    wire [3:0]digit1;
    wire [15:0]led;

    top T0 (.start_debounced(start_debounced),.rst_p(rst_p),.clk_1hz(clk_1hz),.clk_100hz(clk_100hz),.digit0(digit0),.digit1(digit1),.led(led));
    initial begin
        clk_1hz = 1;
        clk_100hz = 1;
        start_debounced = 0;
        rst_p = 0;
        #95 rst_p = 1;
             start_debounced = 0;
        #95 rst_p = 0;
        #95 start_debounced = 1;
        #95 start_debounced = 0;
    end
    always begin
        #1 clk_100hz = ~clk_100hz;
    end
    always begin
        #100 clk_1hz = ~clk_1hz;
    end
endmodule
