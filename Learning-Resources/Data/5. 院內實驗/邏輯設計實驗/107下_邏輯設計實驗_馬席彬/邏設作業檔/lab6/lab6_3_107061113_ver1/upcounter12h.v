`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/13 09:19:40
// Design Name: 
// Module Name: upcounter12h
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


module upcounter12h(
    input rst_n,
    input clk,
    output [3:0]value0_12h,
    output [3:0]value1_12h,
    output [3:0]value2_12h,
    output [3:0]value3_12h,
    output [3:0]value4_12h,
    output [3:0]value5_12h,
    output reg ampm
    );
    wire [4:0]increment;
    wire rst_hour;
    reg change_ampm;
    reg rst_hour_next;
    
    assign rst_hour = rst_hour_next;
        
        
    always@*  begin
        if (value5_12h == 4'd1 && value4_12h == 4'd2
            && value3_12h == 4'd5 && value2_12h == 4'd9
            && value1_12h == 4'd5 && value0_12h == 4'd9)  
            begin
            change_ampm <= 1'd1;
            rst_hour_next <= 1'd1;
            end
        else begin
            change_ampm <= 1'd0;
            rst_hour_next <= 1'd0;
        end
    end
    always@(posedge clk or negedge rst_n)
         if (~rst_n)
            ampm <= 1'd1;  //am is 1 , pm is 0
         else if (change_ampm)  ampm <= ~ampm;
         else ampm <= ampm;
         
    upcounter1bit sec0_12hr (.inivalue(4'd0),.limit(4'd9),.lowbound(4'd0),.increase(1'd1),.time_rst(1'd0),.time_rst_value(4'd0),.clk(clk),.rst_n(rst_n),.value(value0_12h),.increment(increment[0]));
    upcounter1bit sec1_12hr (.inivalue(4'd0),.limit(4'd5),.lowbound(4'd0),.increase(increment[0]),.time_rst(1'd0),.time_rst_value(4'd0),.clk(clk),.rst_n(rst_n),.value(value1_12h),.increment(increment[1]));
    upcounter1bit min0_12hr (.inivalue(4'd9),.limit(4'd9),.lowbound(4'd0),.increase(increment[1]),.time_rst(1'd0),.time_rst_value(4'd0),.clk(clk),.rst_n(rst_n),.value(value2_12h),.increment(increment[2]));
    upcounter1bit min1_12hr (.inivalue(4'd5),.limit(4'd5),.lowbound(4'd0),.increase(increment[2]),.time_rst(1'd0),.time_rst_value(4'd0),.clk(clk),.rst_n(rst_n),.value(value3_12h),.increment(increment[3]));
    upcounter1bit hour0_12hr (.inivalue(4'd1),.limit(4'd9),.lowbound(4'd0),.increase(increment[3]),.time_rst(rst_hour),.time_rst_value(4'd1),.clk(clk),.rst_n(rst_n),.value(value4_12h),.increment(increment[4]));
    upcounter1bit hour1_12hr (.inivalue(4'd1),.limit(4'd1),.lowbound(4'd0),.increase(increment[4]),.time_rst(rst_hour),.time_rst_value(4'd0),.clk(clk),.rst_n(rst_n),.value(value5_12h));
endmodule
