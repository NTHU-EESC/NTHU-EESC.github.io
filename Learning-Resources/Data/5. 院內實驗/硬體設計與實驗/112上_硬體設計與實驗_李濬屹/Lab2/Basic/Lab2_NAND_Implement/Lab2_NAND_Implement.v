`timescale 1ns/1ps

module NAND_Implement (a, b, sel, out);
    input a, b;
    input [3-1:0] sel;
    output out;
    wire tmp0, tmp1, tmp2, tmp3, tmp4, tmp5, tmp67;

    nand(tmp0, a, b);
    And And(tmp1, a, b);
    Or Or(tmp2, a, b);
    Nor Nor(tmp3, a, b);
    Xor Xor(tmp4, a, b);
    Xnor Xnor(tmp5, a, b);
    Not Not6(tmp67, a);

    Mux_8to1 Mux(out, tmp0, tmp1, tmp2, tmp3, tmp4, tmp5, tmp67, tmp67, sel);

endmodule

module Mux_2to1(out, in0, in1, sel);
    input in0, in1, sel;
    output out;
    wire not_sel, tmp0, tmp1;

    Not Not(not_sel, sel);

    And And0(tmp0, in0, not_sel);
    And And1(tmp1, in1, sel);

    Or Or(out, tmp0, tmp1);

endmodule

module Mux_4to1(out, in0, in1, in2, in3, sel);
    input in0, in1, in2, in3;
    input [1:0] sel;
    output out;
    wire tmp0, tmp1;

    Mux_2to1 Mux0(tmp0, in0, in2, sel[1]);
    Mux_2to1 Mux1(tmp1, in1, in3, sel[1]);

    Mux_2to1 MuxOut(out, tmp0, tmp1, sel[0]);

endmodule

module Mux_8to1(out, in0, in1, in2, in3, in4, in5, in6, in7, sel);
    input in0, in1, in2, in3, in4, in5, in6, in7;
    input [2:0] sel;
    output out;
    wire tmp0, tmp1;

    Mux_4to1 Mux0(tmp0, in0, in2, in4, in6, sel[2:1]);
    Mux_4to1 Mux1(tmp1, in1, in3, in5, in7, sel[2:1]);

    Mux_2to1 MuxOut(out, tmp0, tmp1, sel[0]);

endmodule

module Not(out, in);
    input in;
    output out;

    nand(out, in, in);

endmodule

module And(out, a, b);
    input a, b;
    output out;
    wire a_nand_b;

    nand(a_nand_b, a, b);
    Not Not(out, a_nand_b);

endmodule

module Or(out, a, b);
    input a, b;
    output out;
    wire not_a, not_b;

    Not Not_a(not_a, a);
    Not Not_b(not_b, b);
    nand(out, not_a, not_b);

endmodule

module Nor(out, a, b);
    input a, b;
    output out;
    wire a_or_b;

    Or Or(a_or_b, a, b);
    Not Not(out, a_or_b);

endmodule

module Xor(out, a, b);
    input a, b;
    output out;
    wire not_a, not_b, na_and_b, a_and_nb;

    Not Not_a(not_a, a);
    Not Not_b(not_b, b);

    And NA_AND_B(na_and_b, not_a, b);
    And A_AND_NB(a_and_nb, a, not_b);

    Or Or(out, na_and_b, a_and_nb);

endmodule

module Xnor(out, a, b);
    input a, b;
    output out;
    wire a_xor_b;

    Xor Xor(a_xor_b, a, b);
    Not Not(out, a_xor_b);

endmodule