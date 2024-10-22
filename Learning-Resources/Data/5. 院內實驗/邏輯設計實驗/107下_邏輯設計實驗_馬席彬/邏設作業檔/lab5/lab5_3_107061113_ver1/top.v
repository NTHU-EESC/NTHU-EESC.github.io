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
    input pb_mode,
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
    wire mode_debounced;
    wire start_pulse;
    wire rst_pulse;
    wire hard_rst_pulse;
    wire mode_pulse;
    wire [3:0]mode_value[2:0];
    reg count_en;
    wire count_enable_next;
    wire [3:0]digit[2:0];
    wire [3:0]bin;
    wire br[1:0];
    

    freq_div_1  C0 (.clk(clk_cr),.rst_p(rst_p),.clk_out(clk_1hz));
    freq_div_100  C1 (.clk(clk_cr),.rst_p(rst_p),.clk_out(clk_100hz));
    debounce  P0 (.pb_in(pb_start),.clk(clk_100hz),.rst_p(rst_p),.pb_debounced(start_debounced));
    debounce  P1 (.pb_in(pb_mode),.clk(clk_100hz),.rst_p(rst_p),.pb_debounced(mode_debounced));
    one_pulse P2 (.in_trig(start_debounced),.clk(clk_100hz),.rst_p(rst_p),.one_pulse(start_pulse));
    one_pulse P3 (.in_trig(mode_debounced),.clk(clk_100hz),.rst_p(rst_p),.one_pulse(mode_pulse));
    reset_counter P4 (.in_trig(start_debounced),.clk(clk_100hz),.rst_p(rst_p),.rst_pulse(rst_p));
    FSM  P5 (.pressed(start_pulse),.rst_p(rst_p),.clk(clk_100hz),.count_enable(count_enable_next));
    FSM_mode  P6 (.pressed(mode_pulse),.rst_p(rst_p),.clk(clk_100hz),.mode_value_digit0(mode_value[0]),.mode_value_digit1(mode_value[1]),.mode_value_digit2(mode_value[2]));
    downcounter  D0 (.clk(clk_1hz),.rst_p(rst_p),.limit(4'd9),.decrease(count_en),.inivalue(mode_value[0]),.value(digit[0]),.borrow(br[0]));
    downcounter  D1 (.clk(clk_1hz),.rst_p(rst_p),.limit(4'd5),.decrease(br[0]),.inivalue(mode_value[1]),.value(digit[1]),.borrow(br[1]));
    downcounter  D2 (.clk(clk_1hz),.rst_p(rst_p),.limit(4'd1),.decrease(br[1]),.inivalue(mode_value[2]),.value(digit[2]));
    monitor_ctl  C2 (.digit3(4'b0),.digit2(digit[2]),.digit1(digit[1]),.digit0(digit[0]),.clk(clk_cr),.rst_p(rst_p),.dis(dis),.bin_out(bin)); 
    display  P7 (.bin(bin),.segs(seg));

 

    always @*
        if (rst_p)  begin
            led <= 16'b0;
            count_en <= count_enable_next;
        end
        else if (digit[2] == 0 && digit[1] == 0 && digit[0] == 0) begin
            led <= 16'b1111111111111111;
            count_en <= 1'b0;
        end
        else begin
            led <= 16'b0;
            count_en <= count_enable_next;
        end
endmodule
