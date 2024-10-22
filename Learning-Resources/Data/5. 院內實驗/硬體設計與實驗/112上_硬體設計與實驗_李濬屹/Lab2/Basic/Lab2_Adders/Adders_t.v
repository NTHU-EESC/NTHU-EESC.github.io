`timescale 1ns/1ps

module Adders_t;
reg a = 1'b0;
reg b = 1'b0;
reg cin = 1'b0;
wire ha_sum, ha_cout;
wire fa_sum, fa_cout;

Half_Adder ha(
    .a (a),
    .b (b),
    .cout (ha_cout),
    .sum (ha_sum)
);

Full_Adder fa(
    .a (a),
    .b (b),
    .cin (cin),
    .cout (fa_cout),
    .sum (fa_sum)
);

// uncommment and add "+access+r" to your nverilog command to dump fsdb waveform on NTHUCAD
// initial begin
//      $fsdbDumpfile("Adders.fsdb");
//      $fsdbDumpvars;
// end

initial begin
    repeat (2 ** 3) begin
        #1 {a, b, cin} = {a, b, cin} + 1'b1;
    end
    #1 $finish;
end
endmodule
