`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/10/24 16:20:35
// Design Name: 
// Module Name: test_b
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


module test_b;
    wire OUT;
    reg X,Y,Z;
    
    b_2 test(
        .x(X),
        .y(Y),
        .z(Z),
        .out(OUT)
        );

initial
begin
        X = 0;Y = 0;Z = 0;
   #10  X = 0;Y = 0;Z = 1;
   #10  X = 0;Y = 1;Z = 0;
   #10  X = 0;Y = 1;Z = 1;
   #10  X = 1;Y = 0;Z = 0;
   #10  X = 1;Y = 0;Z = 1;
   #10  X = 1;Y = 1;Z = 0;
   #10  X = 1;Y = 1;Z = 1;
   
end

endmodule
