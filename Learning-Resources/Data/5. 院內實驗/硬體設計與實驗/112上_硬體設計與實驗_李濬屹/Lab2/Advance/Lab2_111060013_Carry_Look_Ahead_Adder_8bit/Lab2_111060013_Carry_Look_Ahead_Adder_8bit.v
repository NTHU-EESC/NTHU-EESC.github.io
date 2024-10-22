`timescale 1ns/1ps

module Carry_Look_Ahead_Adder_8bit(a, b, c0, s, c8);
    input [8-1:0] a, b;
    input c0;
    output [8-1:0] s;
    output c8;
    wire c1, c2, c3, c4, c5, c6, c7;
    wire [7:0] p, g;
    wire [3:0] p03, g03, p47, g47;

    PGS_Generator PGS0(.p(p[0]), .g(g[0]), .s(s[0]), .a(a[0]), .b(b[0]), .c(c0));
    PGS_Generator PGS1(.p(p[1]), .g(g[1]), .s(s[1]), .a(a[1]), .b(b[1]), .c(c1));
    PGS_Generator PGS2(.p(p[2]), .g(g[2]), .s(s[2]), .a(a[2]), .b(b[2]), .c(c2));
    PGS_Generator PGS3(.p(p[3]), .g(g[3]), .s(s[3]), .a(a[3]), .b(b[3]), .c(c3));

    PGS_Generator PGS4(.p(p[4]), .g(g[4]), .s(s[4]), .a(a[4]), .b(b[4]), .c(c4));
    PGS_Generator PGS5(.p(p[5]), .g(g[5]), .s(s[5]), .a(a[5]), .b(b[5]), .c(c5));
    PGS_Generator PGS6(.p(p[6]), .g(g[6]), .s(s[6]), .a(a[6]), .b(b[6]), .c(c6));
    PGS_Generator PGS7(.p(p[7]), .g(g[7]), .s(s[7]), .a(a[7]), .b(b[7]), .c(c7));

    CLA_Generator_4bits CLAG403(.pout(p03), .gout(g03), .c1(c1), .c2(c2), .c3(c3), .pin(p[3:0]), .gin(g[3:0]), .c0(c0));
    CLA_Generator_4bits CLAG447(.pout(p47), .gout(g47), .c1(c5), .c2(c6), .c3(c7), .pin(p[7:4]), .gin(g[7:4]), .c0(c4));

    CLA_Generator_2bits CLAG2(.c0(c0), .p03(p03), .g03(g03), .c4(c4), .p47(p47), .g47(g47), .c8(c8));

endmodule

module CLA_Generator_2bits(c0, p03, g03, c4, p47, g47, c8);
    input [3:0] p03, g03, p47, g47;
    input c0;
    output c8, c4;
    wire tmp_c4;

    And Copy(.out(c4), .a(tmp_c4), .b(1'b1));
    CarryCounter3 CC04(.c4(tmp_c4), .p(p03), .g(g03), .c0(c0));
    CarryCounter3 CC48(.c4(c8), .p(p47), .g(g47), .c0(tmp_c4));

endmodule

module CLA_Generator_4bits(pout, gout, c1, c2, c3, pin, gin, c0);
    input [3:0] pin, gin;
    input c0;
    output [3:0] pout, gout;
    output c1, c2, c3;

    CarryCounter0 CC0(.c1(c1), .p(pin[3:0]), .g(gin[3:0]), .c0(c0));
    CarryCounter1 CC1(.c2(c2), .p(pin[3:0]), .g(gin[3:0]), .c0(c0));
    CarryCounter2 CC2(.c3(c3), .p(pin[3:0]), .g(gin[3:0]), .c0(c0));

    BitwiseAnd AndP(.out(pout[3:0]), .a(pin[3:0]), .b(4'b1111));
    BitwiseAnd AndG(.out(gout[3:0]), .a(gin[3:0]), .b(4'b1111));

endmodule

module BitwiseAnd(out, a, b);
    input [3:0] a, b;
    output [3:0] out;

    And And3(.out(out[3]), .a(a[3]), .b(b[3]));
    And And2(.out(out[2]), .a(a[2]), .b(b[2]));
    And And1(.out(out[1]), .a(a[1]), .b(b[1]));
    And And0(.out(out[0]), .a(a[0]), .b(b[0]));

endmodule

module PGS_Generator(p, g, s, a, b, c);
    input a, b, c;
    output p, g, s;
    wire tmp;

    Or P(.out(p), .a(a), .b(b));
    And G(.out(g), .a(a), .b(b));
    Xor Tmp(.out(tmp), .a(a), .b(b));
    Xor S(.out(s), .a(tmp), .b(c));

endmodule

module CarryCounter0(c1, p, g, c0);
    input [3:0] p, g;
    input c0;
    output c1;
    wire p0_and_c0;

    And P0AndC0(.out(p0_and_c0), .a(p[0]), .b(c0));
    Or OrOut(.out(c1), .a(p0_and_c0), .b(g[0]));

endmodule

module CarryCounter1(c2, p, g, c0);
    input [3:0] p, g;
    input c0;
    output c2;
    wire [1:0] tmp;

    And AndTmp0(.out(tmp[0]), .a(p[1]), .b(g[0]));
    And_3to1 AndTmp1(.out(tmp[1]), .a(p[1]), .b(p[0]), .c(c0));

    Or_3to1 OrOut(.out(c2), .a(tmp[0]), .b(tmp[1]), .c(g[1]));

endmodule

module CarryCounter2(c3, p, g, c0);
    input [3:0] p, g;
    input c0;
    output c3;
    wire [2:0] tmp;

    And AndTmp0(.out(tmp[0]), .a(p[2]), .b(g[1]));
    And_3to1 AndTmp1(.out(tmp[1]), .a(p[2]), .b(p[1]), .c(g[0]));
    And_4to1 AndTmp2(.out(tmp[2]), .a(p[2]), .b(p[1]), .c(p[0]), .d(c0));

    Or_4to1 OrOut(.out(c3), .a(tmp[0]), .b(tmp[1]), .c(tmp[2]), .d(g[2]));

endmodule

module CarryCounter3(c4, p, g, c0);
    input [3:0] p, g;
    input c0;
    output c4;
    wire [3:0] tmp;

    And AndTmp0(.out(tmp[0]), .a(p[3]), .b(g[2]));
    And_3to1 AndTmp1(.out(tmp[1]), .a(p[3]), .b(p[2]), .c(g[1]));
    And_4to1 AndTmp2(.out(tmp[2]), .a(p[3]), .b(p[2]), .c(p[1]), .d(g[0]));
    And_5to1 AndTmp3(.out(tmp[3]), .a(p[3]), .b(p[2]), .c(p[1]), .d(p[0]), .e(c0));

    Or_5to1 OrOut(.out(c4), .a(tmp[0]), .b(tmp[1]), .c(tmp[2]), .d(tmp[3]), .e(g[3]));

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
    Not Not(.out(out), .in(a_nand_b));

endmodule

module And_3to1(out, a, b, c);
    input a, b, c;
    output out;
    wire a_and_b;

    And AAndB(.out(a_and_b), .a(a), .b(b));
    And AndOut(.out(out), .a(a_and_b), .b(c));

endmodule

module And_4to1(out, a, b, c, d);
    input a, b, c, d;
    output out;
    wire a_and_b, c_and_d;

    And AAndB(.out(a_and_b), .a(a), .b(b));
    And CAndD(.out(c_and_d), .a(c), .b(d));
    And AndOut(.out(out), .a(a_and_b), .b(c_and_d));

endmodule

module And_5to1(out, a, b, c, d, e);
    input a, b, c, d, e;
    output out;
    wire abcd;

    And_4to1 AndABCD(.out(abcd), .a(a), .b(b), .c(c), .d(d));
    And AndOut(.out(out), .a(abcd), .b(e));

endmodule

module Or(out, a, b);
    input a, b;
    output out;
    wire not_a, not_b;

    Not Not_a(.out(not_a), .in(a));
    Not Not_b(.out(not_b), .in(b));
    nand(out, not_a, not_b);

endmodule

module Or_3to1(out, a, b, c);
    input a, b, c;
    output out;
    wire a_or_b;

    Or AOrB(.out(a_or_b), .a(a), .b(b));
    Or OrOut(.out(out), .a(a_or_b), .b(c));

endmodule

module Or_4to1(out, a, b, c, d);
    input a, b, c, d;
    output out;
    wire a_or_b, c_or_d;

    Or AOrB(.out(a_or_b), .a(a), .b(b));
    Or COrD(.out(c_or_d), .a(c), .b(d));
    Or OrOut(.out(out), .a(a_or_b), .b(c_or_d));

endmodule

module Or_5to1(out, a, b, c, d, e);
    input a, b, c, d, e;
    output out;
    wire abcd;

    Or_4to1 OrABCD(.out(abcd), .a(a), .b(b), .c(c), .d(d));
    Or OrOut(.out(out), .a(abcd), .b(e));

endmodule

module Xor(out, a, b);
    input a, b;
    output out;
    wire not_a, not_b, na_and_b, a_and_nb;

    Not Not_a(.out(not_a), .in(a));
    Not Not_b(.out(not_b), .in(b));

    And NA_AND_B(.out(na_and_b), .a(not_a), .b(b));
    And A_AND_NB(.out(a_and_nb), .a(a), .b(not_b));

    Or Or(.out(out), .a(na_and_b), .b(a_and_nb));

endmodule