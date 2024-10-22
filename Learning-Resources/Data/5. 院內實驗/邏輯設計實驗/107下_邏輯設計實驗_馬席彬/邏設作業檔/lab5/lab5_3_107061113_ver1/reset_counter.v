`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/28 19:08:28
// Design Name: 
// Module Name: reset_counter
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


module reset_counter(
    input in_trig,
    input clk,
    input rst_p,
    output reg rst_pulse
    );
    reg [7:0]rst_counter;
    reg [7:0]rst_counter_temp;
    
 always @*
     if (rst_counter >= 8'd100) begin
         rst_counter_temp <= 8'b0;
         rst_pulse <= 1'b1;
     end
     else if (in_trig) begin 
         rst_counter_temp <= rst_counter + 8'd1;
         rst_pulse <= 1'b0;
     end
     else begin 
         rst_counter_temp <= 8'b0;
         rst_pulse <= 1'b0;
     end
          
always @(posedge clk or posedge rst_p)
    if (rst_p)  rst_counter <= 8'b0; 
    else rst_counter <= rst_counter_temp;
        
endmodule
