`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/10/24 16:20:35
// Design Name: 
// Module Name: test_a
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


module test_a;
    wire OUT;
    reg W,X,Y,Z;
    
    a_2 test(
        .w(W),
        .x(X),
        .y(Y),
        .z(Z),
        .out(OUT)
        );

initial
begin
        X = 0;Y = 0;Z = 0;W = 0;
   #10  X = 0;Y = 0;Z = 0;W = 1;
   #10  X = 0;Y = 0;Z = 1;W = 0;
   #10  X = 0;Y = 0;Z = 1;W = 1;
   #10  X = 0;Y = 1;Z = 0;W = 0;
   #10  X = 0;Y = 1;Z = 0;W = 1;
   #10  X = 0;Y = 1;Z = 1;W = 0;
   #10  X = 0;Y = 1;Z = 1;W = 1;
   #10  X = 1;Y = 0;Z = 0;W = 0;
   #10  X = 1;Y = 0;Z = 0;W = 1;
   #10  X = 1;Y = 0;Z = 1;W = 0;
   #10  X = 1;Y = 0;Z = 1;W = 1;
   #10  X = 1;Y = 1;Z = 0;W = 0;
   #10  X = 1;Y = 1;Z = 0;W = 1;
   #10  X = 1;Y = 1;Z = 1;W = 0;
   #10  X = 1;Y = 1;Z = 1;W = 1;
end

endmodule
