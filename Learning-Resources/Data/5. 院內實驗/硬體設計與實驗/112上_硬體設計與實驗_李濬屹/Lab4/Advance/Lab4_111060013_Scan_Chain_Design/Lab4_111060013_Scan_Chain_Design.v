`timescale 1ns/1ps

module Scan_Chain_Design(clk, rst_n, scan_in, scan_en, scan_out);
    input clk;
    input rst_n;
    input scan_in;
    input scan_en;
    output wire scan_out;
    wire out_76, out_65, out_54, out_43, out_32, out_21, out_10;
    wire [3:0] a, b;
    wire [7:0] multi_ans;

    assign a = {out_76, out_65, out_54, out_43};
    assign b = {out_32, out_21, out_10, scan_out};
    assign multi_ans = a * b;

    SDFF SDFF7(clk, scan_in, scan_en, multi_ans[7], rst_n, out_76);
    SDFF SDFF6(clk, out_76, scan_en, multi_ans[6], rst_n, out_65);
    SDFF SDFF5(clk, out_65, scan_en, multi_ans[5], rst_n, out_54);
    SDFF SDFF4(clk, out_54, scan_en, multi_ans[4], rst_n, out_43);

    SDFF SDFF3(clk, out_43, scan_en, multi_ans[3], rst_n, out_32);
    SDFF SDFF2(clk, out_32, scan_en, multi_ans[2], rst_n, out_21);
    SDFF SDFF1(clk, out_21, scan_en, multi_ans[1], rst_n, out_10);
    SDFF SDFF0(clk, out_10, scan_en, multi_ans[0], rst_n, scan_out);

endmodule

module SDFF(clk, scan_in, scan_en, data, rst_n, out);
    input clk, scan_in, scan_en, data, rst_n;
    output reg out;

    reg tmp_out;

    always @ (posedge clk) begin
        out <= tmp_out;
    end

    always @ (*) begin
        if (rst_n == 1'b0) begin
            tmp_out = 1'b0;
        end
        else begin
            if (scan_en) tmp_out = scan_in;
            else tmp_out = data;
        end
    end

endmodule