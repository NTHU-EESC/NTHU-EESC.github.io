`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/13 09:19:40
// Design Name: 
// Module Name: upcounter24h
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


module upcounter_1h(
    input rst_n,
    input clk,
    input mode,
    output [3:0]value0_1h,  //sec
    output [3:0]value1_1h,
    output [3:0]value2_1h,  //min
    output [3:0]value3_1h
    );
    
    wire [3:0]increment;
    
    upcounter1bit sec0_1hr (.inivalue(4'd0),.limit(4'd9),.lowbound(4'd0),.increase(mode),.time_rst(1'd0),.time_rst_value(4'd0),.clk(clk),.rst_n(rst_n),.value(value0_1h),.increment(increment[0]));
    upcounter1bit sec1_1hr (.inivalue(4'd0),.limit(4'd5),.lowbound(4'd0),.increase(increment[0]),.time_rst(1'd0),.time_rst_value(4'd0),.clk(clk),.rst_n(rst_n),.value(value1_1h),.increment(increment[1]));
    upcounter1bit min0_1hr (.inivalue(4'd0),.limit(4'd9),.lowbound(4'd0),.increase(increment[1]),.time_rst(1'd0),.time_rst_value(4'd0),.clk(clk),.rst_n(rst_n),.value(value2_1h),.increment(increment[2]));
    upcounter1bit min1_1hr (.inivalue(4'd0),.limit(4'd5),.lowbound(4'd0),.increase(increment[2]),.time_rst(1'd0),.time_rst_value(4'd0),.clk(clk),.rst_n(rst_n),.value(value3_1h),.increment(increment[3]));
endmodule
