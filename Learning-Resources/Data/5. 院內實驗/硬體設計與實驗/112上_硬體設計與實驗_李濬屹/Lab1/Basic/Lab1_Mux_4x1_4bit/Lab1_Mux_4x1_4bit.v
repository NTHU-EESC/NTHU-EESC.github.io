`timescale 1ns/1ps

module Mux_4x1_4bit(a, b, c, d, sel, f);
input [4-1:0] a, b, c, d;
input [2-1:0] sel;
output [4-1:0] f;

wire a_not1, a_not0, a_sig;
wire b_not1, b_sig;
wire c_not0, c_sig;
wire d_sig;
wire [3:0] A, B, C, D, A_B, C_D;

not(a_not1, sel[1]);
not(a_not0, sel[0]);
not(b_not1, sel[1]);
not(c_not0, sel[0]);

and(a_sig, a_not1, a_not0);
and(b_sig, b_not1, sel[0]);
and(c_sig, sel[1], c_not0);
and(d_sig, sel[1], sel[0]);

and(A[3], a_sig, a[3]);
and(A[2], a_sig, a[2]);
and(A[1], a_sig, a[1]);
and(A[0], a_sig, a[0]);

and(B[3], b_sig, b[3]);
and(B[2], b_sig, b[2]);
and(B[1], b_sig, b[1]);
and(B[0], b_sig, b[0]);

and(C[3], c_sig, c[3]);
and(C[2], c_sig, c[2]);
and(C[1], c_sig, c[1]);
and(C[0], c_sig, c[0]);

and(D[3], d_sig, d[3]);
and(D[2], d_sig, d[2]);
and(D[1], d_sig, d[1]);
and(D[0], d_sig, d[0]);

or(A_B[3], A[3], B[3]);
or(A_B[2], A[2], B[2]);
or(A_B[1], A[1], B[1]);
or(A_B[0], A[0], B[0]);

or(C_D[3], C[3], D[3]);
or(C_D[2], C[2], D[2]);
or(C_D[1], C[1], D[1]);
or(C_D[0], C[0], D[0]);

or(f[3], A_B[3], C_D[3]);
or(f[2], A_B[2], C_D[2]);
or(f[1], A_B[1], C_D[1]);
or(f[0], A_B[0], C_D[0]);

endmodule
