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


module datecounter(
    input rst_n,
    input clk,
    output [3:0]value0,
    output [3:0]value1,
    output [3:0]value2,
    output [3:0]value3,
    output [3:0]value4,
    output [3:0]value5
    );
    reg [3:0]date_bound[1:0];
    wire [4:0]increment;
    wire rst_date;
    reg rst_date_next;
    wire rst_month;
    reg rst_month_next;
    reg month_increase;
    reg year_increase;
    
    assign rst_date = rst_date_next;
    assign rst_month = rst_month_next;
    
    always@* begin
        case (value2)
            4'd0:  begin
                date_bound[0] <= 4'd1;
                date_bound[1] <= 4'd3;
            end
            4'd1:  begin
                if (value3 == 4'd1) begin
                    date_bound[0] <= 4'd0;
                    date_bound[1] <= 4'd3;
                end
                else begin
                    date_bound[0] <= 4'd1;
                    date_bound[1] <= 4'd3;
                end
            end
            4'd2:  begin
                if (value3 == 4'd1) begin
                   date_bound[0] <= 4'd1;
                   date_bound[1] <= 4'd3;
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
        
        if (value1 >= date_bound[1] && value0 >= date_bound[0])  begin
            rst_date_next <= 1'd1;
            month_increase <= 1'd1;
        end
        else begin 
            rst_date_next <= 1'd0;
            month_increase <= 1'd0;
        end
    end
    always@*  begin
        if ( value3 == 4'd1 && value2 == 4'd2 && value1 == 4'd3 && value0 == 4'd1)  begin
            year_increase <= 1'd1; 
            rst_month_next <= 1'd1;
        end
        else begin
            year_increase <= 1'd0;
            rst_month_next <= 1'd0;
        end
    end
         
    upcounter1bit day0 (.inivalue(4'd1),.limit(4'd9),.lowbound(4'd0),.increase(1'd1),.time_rst(rst_date),.time_rst_value(4'd1),.clk(clk),.rst_n(rst_n),.value(value0),.increment(increment[0]));
    upcounter1bit day1 (.inivalue(4'd0),.limit(4'd9),.lowbound(4'd0),.increase(increment[0]),.time_rst(rst_date),.time_rst_value(4'd0),.clk(clk),.rst_n(rst_n),.value(value1),.increment(increment[1]));
    upcounter1bit month0 (.inivalue(4'd1),.limit(4'd9),.lowbound(4'd0),.increase(month_increase),.time_rst(rst_month),.time_rst_value(4'd1),.clk(clk),.rst_n(rst_n),.value(value2),.increment(increment[2]));
    upcounter1bit month1 (.inivalue(4'd0),.limit(4'd9),.lowbound(4'd0),.increase(increment[2]),.time_rst(rst_month),.time_rst_value(4'd0),.clk(clk),.rst_n(rst_n),.value(value3),.increment(increment[3]));
    upcounter1bit year0 (.inivalue(4'd0),.limit(4'd9),.lowbound(4'd0),.increase(year_increase),.time_rst(1'd0),.time_rst_value(4'd1),.clk(clk),.rst_n(rst_n),.value(value4),.increment(increment[4]));
    upcounter1bit year1 (.inivalue(4'd0),.limit(4'd9),.lowbound(4'd0),.increase(increment[4]),.time_rst(1'd0),.time_rst_value(4'd0),.clk(clk),.rst_n(rst_n),.value(value5),.increment(increment[5]));
endmodule
