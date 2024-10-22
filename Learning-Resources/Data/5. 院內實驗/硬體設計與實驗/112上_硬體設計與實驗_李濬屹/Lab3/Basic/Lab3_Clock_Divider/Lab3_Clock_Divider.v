`timescale 1ns/1ps

module Clock_Divider (clk, rst_n, sel, clk1_2, clk1_4, clk1_8, clk1_3, dclk);
    input clk, rst_n;
    input [2-1:0] sel;
    output clk1_2;
    output clk1_4;
    output clk1_8;
    output clk1_3;
    output dclk;

    reg dclk;
    reg clk1_3, clk1_2, clk1_4, clk1_8;
    reg tmp_clk1_3, tmp_clk1_2, tmp_clk1_4, tmp_clk1_8;
    reg [4:0] count2, count3, count4, count8;
    reg [4:0] tmp_count2, tmp_count3, tmp_count4, tmp_count8;

    always @ (sel or clk1_3 or clk1_2 or clk1_4 or clk1_8) begin
        case (sel)
            2'b00: dclk = clk1_3;
            2'b01: dclk = clk1_2;
            2'b10: dclk = clk1_4;
            2'b11: dclk = clk1_8;
        endcase
    end

    always @ (rst_n or count3 or count2 or count4 or count8) begin

        if (rst_n == 1'b0) begin
            tmp_clk1_3 = 1'b1;
            tmp_clk1_2 = 1'b1;
            tmp_clk1_4 = 1'b1;
            tmp_clk1_8 = 1'b1;
            tmp_count3 = 1'b0;
            tmp_count2 = 1'b0;
            tmp_count4 = 1'b0;
            tmp_count8 = 1'b0;
        end

        else begin

            if (count3 == 4'd2) begin
                tmp_count3 = 4'd0;
                tmp_clk1_3 = 1'b1;
            end
            else begin
                tmp_count3 = count3 + 4'd1;
                tmp_clk1_3 = 1'b0;
            end

            if (count2 == 4'd1) begin
                tmp_count2 = 4'd0;
                tmp_clk1_2 = 1'b1;
            end
            else begin
                tmp_count2 = count2 + 4'd1;
                tmp_clk1_2 = 1'b0;
            end

            if (count4 == 4'd3) begin
                tmp_count4 = 4'd0;
                tmp_clk1_4 = 1'b1;
            end
            else begin
                tmp_count4 = count4 + 4'd1;
                tmp_clk1_4 = 1'b0;
            end

            if (count8 == 4'd7) begin
                tmp_count8 = 4'd0;
                tmp_clk1_8 = 1'b1;
            end
            else begin
                tmp_count8 = count8 + 4'd1;
                tmp_clk1_8 = 1'b0;
            end

        end

    end

    always @ (posedge clk) begin
        clk1_3 <= tmp_clk1_3;
        clk1_2 <= tmp_clk1_2;
        clk1_4 <= tmp_clk1_4;
        clk1_8 <= tmp_clk1_8;
        count3 <= tmp_count3;
        count2 <= tmp_count2;
        count4 <= tmp_count4;
        count8 <= tmp_count8;
    end

endmodule
