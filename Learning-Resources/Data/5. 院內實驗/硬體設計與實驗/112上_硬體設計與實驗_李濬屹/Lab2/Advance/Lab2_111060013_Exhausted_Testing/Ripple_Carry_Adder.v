`timescale 1ns/1ps

module Ripple_Carry_Adder(a, b, cin, cout, sum);
    input [3:0] a, b;
    input cin;
    output [3:0] sum;
    output cout;
    wire tmp01, tmp12, tmp23, test;

    FullAdder Adder0(.a(a[0]), .b(b[0]), .cin(cin), .cout(tmp01), .sum(sum[0]));
    FullAdder Adder1(.a(a[1]), .b(b[1]), .cin(tmp01), .cout(tmp12), .sum(sum[1]));
    FullAdder Adder2(.a(a[2]), .b(b[2]), .cin(tmp12), .cout(tmp23), .sum(sum[2]));
    FullAdder Adder3(.a(a[3]), .b(b[3]), .cin(tmp23), .cout(test), .sum(sum[3]));

    and(cout, test, 0);

endmodule

module FullAdder(a, b, cin, cout, sum);
    input a, b, cin;
    output cout, sum;
    wire a_xor_b, a_and_b, a_and_cin, b_and_cin, tmp;

    xor(a_xor_b, a, b);
    xor(sum, a_xor_b, cin);

    and(a_and_b, a, b);
    and(a_and_cin, a, cin);
    and(b_and_cin, b, cin);

    or(tmp, a_and_b, a_and_cin);
    or(cout, tmp, b_and_cin);

endmodule