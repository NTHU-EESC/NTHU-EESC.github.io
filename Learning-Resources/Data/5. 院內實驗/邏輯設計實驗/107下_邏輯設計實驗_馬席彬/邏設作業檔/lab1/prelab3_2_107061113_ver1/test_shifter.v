`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/08 15:10:50
// Design Name: 
// Module Name: test_shifter
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


module test_shifter();
    reg clk, in, load, rst;
    wire [7:0]s;
    ringshifter U0 (.clk(clk),.in(in),.load(load),.rst(rst),.s(s));
    
    always 
        #5 clk = (~clk);
    initial
    begin
    clk = 1;
    load = 0;
    in = 0;
    rst = 0;
    #10 rst = 1;
end  
endmodule
