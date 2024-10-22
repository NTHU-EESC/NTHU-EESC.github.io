`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/20 08:26:16
// Design Name: 
// Module Name: top
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


module top(
    input pb_rst,
    input pb_start,
    input clk_cr,
    output [7:0]seg,
    output [3:0]dis,
    output reg [15:0]led
    );
    wire clk_100hz;
    wire clk_1hz;
    wire rst_p;
    wire start_debounced;
    wire rst_debounced;
    wire start_pulse;
    wire rst_pulse;
    reg count_enable;
    wire count_enable_next;
    wire [3:0]digit[1:0];
    wire [3:0]bin;
    wire br;
    
    
    freq_div_1  C0 (.clk(clk_cr),.rst_p(rst_p),.clk_out(clk_1hz));
    freq_div_100  C1 (.clk(clk_cr),.rst_p(rst_p),.clk_out(clk_100hz));
    debounce  P0 (.pb_in(pb_start),.clk(clk_100hz),.rst_p(rst_p),.pb_debounced(start_debounced));
    debounce  P1 (.pb_in(pb_rst),.clk(clk_100hz),.rst_p(rst_p),.pb_debounced(rst_debounced));
    one_pulse P2 (.in_trig(start_debounced),.clk(clk_100hz),.rst_p(rst_p),.one_pulse(start_pulse));
    one_pulse P3 (.in_trig(rst_debounced),.clk(clk_100hz),.rst_p(rst_p),.one_pulse(rst_p));
    FSM  P4 (.pressed(start_pulse),.rst_p(rst_p),.clk(clk_100hz),.count_enable(count_enable_next));
    downcounter  D0 (.clk(clk_1hz),.rst_p(rst_p),.limit(4'd9),.decrease(count_enable),.inivalue(4'd0),.value(digit[0]),.borrow(br));
    downcounter  D1 (.clk(clk_1hz),.rst_p(rst_p),.limit(4'd2),.decrease(br),.inivalue(4'd3),.value(digit[1]));
    monitor_ctl  C2 (.digit3(4'b0),.digit2(4'b0),.digit1(digit[1]),.digit0(digit[0]),.clk(clk_cr),.rst_p(rst_p),.dis(dis),.bin_out(bin)); 
    display  P5 (.bin(bin),.segs(seg));
    always @*  begin
        led[7:1] <= 7'b0000000;
        led[0] <= count_enable;
        if (rst_p)  begin
            led[15:8] <= 8'b0;
            count_enable <= count_enable_next;
        end
        else if (digit[1] == 0 && digit[0] == 0) begin
            led[15:8] <= 8'b11111111;
            count_enable <= 1'b0;
        end
        else begin
            led[15:8] <= 8'b0;
            count_enable <= count_enable_next;
        end
    end
endmodule

