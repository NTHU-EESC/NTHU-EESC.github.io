`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/08 09:24:13
// Design Name: 
// Module Name: test_upcounter
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


module test_upcounter;
reg rst;
reg clk;
wire [3:0]s;
bincounter U0 (.rst(rst),.clk(clk),.s(s));
always 
begin
  #5 clk <= ~clk;
end
initial
begin
clk = 1'd1;
rst = 1'd0;
#10 rst = 1'd1;
end
endmodule
