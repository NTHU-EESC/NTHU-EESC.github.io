`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/05 19:42:17
// Design Name: 
// Module Name: compare4
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


module compare4(
    input [3:0]A,
    input [3:0]B,
    output [7:0]seg,
    output [7:0]led
    );
    wire [3:0]X;
display U0 (.bin(X),.segs(seg));
assign X = ( A <= B ) ? 4'd0 : 4'd1; 
assign led = { A , B };

endmodule
