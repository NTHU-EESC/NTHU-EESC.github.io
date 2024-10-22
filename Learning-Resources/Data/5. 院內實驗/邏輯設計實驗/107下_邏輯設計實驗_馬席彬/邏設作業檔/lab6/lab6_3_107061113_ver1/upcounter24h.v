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


module dateupcounter24h(
    input rst_n,
    input clk,
    output [3:0]value0_24h,  //sec
    output [3:0]value1_24h,
    output [3:0]value2_24h,  //min
    output [3:0]value3_24h, 
    output [3:0]value4_24h,  //hour
    output [3:0]value5_24h,
    output [3:0]value6_24h,  //day
    output [3:0]value7_24h,
    output [3:0]value8_24h,  //month
    output [3:0]value9_24h,
    output [3:0]value10_24h,  //year
    output [3:0]value11_24h,
    output [3:0]value12_24h,
    output [3:0]value13_24h
    );
    
    reg leap_year;
    wire [13:0]increment;
    wire rst_hour;
    reg rst_hour_next;
    wire rst_date;
    reg rst_date_next;
    wire rst_month;
    reg rst_month_next;
    reg day_increase;
    reg month_increase;
    reg year_increase;
    reg [3:0]date_bound[1:0];
    
    assign rst_hour = rst_hour_next;
    assign rst_date = rst_date_next;
    assign rst_month = rst_month_next;
    
    always@* begin
        if (value13_24h == 4'd2 && value12_24h % 4 == 4'd0 && value11_24h == 4'd0 && value10_24h == 4'd0)
            leap_year <= 1'd1;
        else if (value11_24h == 4'd0 && value12_24h == 4'd0)
            leap_year <= 1'd0;
        else if (value12_24h % 2 == 4'd0 && value11_24h % 4 == 4'd0)
            leap_year <= 1'd1;
        else if (value12_24h % 2 == 4'd1 && value11_24h % 4 == 4'd2)
            leap_year <= 1'd1;
        else leap_year <= 1'd0;
    end
    always@* begin
        case (value8_24h)
            4'd0:  begin
                date_bound[0] <= 4'd1;
                date_bound[1] <= 4'd3;
            end
            4'd1:  begin
                if (value9_24h == 4'd1) begin
                    date_bound[0] <= 4'd0;
                    date_bound[1] <= 4'd3;
                end
                else begin
                    date_bound[0] <= 4'd1;
                    date_bound[1] <= 4'd3;
                end
            end
            4'd2:  begin
                if (value9_24h == 4'd1) begin
                    date_bound[0] <= 4'd1;
                    date_bound[1] <= 4'd3;
                end
                else if (leap_year) begin
                    date_bound[0] <= 4'd9;
                    date_bound[1] <= 4'd2;
                end
                else begin
                    date_bound[0] <= 4'd8;
                    date_bound[1] <= 4'd2;
                end
            end
            4'd3: begin
                date_bound[0] <= 4'd1;
                date_bound[1] <= 4'd3;
            end
            4'd4: begin
                date_bound[0] <= 4'd0;
                date_bound[1] <= 4'd3;
            end
            4'd5: begin
                date_bound[0] <= 4'd1;
                date_bound[1] <= 4'd3;
            end
            4'd6: begin
                date_bound[0] <= 4'd0;
                date_bound[1] <= 4'd3;
            end
            4'd7: begin
                date_bound[0] <= 4'd1;
                date_bound[1] <= 4'd3;
            end
            4'd8: begin
                date_bound[0] <= 4'd1;
                date_bound[1] <= 4'd3;
            end
            4'd9: begin
                date_bound[0] <= 4'd0;
                date_bound[1] <= 4'd3;
            end
            default:;
        endcase
    end
    always@* begin
        if (value5_24h == 4'd2 && value4_24h == 4'd3
            && value3_24h == 4'd5 && value2_24h == 4'd9
            && value1_24h == 4'd5 && value0_24h == 4'd9) begin
                day_increase <= 1'd1;
                rst_hour_next <= 1'd1;
            end
            else begin
                day_increase <= 1'd0;
                rst_hour_next <= 1'd0;
            end
    end
    always@* begin
        if ((value7_24h >= date_bound[1] && value6_24h > date_bound[0] && value5_24h == 4'd2 && value4_24h == 4'd3 && value3_24h == 4'd5 && value2_24h == 4'd9)
             || (leap_year && value9_24h == 4'd0 && value8_24h == 4'd2 && value7_24h == 4'd2 && value6_24h == 4'd9 &&
                 value5_24h == 4'd2 && value4_24h == 4'd3 && value3_24h == 4'd5 && value2_24h == 4'd9))  begin
            rst_date_next <= 1'd1;
            month_increase <= 1'd1;
        end
        else begin 
            rst_date_next <= 1'd0;
            month_increase <= 1'd0;
        end
    end
    always@* begin
        if (value9_24h == 4'd1 && value8_24h == 4'd2 && value7_24h == 4'd3 && value6_24h == 4'd1 &&
            value5_24h == 4'd2 && value4_24h == 4'd3 && value3_24h == 4'd5 && value2_24h == 4'd9)  begin
            rst_month_next <= 1'd1;
            year_increase <= 1'd1;
        end
        else begin 
            rst_month_next <= 1'd0;
            year_increase <= 1'd0;
        end
    end
    
    
    upcounter1bit sec0_24hr (.inivalue(4'd0),.limit(4'd9),.lowbound(4'd0),.increase(1'd1),.time_rst(1'd0),.time_rst_value(4'd0),.clk(clk),.rst_n(rst_n),.value(value0_24h),.increment(increment[0]));
    upcounter1bit sec1_24hr (.inivalue(4'd0),.limit(4'd5),.lowbound(4'd0),.increase(increment[0]),.time_rst(1'd0),.time_rst_value(4'd0),.clk(clk),.rst_n(rst_n),.value(value1_24h),.increment(increment[1]));
    upcounter1bit min0_24hr (.inivalue(4'd9),.limit(4'd9),.lowbound(4'd0),.increase(increment[1]),.time_rst(1'd0),.time_rst_value(4'd0),.clk(clk),.rst_n(rst_n),.value(value2_24h),.increment(increment[2]));
    upcounter1bit min1_24hr (.inivalue(4'd5),.limit(4'd5),.lowbound(4'd0),.increase(increment[2]),.time_rst(1'd0),.time_rst_value(4'd0),.clk(clk),.rst_n(rst_n),.value(value3_24h),.increment(increment[3]));
    upcounter1bit hour0_24hr (.inivalue(4'd3),.limit(4'd9),.lowbound(4'd0),.increase(increment[3]),.time_rst(rst_hour),.time_rst_value(4'd0),.clk(clk),.rst_n(rst_n),.value(value4_24h),.increment(increment[4]));
    upcounter1bit hour1_24hr (.inivalue(4'd2),.limit(4'd2),.lowbound(4'd0),.increase(increment[4]),.time_rst(rst_hour),.time_rst_value(4'd0),.clk(clk),.rst_n(rst_n),.value(value5_24h),.increment(increment[5]));
    upcounter1bit day0_24hr (.inivalue(4'd1),.limit(4'd9),.lowbound(4'd0),.increase(day_increase),.time_rst(rst_date),.time_rst_value(4'd1),.clk(clk),.rst_n(rst_n),.value(value6_24h),.increment(increment[6]));
    upcounter1bit day1_24hr (.inivalue(4'd0),.limit(4'd9),.lowbound(4'd0),.increase(increment[6]),.time_rst(rst_date),.time_rst_value(4'd0),.clk(clk),.rst_n(rst_n),.value(value7_24h),.increment(increment[7]));
    upcounter1bit month0_24hr (.inivalue(4'd1),.limit(4'd9),.lowbound(4'd0),.increase(month_increase),.time_rst(rst_month),.time_rst_value(4'd1),.clk(clk),.rst_n(rst_n),.value(value8_24h),.increment(increment[8]));
    upcounter1bit month1_24hr (.inivalue(4'd0),.limit(4'd9),.lowbound(4'd0),.increase(increment[8]),.time_rst(rst_month),.time_rst_value(4'd0),.clk(clk),.rst_n(rst_n),.value(value9_24h),.increment(increment[9]));
    upcounter1bit year0_24hr (.inivalue(4'd0),.limit(4'd9),.lowbound(4'd0),.increase(year_increase),.time_rst(1'd0),.time_rst_value(4'd0),.clk(clk),.rst_n(rst_n),.value(value10_24h),.increment(increment[10]));
    upcounter1bit year1_24hr (.inivalue(4'd0),.limit(4'd9),.lowbound(4'd0),.increase(increment[10]),.time_rst(1'd0),.time_rst_value(4'd0),.clk(clk),.rst_n(rst_n),.value(value11_24h),.increment(increment[11]));
    upcounter1bit year2_24hr (.inivalue(4'd0),.limit(4'd9),.lowbound(4'd0),.increase(increment[11]),.time_rst(1'd0),.time_rst_value(4'd0),.clk(clk),.rst_n(rst_n),.value(value12_24h),.increment(increment[12]));
    upcounter1bit year3_24hr (.inivalue(4'd2),.limit(4'd9),.lowbound(4'd0),.increase(increment[12]),.time_rst(1'd0),.time_rst_value(4'd2),.clk(clk),.rst_n(rst_n),.value(value13_24h),.increment(increment[13]));
endmodule
