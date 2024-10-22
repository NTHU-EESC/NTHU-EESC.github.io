`timescale 1ns/1ps

module D_Flip_Flop_t;

// input and output signals
reg clk = 1'b0;
reg d = 1'b0;
wire q;

// generate clk
always#(1) clk = ~clk;

// test instance instantiation
D_Flip_Flop DFF(
    .clk(clk),
    .d(d),
    .q(q)
);

// uncommment and add "+access+r" to your nverilog command to dump fsdb waveform on NTHUCAD
// initial begin
//      $fsdbDumpfile("DFF.fsdb");
//      $fsdbDumpvars;
// end

// brute force 
initial begin
    @(negedge clk) d = 1'b1;
    @(negedge clk) d = 1'b0;
    @(negedge clk) $finish;
end

endmodule