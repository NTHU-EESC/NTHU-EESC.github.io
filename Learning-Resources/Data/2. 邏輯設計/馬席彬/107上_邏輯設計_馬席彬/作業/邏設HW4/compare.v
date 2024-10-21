`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/20 18:41:24
// Design Name: 
// Module Name: compare
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


module compare(a,b,c,out);
    input [2:0] a,b,c;
    wire x1,x2,y1,y2,abigb,bbigc;
    output out;

    assign x2 = (a[2] & b[2]) + (( ~ a[2]) & ( ~ b[2]));
    assign x1 = (a[1] & b[1]) + (( ~ a[1]) & ( ~ b[1]));
    assign y2 = (b[2] & c[2]) + (( ~ b[2]) & ( ~ c[2]));
    assign y1 = (b[1] & c[1]) + (( ~ b[1]) & ( ~ c[1]));
    
    assign abigb = (a[2] & ( ~ b[2])) + (x2 & (a[1] & ( ~ b[1]))) + (x1 & x2 & (a[0] & ( ~ b[0])));
    assign bbigc = (b[2] & ( ~ c[2])) + (y2 & (b[1] & ( ~ c[1]))) + (y1 & y2 & (b[0] & ( ~ c[0])));
    assign out = abigb & bbigc;
    
endmodule
