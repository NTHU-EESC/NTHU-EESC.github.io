`timescale 1ns / 1ps

module Lab4_111060013_Built_In_Self_Test_fpga(clk, rst_n, dclk, scan_en, rst_val, SSD_out, SSD_bit, a, b);
    input clk, rst_n, dclk, scan_en;
    input [7:0] rst_val;
    output wire [7:0] SSD_out;
    output wire [3:0] SSD_bit, a, b;
    wire db_rst_n, db_dclk, op_rst_n, op_dclk;
    wire dclk_ssd, dclk_db;

    Debounce DB_RST_N(clk, rst_n, db_rst_n, dclk_db);
    Debounce DB_DCLK(clk, dclk, db_dclk, dclk_db);

    One_Pulse OP_RST_N(clk, db_rst_n, op_rst_n);
    One_Pulse OP_DCLK(clk, db_dclk, op_dclk);

    Clock_Divider_SSD CDS(clk, !op_rst_n, dclk_ssd);
    Clock_Divider_DB CDD(clk, !op_rst_n, dclk_db);

    SSD_Decoder SD(dclk_ssd, scan_in, a, b, scan_out, SSD_out, SSD_bit, !op_rst_n);

    Built_In_Self_Test BIST(clk, !op_rst_n, scan_en, scan_in, scan_out, op_dclk, a, b, rst_val);


endmodule

module SSD_Decoder(dclk_ssd, scan_in, a, b, scan_out, SSD_out, SSD_bit, rst_n);
    input dclk_ssd, scan_in, scan_out, rst_n;
    input [3:0] a, b;
    output reg [7:0] SSD_out;
    output reg [3:0] SSD_bit;
    reg [7:0] tmp_out;
    reg [3:0] tmp_bit;
    reg [7:0] mux_in, mux_a, mux_b, mux_out;

    always @ (posedge dclk_ssd) begin
        SSD_bit <= tmp_bit;
    end

    always @ (*) begin
        if (rst_n == 1'b0) begin
            SSD_out = 8'd0;
            tmp_bit = 4'b0111;
        end
        else begin
            case (SSD_bit)
                4'b0111: SSD_out = mux_in;
                4'b1011: SSD_out = mux_a;
                4'b1101: SSD_out = mux_b;
                4'b1110: SSD_out = mux_out;
                default: SSD_out = 8'd0;
            endcase
            tmp_bit = {SSD_bit[0], SSD_bit[3:1]};
        end
    end

    always @ (*) begin
        if (scan_in) mux_in = 8'b10011111;
        else mux_in = 8'b00000011;
    end

    always @ (*) begin
        case (a)
            4'h0: mux_a = 8'b00000011;
            4'h1: mux_a = 8'b10011111;
            4'h2: mux_a = 8'b00100101;
            4'h3: mux_a = 8'b00001101;
            4'h4: mux_a = 8'b10011001;
            4'h5: mux_a = 8'b01001001;
            4'h6: mux_a = 8'b01000001;
            4'h7: mux_a = 8'b00011011;
            4'h8: mux_a = 8'b00000001;
            4'h9: mux_a = 8'b00001001;
            4'ha: mux_a = 8'b00010001;
            4'hb: mux_a = 8'b11000001;
            4'hc: mux_a = 8'b01100011;
            4'hd: mux_a = 8'b10000101;
            4'he: mux_a = 8'b01100001;
            4'hf: mux_a = 8'b01110001;
            default: mux_a = 8'b00000000;
        endcase
    end

    always @ (*) begin
        case (b)
            4'h0: mux_b = 8'b00000011;
            4'h1: mux_b = 8'b10011111;
            4'h2: mux_b = 8'b00100101;
            4'h3: mux_b = 8'b00001101;
            4'h4: mux_b = 8'b10011001;
            4'h5: mux_b = 8'b01001001;
            4'h6: mux_b = 8'b01000001;
            4'h7: mux_b = 8'b00011011;
            4'h8: mux_b = 8'b00000001;
            4'h9: mux_b = 8'b00001001;
            4'ha: mux_b = 8'b00010001;
            4'hb: mux_b = 8'b11000001;
            4'hc: mux_b = 8'b01100011;
            4'hd: mux_b = 8'b10000101;
            4'he: mux_b = 8'b01100001;
            4'hf: mux_b = 8'b01110001;
            default: mux_b = 8'b00000000;
        endcase
    end

    always @ (*) begin
        if (scan_out) mux_out = 8'b10011111;
        else mux_out = 8'b00000011;
    end

endmodule

module Debounce(clk, in, out, dclk_db);
    input clk, in, dclk_db;
    output wire out;
    reg [3:0] DFF;

    assign out = DFF == 4'hf;

    always @ (posedge clk) begin
        if (dclk_db) DFF <= {DFF[2:0], in};
        else DFF <= DFF;
    end

endmodule

module One_Pulse(clk, in, out);
    input clk, in;
    output reg out;
    reg tmp;

    always @ (posedge clk) begin
        tmp <= in;
        out <= in && (!tmp);
    end

endmodule

module Clock_Divider_DB(clk, rst_n, dclk_db);
    input clk, rst_n;
    output reg dclk_db;
    reg tmp_dclk;
    reg [19:0] count, tmp_count;

    always @ (posedge clk) begin
        dclk_db <= tmp_dclk;
        count <= tmp_count;
    end

    always @ (*) begin
        if (count == 20'hfffff) begin
            tmp_dclk = 1'b1;
            tmp_count = 20'd0;
        end
        else begin
            tmp_dclk = 1'b0;
            tmp_count = count + 20'd1;
        end
    end

endmodule

module Clock_Divider_SSD(clk, rst_n, dclk_ssd);
    input clk, rst_n;
    output reg dclk_ssd;
    reg tmp_dclk;
    reg [16:0] count, tmp_count;

    always @ (posedge clk) begin
        dclk_ssd <= tmp_dclk;
        count <= tmp_count;
    end

    always @ (*) begin
        /*if (rst_n == 1'b0) begin
            tmp_dclk = 1'b0;
            tmp_count = 17'd0;
        end
        else begin*/
            if (count == 17'h1ffff) begin
                tmp_dclk = 1'b1;
                tmp_count = 17'd0;
            end
            else begin
                tmp_dclk = 1'b0;
                tmp_count = count + 17'd1;
            end
        // end
    end

endmodule

module Built_In_Self_Test(clk, rst_n, scan_en, scan_in, scan_out, dclk, a, b, rst_val);
    input clk;
    input rst_n;
    input scan_en;
    input dclk;
    input [7:0] rst_val;
    output wire scan_in;
    output wire scan_out;
    output wire [3:0] a, b;

    Many_To_One_LFSR MTOL(clk, rst_n, scan_in, dclk, rst_val);
    Scan_Chain_Design SCD(clk, rst_n, scan_in, scan_en, scan_out, dclk, a, b);

endmodule

module Many_To_One_LFSR(clk, rst_n, out, dclk, rst_val);
    input clk;
    input rst_n;
    input dclk;
    input [7:0] rst_val;
    output wire out;
    reg [7:0] state;

    assign in = (state[1] ^ state[2]) ^ (state[3] ^ state[7]);
    assign out = state[7];

    always @ (posedge clk) begin
        if (!rst_n) state <= rst_val;
        else begin
            if (dclk) state <= {state[6:0], in};
            else state <= state;
        end
    end

endmodule

module Scan_Chain_Design(clk, rst_n, scan_in, scan_en, scan_out, dclk, a, b);
    input clk;
    input rst_n;
    input scan_in;
    input scan_en;
    input dclk;
    output wire scan_out;
    output wire [3:0] a, b;
    wire out_76, out_65, out_54, out_43, out_32, out_21, out_10;
    wire [7:0] multi_ans;

    assign a = {out_76, out_65, out_54, out_43};
    assign b = {out_32, out_21, out_10, scan_out};
    assign multi_ans = a * b;

    SDFF SDFF7(clk, scan_in, scan_en, multi_ans[7], rst_n, out_76, dclk);
    SDFF SDFF6(clk, out_76, scan_en, multi_ans[6], rst_n, out_65, dclk);
    SDFF SDFF5(clk, out_65, scan_en, multi_ans[5], rst_n, out_54, dclk);
    SDFF SDFF4(clk, out_54, scan_en, multi_ans[4], rst_n, out_43, dclk);

    SDFF SDFF3(clk, out_43, scan_en, multi_ans[3], rst_n, out_32, dclk);
    SDFF SDFF2(clk, out_32, scan_en, multi_ans[2], rst_n, out_21, dclk);
    SDFF SDFF1(clk, out_21, scan_en, multi_ans[1], rst_n, out_10, dclk);
    SDFF SDFF0(clk, out_10, scan_en, multi_ans[0], rst_n, scan_out, dclk);

endmodule

module SDFF(clk, scan_in, scan_en, data, rst_n, out, dclk);
    input clk, scan_in, scan_en, data, rst_n, dclk;
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
            if (dclk) begin
                if (scan_en) tmp_out = scan_in;
                else tmp_out = data;
            end
            else begin
                tmp_out = out;
            end
        end
    end

endmodule