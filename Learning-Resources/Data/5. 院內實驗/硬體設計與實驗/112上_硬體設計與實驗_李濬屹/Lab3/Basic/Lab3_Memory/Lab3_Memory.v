`timescale 1ns/1ps

module Memory (clk, ren, wen, addr, din, dout);
    input clk;
    input ren, wen;
    input [7-1:0] addr;
    input [8-1:0] din;
    output [8-1:0] dout;

    reg [7:0] dout;
    reg [7:0] memory [127:0];

    always @(posedge clk) begin
        if ((ren == 1'b1 && wen == 1'b1) || (ren == 1'b1 && wen == 1'b0)) begin
            dout[7:0] <= memory[addr];
        end
        else if (wen == 1'b1 && ren == 1'b0) begin
            memory[addr] <= din[7:0];
            dout <= 8'd0;
        end
        else begin
            dout <= 8'd0;
        end
    end

endmodule
