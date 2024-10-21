`timescale 1ns/1ps
module stimulus;
  parameter cyc = 40;
  parameter delay = 4;

  reg clk, rst_n, start;
  reg [7:0] a, b;
  wire done, error;
  wire [7:0] y;

  integer latency;
  integer start_time, end_time;
  reg  start_flag = 1'b0;

  GCD gcd01 (
    .CLK(clk),
    .RST_N(rst_n),
    .A(a),
    .B(b),
    .START(start),
    .Y(y),
    .DONE(done),
    .ERROR(error)
  );

  always #(cyc/2) clk = ~clk;

  initial begin
`ifdef SYNTHESIS
    $sdf_annotate("gcd_syn.sdf", gcd01);
    $fsdbDumpfile("gcd_syn.fsdb");
`else
    $fsdbDumpfile("gcd.fsdb");
`endif
    $fsdbDumpvars;

    $monitor($time, " CLK=%b RST_N=%b START=%b A=%d B=%d | DONE=%b Y=%d ERROR=%b",
      clk, rst_n, start, a, b, done, y, error);
  end


  initial begin
    clk = 1;
    rst_n = 1;
    nop;
    data_in(0,0);
    #(cyc);
    #(delay) rst_n = 0;
    #(cyc*4) rst_n = 1;
//    #(cyc/2*5+delay) rst_n = 1;
//    #(cyc/2-delay);
    #(cyc*2);

    #(cyc) nop;

    #(cyc) load; data_in(8'd21, 8'd6);
    #(cyc) nop;
    @(posedge done); #(delay);
    
    #(cyc) load; data_in(8'd8, 8'd17);
    #(cyc) nop;
    @(posedge done); #(delay);

    #(cyc) load; data_in(8'd35, 8'd0);
    #(cyc) nop;
    @(posedge done); #(delay);

    #(cyc) load; data_in(8'd42, 8'd42);
    #(cyc) nop;
    @(posedge done); #(delay);

    #(cyc) load; data_in(8'd0, 8'd0);
    #(cyc) nop;
    @(posedge done); 


    #(cyc) nop;
    #(cyc*8);
//    $display("start: %d, end: %d", start_time, end_time);
    latency = (end_time - start_time)/cyc;
    $display("Latency: %d cycle(s)", latency);
    $finish;
  end

  always @(posedge clk) begin
    if (start == 1'b1) begin
      if (start_flag == 1'b0) begin
        start_flag = 1'b1;
        start_time = $time;
      end
    end
    if (done == 1'b1) begin
      end_time = $time;
    end
  end

  // tasks
  task nop;
    begin
      start = 0;
    end
  endtask
  task load;
    begin
      start = 1;
    end
  endtask
  task data_in;
    input [7:0] data1, data2;
    begin
      a = data1;
      b = data2;
    end
  endtask

endmodule
