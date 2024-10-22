`timescale 1ns/1ps

module Mealy (clk, rst_n, in, out, state);
    input clk, rst_n;
    input in;
    output reg out;
    output reg [3-1:0] state;

    parameter S0 = 3'b000;
    parameter S1 = 3'b001;
    parameter S2 = 3'b010;
    parameter S3 = 3'b011;
    parameter S4 = 3'b100;
    parameter S5 = 3'b101;

    reg [2:0] tmp_state;

    always @ (posedge clk) begin
        state <= tmp_state;
    end

    always @ (*) begin
        if (!rst_n) begin
            tmp_state = S0;
            out = 1'b0;
        end
        else begin
            case (state)
                S0: begin
                    case (in)
                        1'b0: begin
                            tmp_state = S0;
                            out = 1'b0;
                        end
                        1'b1: begin
                            tmp_state = S2;
                            out = 1'b1;
                        end
                    endcase
                end
                S1: begin
                    case (in)
                        1'b0: begin
                            tmp_state = S0;
                            out = 1'b1;
                        end
                        1'b1: begin
                            tmp_state = S4;
                            out = 1'b1;
                        end
                    endcase
                end
                S2: begin
                    case (in)
                        1'b0: begin
                            tmp_state = S5;
                            out = 1'b1;
                        end
                        1'b1: begin
                            tmp_state = S1;
                            out = 1'b0;
                        end
                    endcase
                end
                S3: begin
                    case (in)
                        1'b0: begin
                            tmp_state = S3;
                            out = 1'b1;
                        end
                        1'b1: begin
                            tmp_state = S2;
                            out = 1'b0;
                        end
                    endcase
                end
                S4: begin
                    case (in)
                        1'b0: begin
                            tmp_state = S2;
                            out = 1'b1;
                        end
                        1'b1: begin
                            tmp_state = S4;
                            out = 1'b1;
                        end
                    endcase
                end
                S5: begin
                    case (in)
                        1'b0: begin
                            tmp_state = S3;
                            out = 1'b0;
                        end
                        1'b1: begin
                            tmp_state = S4;
                            out = 1'b0;
                        end
                    endcase
                end
                default: begin
                    tmp_state = state;
                    out = out;
                end
            endcase
        end
    end

endmodule
