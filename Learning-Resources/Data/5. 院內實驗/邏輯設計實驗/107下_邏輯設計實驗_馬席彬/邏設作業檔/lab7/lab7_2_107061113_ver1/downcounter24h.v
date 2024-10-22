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


module setcounter_24h(
    input setting_next,
    input set_hour_next,
    input set_min_next,
    input rst_n,
    input clk_1hz,
    input clk_100hz,
    input mode,
    input stop,
    output [3:0]val2_24h,  //sec
    output [3:0]val3_24h,
    output [3:0]val4_24h,  //min
    output [3:0]val5_24h,
    output reg [15:0]led
    );
    wire setting;
    wire set_hour;
    wire set_min;
    wire start;
    reg start_next;
    wire [3:0]val_set[3:0];
    reg rst_hour_next;
    wire rst_hour;
    wire [3:0]val0_24h;
    wire [3:0]val1_24h;
    wire [3:0]increment;
    wire [5:0]borrow;
    
    assign rst_hour = rst_hour_next;
    assign setting = setting_next | stop;
    assign set_min = set_min_next & setting;
    assign set_hour = set_hour_next & setting;
    assign start = start_next;
    always@*
        if (val_set[3] == 4'd2 && val_set[2] == 4'd4)
              rst_hour_next <= 1'd1;
        else  rst_hour_next <= 1'd0;
    always@*
        if (val5_24h == 4'd0 && val4_24h == 4'd0 && val3_24h == 4'd0 && val2_24h == 4'd0 && val1_24h == 4'd0 && val0_24h == 4'd0) begin
           start_next <= 1'd0;
           led <= {16{1'd1}};
        end
        else begin
            start_next <= mode & ~setting;
            led <= {16{1'd0}};
        end   

       
    upcounter1bit set_min0 (.inivalue(4'd0),.highbound(4'd9),.lowbound(4'd0),.increase(set_min),.time_rst(1'd0),.time_rst_value(4'd0),.clk(clk_100hz),.rst_n(rst_n),.value(val_set[0]),.increment(increment[0]));
    upcounter1bit set_min1 (.inivalue(4'd0),.highbound(4'd5),.lowbound(4'd0),.increase(increment[0]),.time_rst(1'd0),.time_rst_value(4'd0),.clk(clk_100hz),.rst_n(rst_n),.value(val_set[1]),.increment(increment[1]));
    upcounter1bit set_hour0 (.inivalue(4'd0),.highbound(4'd9),.lowbound(4'd0),.increase(set_hour),.time_rst(rst_hour),.time_rst_value(4'd0),.clk(clk_100hz),.rst_n(rst_n),.value(val_set[2]),.increment(increment[2]));
    upcounter1bit set_hour1 (.inivalue(4'd0),.highbound(4'd2),.lowbound(4'd0),.increase(increment[2]),.time_rst(rst_hour),.time_rst_value(4'd0),.clk(clk_100hz),.rst_n(rst_n),.value(val_set[3]),.increment(increment[3]));            
    downcounter1bit sec0 (.inivalue(4'd0),.highbound(4'd9),.lowbound(4'd0),.decrease(start),.set(setting),.set_val(4'd0),.clk(clk_1hz),.rst_n(rst_n),.value(val0_24h),.borrow(borrow[0]));
    downcounter1bit sec1 (.inivalue(4'd0),.highbound(4'd5),.lowbound(4'd0),.decrease(borrow[0]),.set(setting),.set_val(4'd0),.clk(clk_1hz),.rst_n(rst_n),.value(val1_24h),.borrow(borrow[1]));
    downcounter1bit min0 (.inivalue(4'd0),.highbound(4'd9),.lowbound(4'd0),.decrease(borrow[1]),.set(setting),.set_val(val_set[0]),.clk(clk_1hz),.rst_n(rst_n),.value(val2_24h),.borrow(borrow[2]));
    downcounter1bit min1 (.inivalue(4'd0),.highbound(4'd5),.lowbound(4'd0),.decrease(borrow[2]),.set(setting),.set_val(val_set[1]),.clk(clk_1hz),.rst_n(rst_n),.value(val3_24h),.borrow(borrow[3]));
    downcounter1bit hour0 (.inivalue(4'd0),.highbound(4'd9),.lowbound(4'd0),.decrease(borrow[3]),.set(setting),.set_val(val_set[2]),.clk(clk_1hz),.rst_n(rst_n),.value(val4_24h),.borrow(borrow[4]));
    downcounter1bit hour1 (.inivalue(4'd0),.highbound(4'd2),.lowbound(4'd0),.decrease(borrow[4]),.set(setting),.set_val(val_set[3]),.clk(clk_1hz),.rst_n(rst_n),.value(val5_24h),.borrow(borrow[5]));
    
    
        
endmodule
