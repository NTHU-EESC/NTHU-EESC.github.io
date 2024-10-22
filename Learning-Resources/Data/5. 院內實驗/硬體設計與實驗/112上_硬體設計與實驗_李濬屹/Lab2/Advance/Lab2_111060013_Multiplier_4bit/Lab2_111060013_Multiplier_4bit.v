`timescale 1ns/1ps

module Multiplier_4bit(a, b, p);
    input [4-1:0] a, b;
    output [8-1:0] p;
    wire [3:0] tmp0, tmp1, tmp2, tmp3;
    wire [7:0] tmp01, tmp23;
    wire cout01, cout23, cout0123;

    Multiplier_4x1 Tmp0(.out(tmp0), .a(a), .b(b[0]));
    Multiplier_4x1 Tmp1(.out(tmp1), .a(a), .b(b[1]));
    Multiplier_4x1 Tmp2(.out(tmp2), .a(a), .b(b[2]));
    Multiplier_4x1 Tmp3(.out(tmp3), .a(a), .b(b[3]));

    Ripple_Carry_Adder RCA01(
        .a({4'b0000, tmp0}),
        .b({3'b000, tmp1, 1'b0}),
        .cin(1'b0),
        .cout(cout01),
        .sum(tmp01)
    );

    Ripple_Carry_Adder RCA23(
        .a({2'b00, tmp2, 2'b00}),
        .b({1'b0, tmp3, 3'b0}),
        .cin(1'b0),
        .cout(cout23),
        .sum(tmp23)
    );

    Ripple_Carry_Adder RCA0123(
        .a(tmp01),
        .b(tmp23),
        .cin(1'b0),
        .cout(tmp0123),
        .sum(p)
    );

endmodule

module Multiplier_4x1(out, a, b);
    input [3:0] a;
    input b;
    output [3:0] out;

    And A0(.out(out[0]), .a(a[0]), .b(b));
    And A1(.out(out[1]), .a(a[1]), .b(b));
    And A2(.out(out[2]), .a(a[2]), .b(b));
    And A3(.out(out[3]), .a(a[3]), .b(b));

endmodule

module Ripple_Carry_Adder(a, b, cin, cout, sum);
    input [8-1:0] a, b;
    input cin;
    output cout;
    output [8-1:0] sum;
    wire [6:0] carry;

    Full_Adder FA0(.a(a[0]), .b(b[0]), .cin(cin), .cout(carry[0]), .sum(sum[0]));
    Full_Adder FA1(.a(a[1]), .b(b[1]), .cin(carry[0]), .cout(carry[1]), .sum(sum[1]));
    Full_Adder FA2(.a(a[2]), .b(b[2]), .cin(carry[1]), .cout(carry[2]), .sum(sum[2]));
    Full_Adder FA3(.a(a[3]), .b(b[3]), .cin(carry[2]), .cout(carry[3]), .sum(sum[3]));
    Full_Adder FA4(.a(a[4]), .b(b[4]), .cin(carry[3]), .cout(carry[4]), .sum(sum[4]));
    Full_Adder FA5(.a(a[5]), .b(b[5]), .cin(carry[4]), .cout(carry[5]), .sum(sum[5]));
    Full_Adder FA6(.a(a[6]), .b(b[6]), .cin(carry[5]), .cout(carry[6]), .sum(sum[6]));
    Full_Adder FA7(.a(a[7]), .b(b[7]), .cin(carry[6]), .cout(cout), .sum(sum[7]));
    
endmodule

module Full_Adder (a, b, cin, cout, sum);
    input a, b, cin;
    output cout, sum;
    wire a_xor_b;

    Majority FullCarryOut(a, b, cin, cout);
    Xor AXorB(a_xor_b, a, b);
    Xor FullSum(sum, a_xor_b, cin);

endmodule

module Majority(a, b, c, out);
    input a, b, c;
    output out;
    wire a_and_b, a_and_c, b_and_c, tmp_or;

    And AAndB(a_and_b, a, b);
    And AAndC(a_and_c, a, c);
    And BAndC(b_and_c, b, c);
    Or TmpOr(tmp_or, a_and_b, a_and_c);
    Or Out(out, tmp_or, b_and_c);

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