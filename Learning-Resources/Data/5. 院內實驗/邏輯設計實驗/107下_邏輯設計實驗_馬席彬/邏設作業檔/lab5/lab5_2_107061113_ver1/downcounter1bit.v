`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/15 14:38:02
// Design Name: 
// Module Name: downcounter1bit
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

`define ENABLED 1
`define DISABLED 0
`define INCREMENT 1

module downcounter(
output reg [3:0]value, // counter output
output reg borrow, // borrow indicator
input [3:0]inivalue,     // value at reset
input clk, // global clock
input rst_p, // active low reset
input decrease, // counter enable control
input [3:0]limit // limit for the counter
);
reg [3:0]value_tmp;
reg delay;
// Combinational logics
always @*  begin
    if (value == 0 && decrease)
    begin
      value_tmp = limit;
      borrow = `ENABLED;
    end
    else if (value != 0 && decrease)
    begin
        value_tmp = value - `INCREMENT;
        borrow = `DISABLED;
    end
    else
    begin
        value_tmp = value;
        borrow = `DISABLED;
    end
end
    // register part for BCD counter
always @(posedge clk or posedge rst_p)
    if (rst_p) value <= inivalue;
    else value <= value_tmp;
endmodule
