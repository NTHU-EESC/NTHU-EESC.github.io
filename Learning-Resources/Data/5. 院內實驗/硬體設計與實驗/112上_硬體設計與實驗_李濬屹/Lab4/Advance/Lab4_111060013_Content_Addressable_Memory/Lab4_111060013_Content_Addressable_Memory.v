`timescale 1ns/1ps

module Content_Addressable_Memory(clk, wen, ren, din, addr, dout, hit);
    input clk;
    input wen, ren;
    input [7:0] din;
    input [3:0] addr;
    output reg [3:0] dout;
    output reg hit;
    reg [7:0] mem [15:0];
    reg [15:0] isHit;
    reg tmp_hit;
    reg [7:0] tmp_din;
    reg [3:0] tmp_dout;

    always @ (posedge clk) begin
        mem[addr] <= tmp_din;
        dout <= tmp_dout;
        hit <= tmp_hit;
    end

    always @ (*) begin
        if (ren) begin
            if ((isHit | 16'b0) != 16'b0) begin
                tmp_din = mem[addr];
                tmp_hit = 1'b1;
                if (isHit[15]) tmp_dout = 4'd15;
                else if (isHit[14]) tmp_dout = 4'd14;
                else if (isHit[13]) tmp_dout = 4'd13;
                else if (isHit[12]) tmp_dout = 4'd12;

                else if (isHit[11]) tmp_dout = 4'd11;
                else if (isHit[10]) tmp_dout = 4'd10;
                else if (isHit[9]) tmp_dout = 4'd9;
                else if (isHit[8]) tmp_dout = 4'd8;

                else if (isHit[7]) tmp_dout = 4'd7;
                else if (isHit[6]) tmp_dout = 4'd6;
                else if (isHit[5]) tmp_dout = 4'd5;
                else if (isHit[4]) tmp_dout = 4'd4;

                else if (isHit[3]) tmp_dout = 4'd3;
                else if (isHit[2]) tmp_dout = 4'd2;
                else if (isHit[1]) tmp_dout = 4'd1;
                else if (isHit[0]) tmp_dout = 4'd0;
                else tmp_dout = 4'd0;
            end
            else begin
                tmp_din = mem[addr];
                tmp_dout = 4'b0;
                tmp_hit = 1'b0;
            end
        end
        else begin
            if (wen) begin
                tmp_din = din;
                tmp_dout = 4'b0;
                tmp_hit = 1'b0;
            end
            else begin
                tmp_din = mem[addr];
                tmp_dout = 4'b0;
                tmp_hit = 1'b0;
            end
        end
    end


    always @ (*) begin
        case (mem[0] == din)
            1'b1: isHit[0] = 1'b1;
            default: isHit[0] = 1'b0;
        endcase
        case (mem[1] == din)
            1'b1: isHit[1] = 1'b1;
            default: isHit[1] = 1'b0;
        endcase
        case (mem[2] == din)
            1'b1: isHit[2] = 1'b1;
            default: isHit[2] = 1'b0;
        endcase
        case (mem[3] == din)
            1'b1: isHit[3] = 1'b1;
            default: isHit[3] = 1'b0;
        endcase
        case (mem[4] == din)
            1'b1: isHit[4] = 1'b1;
            default: isHit[4] = 1'b0;
        endcase
        case (mem[5] == din)
            1'b1: isHit[5] = 1'b1;
            default: isHit[5] = 1'b0;
        endcase
        case (mem[6] == din)
            1'b1: isHit[6] = 1'b1;
            default: isHit[6] = 1'b0;
        endcase
        case (mem[7] == din)
            1'b1: isHit[7] = 1'b1;
            default: isHit[7] = 1'b0;
        endcase
        case (mem[8] == din)
            1'b1: isHit[8] = 1'b1;
            default: isHit[8] = 1'b0;
        endcase
        case (mem[9] == din)
            1'b1: isHit[9] = 1'b1;
            default: isHit[9] = 1'b0;
        endcase
        case (mem[10] == din)
            1'b1: isHit[10] = 1'b1;
            default: isHit[10] = 1'b0;
        endcase
        case (mem[11] == din)
            1'b1: isHit[11] = 1'b1;
            default: isHit[11] = 1'b0;
        endcase
        case (mem[12] == din)
            1'b1: isHit[12] = 1'b1;
            default: isHit[12] = 1'b0;
        endcase
        case (mem[13] == din)
            1'b1: isHit[13] = 1'b1;
            default: isHit[13] = 1'b0;
        endcase
        case (mem[14] == din)
            1'b1: isHit[14] = 1'b1;
            default: isHit[14] = 1'b0;
        endcase
        case (mem[15] == din)
            1'b1: isHit[15] = 1'b1;
            default: isHit[15] = 1'b0;
        endcase
    end

endmodule
