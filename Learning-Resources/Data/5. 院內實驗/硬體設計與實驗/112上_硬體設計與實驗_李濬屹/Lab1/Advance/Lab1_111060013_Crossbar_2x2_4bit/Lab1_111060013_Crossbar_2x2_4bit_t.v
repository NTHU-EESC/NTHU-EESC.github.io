`timescale 1ns / 1ps

module testbench;
    reg [3:0] in1 = 4'b0000;
    reg [3:0] in2 = 4'b0001;
    reg control = 1'b0;
    wire [3:0] out1;
    wire [3:0] out2;

    Crossbar_2x2_4bit CB (
        .in1(in1),
        .in2(in2),
        .control(control),
        .out1(out1),
        .out2(out2)
    );

    initial begin
        #10 control = 1'b1;
        #10 control = 1'b0;
        #10 in1 = 4'b1111;
        in2 = 4'b1010;
        #10 control = 1'b1;
        #10 control = 1'b0;
        #10 $finish;
    end

endmodule
