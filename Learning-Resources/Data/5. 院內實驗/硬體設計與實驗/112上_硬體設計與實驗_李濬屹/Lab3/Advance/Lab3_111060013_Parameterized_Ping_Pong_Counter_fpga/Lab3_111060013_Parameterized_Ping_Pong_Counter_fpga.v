`timescale 1ns/1ps

module FPGA (clk, rst_n, enable, flip, max, min, out, bit);
    input clk, rst_n, enable, flip;
    input [3:0] max, min;
    output [7:0] out;
    output [3:0] bit;

    wire dir, SS7_clk, CKT_clk;
    wire [3:0] raw_out;
    wire not_rst_n, db_flip, db_rst_n;
    wire ssg_rst_n, ssg_flip;
    reg tmp_rst_n, tmp_flip, tr, tf;
    
    reg [26:0] rst_count, tmp_rst_count;
    reg [26:0] flip_count, tmp_flip_count;

    Debounce De_rst_n(.in(rst_n), .out(db_rst_n), .clk(clk));
    Debounce De_flip(.in(flip), .out(db_flip), .clk(clk));

    Square_Signal_Generator SSG_rst_n(.in(db_rst_n), .out(ssg_rst_n), .clk(clk));
    Square_Signal_Generator SSG_flip(.in(db_flip), .out(ssg_flip), .clk(clk));

    // flip
    always @ (*) begin
        if (ssg_flip) tmp_flip_count = 27'd0;
        else tmp_flip_count = flip_count + 1;
    end

    always @ (*) begin
        if (ssg_flip) tf = 1'b1;
        else if (flip_count == 27'h7ffffff) tf = 1'b0;
        else tf = tmp_flip;
    end

    always @ (posedge clk) begin
        tmp_flip <= tf;
        flip_count <= tmp_flip_count;
    end
    // flip

    Clock_Divider_Circuit CDC(
        .clk(clk),
        .rst_n(!ssg_rst_n),
        .dclk(CKT_clk)
    );

    Clock_Divider_SS7 CDS(
        .clk(clk),
        .rst_n(!ssg_rst_n),
        .dclk(SS7_clk)
    );

    Parameterized_Ping_Pong_Counter PPPC(
        .clk(clk),
        .rst_n(!ssg_rst_n),
        .enable(enable),
        .flip(tmp_flip),
        .max(max),
        .min(min),
        .direction(dir),
        .out(raw_out),
        .dclk(CKT_clk)
    );

    SS7 Display(
        .in(raw_out),
        .dir(dir),
        .clk(SS7_clk),
        .out(out),
        .bit(bit)
    );

endmodule

module Square_Signal_Generator(in, out, clk);
    input in, clk;
    output reg out;
    reg A, B;

    always @ (*) begin
        B = (!A) && in;
    end

    always @ (posedge clk) begin
        A <= in;
        out <= B;
    end

endmodule

module Debounce(in, out, clk);
    input in, clk;
    output reg out;
    reg out1, out2, out3, out4;

    always @ (*) begin
        out = out1 && out2 && out3 && out4;
    end

    always @ (posedge clk) begin
        out1 <= in;
        out2 <= out1;
        out3 <= out2;
        out4 <= out3;
    end

endmodule

module SS7 (in, dir, clk, out, bit);
    input [3:0] in;
    input dir, clk;
    output reg [7:0] out;
    output reg [3:0] bit;

    reg [7:0] out_3, out_2, out_1, out_0;
    reg [1:0] count, tmp_count;


    always @ (posedge clk) begin
        count <= count + 1;
    end

    always @ (*) begin
        case (count)
            2'b00: bit = 4'b0111;
            2'b01: bit = 4'b1011;
            2'b10: bit = 4'b1101;
            2'b11: bit = 4'b1110;
        endcase
    end

    always @ (*) begin
        case (count)
            2'b00: out = out_3;
            2'b01: out = out_2;
            2'b10: out = out_1;
            2'b11: out = out_0;
        endcase
    end

    // 3rd bit
    always @ (*) begin
        case (in)
            4'b0000: out_3 = 8'b00000011;
            4'b0001: out_3 = 8'b00000011;
            4'b0010: out_3 = 8'b00000011;
            4'b0011: out_3 = 8'b00000011;
            4'b0100: out_3 = 8'b00000011;
            4'b0101: out_3 = 8'b00000011;
            4'b0110: out_3 = 8'b00000011;
            4'b0111: out_3 = 8'b00000011;
            4'b1000: out_3 = 8'b00000011;
            4'b1001: out_3 = 8'b00000011;
            4'b1010: out_3 = 8'b10011111;
            4'b1011: out_3 = 8'b10011111;
            4'b1100: out_3 = 8'b10011111;
            4'b1101: out_3 = 8'b10011111;
            4'b1110: out_3 = 8'b10011111;
            4'b1111: out_3 = 8'b10011111;
        endcase
    end

    // 2nd bit
    always @ (*) begin
        case (in)
            4'd0: out_2 = 8'b00000011;
            4'd1: out_2 = 8'b10011111;
            4'd2: out_2 = 8'b00100101;
            4'd3: out_2 = 8'b00001101;
            4'd4: out_2 = 8'b10011001;
            4'd5: out_2 = 8'b01001001;
            4'd6: out_2 = 8'b01000001;
            4'd7: out_2 = 8'b00011111;
            4'd8: out_2 = 8'b00000001;
            4'd9: out_2 = 8'b00001001;
            4'd10: out_2 = 8'b00000011;
            4'd11: out_2 = 8'b10011111;
            4'd12: out_2 = 8'b00100101;
            4'd13: out_2 = 8'b00001101;
            4'd14: out_2 = 8'b10011001;
            4'd15: out_2 = 8'b01001001;
        endcase
    end

    // 1st bit
    always @ (*) begin
        case (dir)
            1'b0: out_1 = 8'b11000111;
            1'b1: out_1 = 8'b00111011;
            default: out_1 = 8'b00111011;
        endcase
    end

    // 0th bit
    always @ (*) begin
        case (dir)
            1'b0: out_0 = 8'b11000111;
            1'b1: out_0 = 8'b00111011;
            default: out_0 = 8'b00111011;
        endcase
    end

endmodule

module Parameterized_Ping_Pong_Counter (clk, rst_n, enable, flip, max, min, direction, out, dclk);
    input clk, rst_n, dclk;
    input enable;
    input flip;
    input [4-1:0] max;
    input [4-1:0] min;
    output reg direction;
    output reg [4-1:0] out;

    reg newEnable, able_flip, hit;
    reg tmp_dir;
    reg [3:0] tmp_out;

    // Combinational: direction
    always @ (*) begin
        newEnable = (enable == 1'b1) && (min < max) && !(out < min) && !(out > max);
        able_flip = (out > min) && (out < max) && flip == 1'b1;
        hit = (direction == 1'b1 && out == max) || (direction == 1'b0 && out == min);
    end

    always @ (*) begin
        if (rst_n == 1'b0) tmp_dir = 1'b1;
        else begin
            if (dclk) begin
                if (newEnable && (able_flip || hit)) tmp_dir = ~direction;
                else tmp_dir = direction;
            end
            else tmp_dir = direction;
        end
    end

    // DFF: direction
    always @ (posedge clk) begin
        direction <= tmp_dir;
    end

    // Mux: out
    always @ (*) begin
        if (rst_n == 1'b0) tmp_out = min;
        else begin
            if (dclk) begin
                if (newEnable && (rst_n == 1'b1)) begin
                    case ({direction, able_flip})
                        2'b00: tmp_out = (out == min) ? out + 1 : out - 1;
                        2'b10: tmp_out = (out == max) ? out - 1 : out + 1;
                        2'b01: tmp_out = out + 1;
                        2'b11: tmp_out = out - 1;
                        default: tmp_out = out;
                    endcase
                end
                else tmp_out = out;
            end
            else tmp_out = out;
        end
    end

    // DFF: out
    always @ (posedge clk) begin
        out <= tmp_out;
    end

endmodule

module Clock_Divider_SS7 (clk, rst_n, dclk);
    input clk, rst_n;
    output dclk;

    reg dclk, tmp_dclk;
    reg [16:0] count, tmp_count;

    always @ (*) begin
        if (rst_n == 1'b0) begin
            tmp_count = 17'h0;
            tmp_dclk = 1'b0;
        end
        else if (count == 17'h1ffff) begin
            tmp_count = 17'h0;
            tmp_dclk = 1'b1;
        end
        else begin
            tmp_count = count + 1;
            tmp_dclk = 1'b0;
        end
    end

    always @(posedge clk) begin
        dclk <= tmp_dclk;
        count <= tmp_count;
    end

endmodule

module Clock_Divider_Circuit (clk, rst_n, dclk);
    input clk, rst_n;
    output reg dclk;

    reg tmp_dclk;
    reg [26:0] count, tmp_count;

    always @ (*) begin
        if (rst_n == 1'b0) begin
            tmp_count = 27'd0;
            tmp_dclk = 1'b0;
        end
        else if (count == 27'h7ffffff) begin
            tmp_count = 27'd0;
            tmp_dclk = 1'b1;
        end
        else begin
            tmp_count = count + 1;
            tmp_dclk = 1'b0;
        end
    end

    always @ (posedge clk) begin
        dclk <= tmp_dclk;
        count <= tmp_count;
    end

endmodule