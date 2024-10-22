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


module upcounter24h(
    input rst_n,
    input clk,
    output [3:0]value0_24h,
    output [3:0]value1_24h,
    output [3:0]value2_24h,
    output [3:0]value3_24h,
    output [3:0]value4_24h,
    output [3:0]value5_24h
    );
    wire [5:0]increment;
    wire rst_hour;
    reg rst_hour_next;
    
    assign rst_hour = rst_hour_next;
    always@*  begin
        if (value5_24h == 4'd2 && value4_24h == 4'd3
            && value3_24h == 4'd5 && value2_24h == 4'd9
            && value1_24h == 4'd5 && value0_24h == 4'd9)
            rst_hour_next <= 1'd1;
        else rst_hour_next <= 1'd0;
    end
    upcounter1bit sec0_24hr (.inivalue(4'd0),.limit(4'd9),.lowbound(4'd0),.increase(1'd1),.time_rst(1'd0),.time_rst_value(4'd0),.clk(clk),.rst_n(rst_n),.value(value0_24h),.increment(increment[0]));
    upcounter1bit sec1_24hr (.inivalue(4'd0),.limit(4'd5),.lowbound(4'd0),.increase(increment[0]),.time_rst(1'd0),.time_rst_value(4'd0),.clk(clk),.rst_n(rst_n),.value(value1_24h),.increment(increment[1]));
    upcounter1bit min0_24hr (.inivalue(4'd9),.limit(4'd9),.lowbound(4'd0),.increase(increment[1]),.time_rst(1'd0),.time_rst_value(4'd0),.clk(clk),.rst_n(rst_n),.value(value2_24h),.increment(increment[2]));
    upcounter1bit min1_24hr (.inivalue(4'd5),.limit(4'd5),.lowbound(4'd0),.increase(increment[2]),.time_rst(1'd0),.time_rst_value(4'd0),.clk(clk),.rst_n(rst_n),.value(value3_24h),.increment(increment[3]));
    upcounter1bit hour0_24hr (.inivalue(4'd3),.limit(4'd9),.lowbound(4'd0),.increase(increment[3]),.time_rst(rst_hour),.time_rst_value(4'd0),.clk(clk),.rst_n(rst_n),.value(value4_24h),.increment(increment[4]));
    upcounter1bit hour1_24hr (.inivalue(4'd2),.limit(4'd2),.lowbound(4'd0),.increase(increment[4]),.time_rst(rst_hour),.time_rst_value(4'd0),.clk(clk),.rst_n(rst_n),.value(value5_24h),.increment(increment[5]));
endmodule
