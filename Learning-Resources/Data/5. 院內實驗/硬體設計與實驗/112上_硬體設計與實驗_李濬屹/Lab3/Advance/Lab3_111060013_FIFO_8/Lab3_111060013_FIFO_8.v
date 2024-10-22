`timescale 1ns/1ps

module FIFO_8(clk, rst_n, wen, ren, din, dout, error);
    input clk;
    input rst_n;
    input wen, ren;
    input [8-1:0] din;
    output reg [8-1:0] dout;
    output reg error;

    reg [3:0] rp, tmp_rp;
    reg [3:0] wp, tmp_wp;
    reg [7:0] DFF [7:0];
    reg [7:0] tmp_DFF [7:0];
    reg [7:0] tmp_out;
    reg tmp_err;

    always @ (*) begin
        if (!rst_n) begin
            tmp_DFF[7] = 8'd0;
            tmp_DFF[6] = 8'd0;
            tmp_DFF[5] = 8'd0;
            tmp_DFF[4] = 8'd0;
            tmp_DFF[3] = 8'd0;
            tmp_DFF[2] = 8'd0;
            tmp_DFF[1] = 8'd0;
            tmp_DFF[0] = 8'd0;
            tmp_rp = 4'b1000;
            tmp_wp = 4'b0111;
        end
        else begin
            if (ren) begin
                if (!tmp_err) begin
                    tmp_DFF[7] = DFF[7];
                    tmp_DFF[6] = DFF[6];
                    tmp_DFF[5] = DFF[5];
                    tmp_DFF[4] = DFF[4];
                    tmp_DFF[3] = DFF[3];
                    tmp_DFF[2] = DFF[2];
                    tmp_DFF[1] = DFF[1];
                    tmp_DFF[0] = DFF[0];
                    tmp_rp = rp + 4'b0001;
                    tmp_wp = wp + 4'b0001;
                end
                else begin
                    tmp_DFF[7] = DFF[7];
                    tmp_DFF[6] = DFF[6];
                    tmp_DFF[5] = DFF[5];
                    tmp_DFF[4] = DFF[4];
                    tmp_DFF[3] = DFF[3];
                    tmp_DFF[2] = DFF[2];
                    tmp_DFF[1] = DFF[1];
                    tmp_DFF[0] = DFF[0];
                    tmp_rp = rp;
                    tmp_wp = wp;
                end
            end
            else begin
                if (wen) begin
                    if (!tmp_err) begin
                        tmp_DFF[7] = din;
                        tmp_DFF[6] = DFF[7];
                        tmp_DFF[5] = DFF[6];
                        tmp_DFF[4] = DFF[5];
                        tmp_DFF[3] = DFF[4];
                        tmp_DFF[2] = DFF[3];
                        tmp_DFF[1] = DFF[2];
                        tmp_DFF[0] = DFF[1];
                        tmp_rp = rp - 4'b0001;
                        tmp_wp = wp - 4'b0001;
                    end
                    else begin
                        tmp_DFF[7] = DFF[7];
                        tmp_DFF[6] = DFF[6];
                        tmp_DFF[5] = DFF[5];
                        tmp_DFF[4] = DFF[4];
                        tmp_DFF[3] = DFF[3];
                        tmp_DFF[2] = DFF[2];
                        tmp_DFF[1] = DFF[1];
                        tmp_DFF[0] = DFF[0];
                        tmp_rp = rp;
                        tmp_wp = wp;
                    end
                end
                else begin
                    tmp_DFF[7] = DFF[7];
                    tmp_DFF[6] = DFF[6];
                    tmp_DFF[5] = DFF[5];
                    tmp_DFF[4] = DFF[4];
                    tmp_DFF[3] = DFF[3];
                    tmp_DFF[2] = DFF[2];
                    tmp_DFF[1] = DFF[1];
                    tmp_DFF[0] = DFF[0];
                    tmp_rp = rp;
                    tmp_wp = wp;
                end
            end
        end
    end

    always @ (posedge clk) begin
        DFF[7] <= tmp_DFF[7];
        DFF[6] <= tmp_DFF[6];
        DFF[5] <= tmp_DFF[5];
        DFF[4] <= tmp_DFF[4];
        DFF[3] <= tmp_DFF[3];
        DFF[2] <= tmp_DFF[2];
        DFF[1] <= tmp_DFF[1];
        DFF[0] <= tmp_DFF[0];
        rp <= tmp_rp;
        wp <= tmp_wp;
    end

    always @ (*) begin
        if (!rst_n) tmp_out = 8'd0;
        else tmp_out = DFF[rp];
    end

    always @ (posedge clk) begin
        dout <= tmp_out;
    end

    // error
    always @ (*) begin
        tmp_err = ((wp == 4'b1111) && rst_n && wen && !ren) || ((rp == 4'b1000) && rst_n && ren);
    end

    always @ (posedge clk) begin
        error <= tmp_err;
    end


endmodule
