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


module people_counter(
    input rst_n,
    input clk_1hz,
    input mode_people_unit,
    input mode_people_tendency,
    output [3:0]digit3,  //thousand
    output [3:0]digit2,
    output [3:0]digit1,
    output [3:0]digit0,
    output reg [15:0]led
    );

    wire increase_1;
    wire decrease_1;
    wire increase_10;
    wire decrease_10;
    wire [3:0]increment;
    wire [3:0]borrow;
    reg stop_down;
    reg stop_up;
    reg led_blink;
    
    
    assign increase_1 = ~mode_people_tendency && ~mode_people_unit && stop_up;
    assign decrease_1 = mode_people_tendency && ~mode_people_unit && stop_down;
    assign increase_10 = ((~mode_people_tendency && mode_people_unit) || increment[0]) && stop_up;
    assign decrease_10 = ((mode_people_tendency && mode_people_unit) || borrow[0]) && stop_down;
    always @* begin
    	if (digit3 == 4'd0 && digit2 == 4'd0 && digit1 == 4'd0 && digit0 == 4'd0) stop_down = 1'd0;
    	else stop_down = 1'd1;
    	if (digit3 >= 4'd1 && digit2 >= 4'd0 && digit1 >= 4'd0 && digit0 >= 4'd0) stop_up = 1'd0;
    	else stop_up = 1'd1;
    end
    	
    always @(posedge clk_1hz or negedge rst_n)
    	if (~rst_n) led_blink <= 1'd0;
    	else led_blink <= ~led_blink;
    always @*
    	if (digit2 >= 4'd5) begin
    		if (led_blink) led = 16'hFFFF;
    		else led = 16'h0000;
    	end
    	else if (digit2 >= 4'd4) led = 16'hFFFF;
    	else if (digit2 >= 4'd3) led = 16'h0FFF;
    	else if (digit2 >= 4'd2) led = 16'h00FF;
    	else if (digit2 >= 4'd1) led = 16'h000F;
    	else led = 16'h0;
    	
    counter1bit NUM0 (.inivalue(4'd0),.highbound(4'd9),.lowbound(4'd0),.increase(increase_1),.decrease(decrease_1),.clk(clk_1hz),.rst_n(rst_n),.value(digit0),.increment(increment[0]),.borrow(borrow[0]));
    counter1bit NUM1 (.inivalue(4'd0),.highbound(4'd9),.lowbound(4'd0),.increase(increase_10),.decrease(decrease_10),.clk(clk_1hz),.rst_n(rst_n),.value(digit1),.increment(increment[1]),.borrow(borrow[1]));
    counter1bit NUM2 (.inivalue(4'd0),.highbound(4'd9),.lowbound(4'd0),.increase(increment[1]),.decrease(borrow[1]),.clk(clk_1hz),.rst_n(rst_n),.value(digit2),.increment(increment[2]),.borrow(borrow[2]));
    counter1bit NUM3 (.inivalue(4'd0),.highbound(4'd9),.lowbound(4'd0),.increase(increment[2]),.decrease(borrow[2]),.clk(clk_1hz),.rst_n(rst_n),.value(digit3),.increment(increment[3]),.borrow(borrow[3]));
    
    
        
endmodule
