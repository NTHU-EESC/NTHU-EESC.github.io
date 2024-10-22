`timescale 1ns/1ps

module Universal_Gate(out, a, b);
    input a, b;
    output out;
    wire not_b;

    not(not_b, b);
    and(out, a, not_b);

endmodule