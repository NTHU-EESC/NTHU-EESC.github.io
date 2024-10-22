`timescale 1ns/1ps

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