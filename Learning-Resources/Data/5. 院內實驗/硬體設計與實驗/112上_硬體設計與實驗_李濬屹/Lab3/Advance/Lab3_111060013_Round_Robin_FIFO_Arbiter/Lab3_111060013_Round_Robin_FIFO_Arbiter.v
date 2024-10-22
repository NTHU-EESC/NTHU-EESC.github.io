`timescale 1ns/1ps

module Round_Robin_FIFO_Arbiter(clk, rst_n, wen, a, b, c, d, dout, valid);
    input clk;
    input rst_n;
    input [4-1:0] wen;
    input [8-1:0] a, b, c, d;
    output reg [8-1:0] dout;
    output reg valid;

    wire [7:0] QA_Mux, QB_Mux, QC_Mux, QD_Mux;
    wire [3:0] err;
    reg [3:0] ren, rst_ren;
    reg[7:0] tmp_dout, mux_dout;
    wire [3:0] real_ren;
    reg [3:0] clk_wen;

    always @ (posedge clk) begin
        clk_wen <= wen;
    end

    assign real_ren[3] = !wen[3] && ren[3];
    assign real_ren[2] = !wen[2] && ren[2];
    assign real_ren[1] = !wen[1] && ren[1];
    assign real_ren[0] = !wen[0] && ren[0];

    // dout
    always @ (*) begin
        if (!rst_n) begin
            tmp_dout = 8'd0;
        end
        else begin
            case (real_ren)
                4'b0001: tmp_dout = QA_Mux;
                4'b0010: tmp_dout = QB_Mux;
                4'b0100: tmp_dout = QC_Mux;
                4'b1000: tmp_dout = QD_Mux;
                default: tmp_dout = 8'd0;
            endcase
        end
    end

    always @ (posedge clk) begin
        mux_dout <= tmp_dout;
    end

    always @ (*) begin
        if (valid) dout = mux_dout;
        else dout = 8'd0;
    end

    always @ (*) begin
        case (ren)
            4'b0001: valid = !err[3] && (({ren[0], ren[3:1]} & clk_wen) == 4'b0000);
            4'b0010: valid = !err[0] && (({ren[0], ren[3:1]} & clk_wen) == 4'b0000);
            4'b0100: valid = !err[1] && (({ren[0], ren[3:1]} & clk_wen) == 4'b0000);
            4'b1000: valid = !err[2] && (({ren[0], ren[3:1]} & clk_wen) == 4'b0000);
            default: valid = 8'd0;
        endcase
        // valid = (err == 4'b0000) && (({ren[0], ren[3:1]} & clk_wen) == 4'b0000);
    end

    // count ren
    always @ (*) begin
        case (rst_n)
            1'b0: rst_ren = 4'b0001;
            1'b1: rst_ren = {ren[2:0], ren[3]};
            default: rst_ren = ren;
        endcase
    end

    always @ (posedge clk) begin
        ren <= rst_ren;
    end

    FIFO_8 QueueA(
        .clk(clk),
        .rst_n(rst_n),
        .wen(wen[0]),
        .ren(real_ren[0]),
        .din(a),
        .dout(QA_Mux),
        .error(err[0])
    );

    FIFO_8 QueueB(
        .clk(clk),
        .rst_n(rst_n),
        .wen(wen[1]),
        .ren(real_ren[1]),
        .din(b),
        .dout(QB_Mux),
        .error(err[1])
    );

    FIFO_8 QueueC(
        .clk(clk),
        .rst_n(rst_n),
        .wen(wen[2]),
        .ren(real_ren[2]),
        .din(c),
        .dout(QC_Mux),
        .error(err[2])
    );

    FIFO_8 QueueD(
        .clk(clk),
        .rst_n(rst_n),
        .wen(wen[3]),
        .ren(real_ren[3]),
        .din(d),
        .dout(QD_Mux),
        .error(err[3])
    );

endmodule

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
        dout = DFF[rp];
    end

    // error
    always @ (*) begin
        if (!rst_n) tmp_err = 1'b1;
        else tmp_err = ((wp == 4'b1111) && wen == 1'b1) || ((rp == 4'b1000) && ren == 1'b1);
    end

    always @ (posedge clk) begin
        error <= tmp_err;
    end


endmodule
