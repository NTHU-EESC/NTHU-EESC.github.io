`timescale 1ns/1ps

`timescale 1ns/1ps

module Mux_4x1_4bit_t;
reg [3:0]a = 4'b0000;
reg [3:0]b = 4'b0010;
reg [3:0]c = 4'b0100;
reg [3:0]d = 4'b1000;
reg [1:0]sel = 2'b0;
wire [3:0]f;

Mux_4x1_4bit m1(
    .a (a),
    .b (b),
    .c (c),
    .d (d),
    .sel (sel),
    .f (f)
);

// uncommment and add "+access+r" to your nverilog command to dump fsdb waveform on NTHUCAD
// initial begin
//      $fsdbDumpfile("MUX.fsdb");
//      $fsdbDumpvars;
// end

initial begin
    repeat (2 ** 3) begin
        #1 sel = sel + 2'b1;
        a = a + 4'b1;
        b = b + 4'b1;
        c = c + 4'b1;
        d = d + 4'b1;
    end
    #1 $finish;
end
endmodule
