`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/13 09:00:01
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
    input sw_rst,
    input sw_dis,
    input clk_10mhz,
    output [3:0]dis,
    output [7:0]seg
    );
    wire mode_display;
    wire ampm;
    wire clk_1hz;
    wire clk_100hz;
    wire [3:0]value_12h[5:0];
    wire [3:0]value_24h[5:0];
    reg [3:0]value_dis_next[3:0];
    wire [3:0]value_dis[3:0];
    wire [3:0]bin;

    wire mode_debounced;
    wire mode_pulse;

    freq_div_1 clk1 (.clk(clk_10mhz),.rst_n(sw_rst),.clk_out(clk_1hz));
    freq_div_100 clk100 (.clk(clk_10mhz),.rst_n(sw_rst),.clk_out(clk_100hz));
    debounce A0 (.pb_in(pb_mode),.rst_n(sw_rst),.clk(clk_100hz),.pb_debounced(mode_debounced));
    one_pulse A1 (.in_trig(mode_debounced),.clk(clk_100hz),.rst_n(sw_rst),.one_pulse(mode_pulse));
    FSM_mode A2 (.pulse(mode_pulse),.clk(clk_100hz),.rst_n(sw_rst),.dis_hour(mode_display));
    upcounter12h C0 (.rst_n(sw_rst),.clk(clk_1hz),.value0_12h(value_12h[0]),.value1_12h(value_12h[1]),.value2_12h(value_12h[2])
                     ,.value3_12h(value_12h[3]),.value4_12h(value_12h[4]),.value5_12h(value_12h[5]),.ampm(ampm));
    upcounter24h C1 (.rst_n(sw_rst),.clk(clk_1hz),.value0_24h(value_24h[0]),.value1_24h(value_24h[1]),.value2_24h(value_24h[2])
                     ,.value3_24h(value_24h[3]),.value4_24h(value_24h[4]),.value5_24h(value_24h[5]));

     always@*
         case ({mode_display,sw_dis}) //mode_display 12hr is 0,24hr is 1
             2'b00:  begin
                 value_dis_next[3] <= 4'd0;
                 value_dis_next[2] <= 4'd0;
                 value_dis_next[1] <= value_12h[1];
                 value_dis_next[0] <= value_12h[0];
              end
              2'b01: begin
                    value_dis_next[3] <= value_12h[5];
                    value_dis_next[2] <= value_12h[4];
                    value_dis_next[1] <= value_12h[3];
                    value_dis_next[0] <= value_12h[2];
              end
              2'b10: begin
                  value_dis_next[3] <= 4'd0;
                  value_dis_next[2] <= 4'd0;
                  value_dis_next[1] <= value_24h[1];
                  value_dis_next[0] <= value_24h[0];
              end
              2'b11:begin
                   value_dis_next[3] <= value_24h[5];
                   value_dis_next[2] <= value_24h[4];
                   value_dis_next[1] <= value_24h[3];
                   value_dis_next[0] <= value_24h[2];
              end
              default:;
          endcase
      assign value_dis[0] = value_dis_next[0];
      assign value_dis[1] = value_dis_next[1];
      assign value_dis[2] = value_dis_next[2];
      assign value_dis[3] = value_dis_next[3];
      monitor_ctl C3 (.digit3(value_dis[3]),.digit2(value_dis[2]),.digit1(value_dis[1]),.digit0(value_dis[0])
                       ,.clk(clk_10mhz),.rst_n(sw_rst),.dis(dis),.bin_out(bin)); 
      display P5 (.bin(bin),.dot(ampm),.segs(seg));

endmodule
