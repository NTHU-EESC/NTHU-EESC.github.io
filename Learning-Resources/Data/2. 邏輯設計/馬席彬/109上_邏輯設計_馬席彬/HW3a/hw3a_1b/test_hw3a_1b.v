`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/24 16:53:40
// Design Name: 
// Module Name: test_hw3a_1b
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


module test_hw3a_1b;
wire F;
reg W, X, Y, Z;

hw3a_1b_2 U0(.f(F),.w(W),.x(X),.y(Y),.z(Z));

initial
begin
W=0;X=0;Y=0;Z=0;
#10 W=0;X=0;Y=0;Z=1;
#10 W=0;X=0;Y=1;Z=0;
#10 W=0;X=0;Y=1;Z=1;
#10 W=0;X=1;Y=0;Z=0;
#10 W=0;X=1;Y=0;Z=1;
#10 W=0;X=1;Y=1;Z=0;
#10 W=0;X=1;Y=1;Z=1;
#10 W=1;X=0;Y=0;Z=0;
#10 W=1;X=0;Y=0;Z=1;
#10 W=1;X=0;Y=1;Z=0;
#10 W=1;X=0;Y=1;Z=1;
#10 W=1;X=1;Y=0;Z=0;
#10 W=1;X=1;Y=0;Z=1;
#10 W=1;X=1;Y=1;Z=0;
#10 W=1;X=1;Y=1;Z=1;
end
endmodule
