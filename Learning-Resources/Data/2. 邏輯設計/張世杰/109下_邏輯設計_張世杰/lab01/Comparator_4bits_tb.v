`timescale 1ns / 1ps

module Lab1_Team5_Comparator_4bits_tb;
reg [3:0] A,B;
wire A_lt_B, A_gt_B, A_eq_B;

Comparator_4bits c(A, B, A_lt_B, A_gt_B, A_eq_B);
initial begin

    A=4'b1010;
    B=4'b1010;
    // edit your own testbench
	
    $finish;    
end
initial begin
    $monitor("A = %b , B = %b , A_lt_B=%b,A_gt_B=%b,A_eq_B=%b",A,B,A_lt_B, A_gt_B, A_eq_B);
end
endmodule
