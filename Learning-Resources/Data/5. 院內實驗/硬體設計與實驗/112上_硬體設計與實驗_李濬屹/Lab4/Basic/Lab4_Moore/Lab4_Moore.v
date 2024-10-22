`timescale 1ns/1ps

module Moore (clk, rst_n, in, out, state);
    input clk, rst_n;
    input in;
    output reg [2-1:0] out;
    output reg [3-1:0] state;

    parameter S0 = 3'b000;
    parameter S1 = 3'b001;
    parameter S2 = 3'b010;
    parameter S3 = 3'b011;
    parameter S4 = 3'b100;
    parameter S5 = 3'b101;

    reg [1:0] tmp_out;
    reg [2:0] tmp_state;

    always @ (posedge clk) begin
        state <= tmp_state;
        out <= tmp_out;
    end

    always @ (*) begin
        if (!rst_n) begin
            tmp_state = S0;
            tmp_out = 2'b11;
        end
        else begin
            case (state)
                S0: begin
                    if (in) begin
                        tmp_state = S2;
                        tmp_out = 2'b11;
                    end
                    else begin
                        tmp_state = S1;
                        tmp_out = 2'b01;
                    end
                end
                S1: begin
                    if (in) begin
                        tmp_state = S5;
                        tmp_out = 2'b00;
                    end
                    else begin
                        tmp_state = S4;
                        tmp_out = 2'b10;
                    end
                end
                S2: begin
                    if (in) begin
                        tmp_state = S3;
                        tmp_out = 2'b10;
                    end
                    else begin
                        tmp_state = S1;
                        tmp_out = 2'b01;
                    end
                end
                S3: begin
                    if (in) begin
                        tmp_state = S0;
                        tmp_out = 2'b11;
                    end
                    else begin
                        tmp_state = S1;
                        tmp_out = 2'b01;
                    end
                end
                S4: begin
                    if (in) begin
                        tmp_state = S5;
                        tmp_out = 2'b00;
                    end
                    else begin
                        tmp_state = S4;
                        tmp_out = 2'b10;
                    end
                end
                S5: begin
                    if (in) begin
                        tmp_state = S0;
                        tmp_out = 2'b11;
                    end
                    else begin
                        tmp_state = S3;
                        tmp_out = 2'b10;
                    end
                end
                default: begin
                    tmp_state = state;
                    tmp_out = out;
                end
            endcase
        end
    end

endmodule
