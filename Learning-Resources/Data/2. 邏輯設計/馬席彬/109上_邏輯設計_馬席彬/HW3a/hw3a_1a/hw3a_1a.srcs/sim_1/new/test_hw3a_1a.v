module test_hw3a_1a;
wire F;
reg W, X, Y, Z;
hw3a_1a_1 U0(.f(F),.w(W),.x(X),.y(Y),.z(Z));

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