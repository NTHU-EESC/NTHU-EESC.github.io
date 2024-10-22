`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/02/22 21:41:33
// Design Name: 
// Module Name: decoder
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


module decoder(in,en,d);
    input [2:0]in;
    input en;
    output [7:0]d;
    
assign d[0] = ~in[2] & ~in[1] & ~in[0] & en;
assign d[1] = ~in[2] & ~in[1] & in[0] & en;
assign d[2] = ~in[2] & in[1] & ~in[0] & en;
assign d[3] = ~in[2] & in[1] & in[0] & en;
assign d[4] = in[2] & ~in[1] & ~in[0] & en;
assign d[5] = in[2] & ~in[1] & in[0] & en;
assign d[6] = in[2] & in[1] & ~in[0] & en;
assign d[7] = in[2] & in[1] & in[0] & en;

endmodule
