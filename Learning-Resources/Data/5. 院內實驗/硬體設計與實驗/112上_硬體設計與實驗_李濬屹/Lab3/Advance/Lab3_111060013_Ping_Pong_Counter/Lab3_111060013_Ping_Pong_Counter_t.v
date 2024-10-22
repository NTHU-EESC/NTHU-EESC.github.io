`timescale 1ns / 1ps

module Lab3_111060013_Ping_Pong_Counter_t;
    reg clk = 1'b1;
    reg rst_n = 1'b1;
    reg enable = 1'b0;
    wire direction;
    wire [4-1:0] out;

    always#(1) clk = ~clk;

    Ping_Pong_Counter PPC(
        .clk(clk),
        .rst_n(rst_n),
        .enable(enable),
        .direction(direction),
        .out(out)
    );

    initial begin
        #1 rst_n <= 1'b0;
        #2 rst_n <= 1'b1;
           enable <= 1'b1;
        #50 enable <= 1'b0;
        #24 enable <= 1'b1;
        #24 rst_n <= 1'b0;
        #2 rst_n <= 1'b1;
        #50 $finish;
    end

endmodule
