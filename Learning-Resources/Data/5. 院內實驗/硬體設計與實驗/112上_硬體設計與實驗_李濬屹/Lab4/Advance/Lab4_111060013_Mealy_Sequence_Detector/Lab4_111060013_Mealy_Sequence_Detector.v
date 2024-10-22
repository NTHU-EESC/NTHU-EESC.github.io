`timescale 1ns/1ps

module Mealy_Sequence_Detector (clk, rst_n, in, dec);
    input clk, rst_n;
    input in;
    output reg dec;
    reg [3:0] state, tmp_state;

    parameter start = 4'd0;
    parameter one_0 = 4'd1;
    parameter one_1 = 4'd2;
    parameter two_01 = 4'd3;
    parameter two_11 = 4'd4;
    parameter two_10 = 4'd5;
    parameter two_fail = 4'd6;
    parameter three_011 = 4'd7;
    parameter three_111 = 4'd8;
    parameter three_100 = 4'd9;
    parameter three_fail = 4'd10;

    always @ (posedge clk) begin
        state <= tmp_state;
    end

    always @ (*) begin
        if (rst_n == 1'b0) begin
            tmp_state = start;
            dec = 1'b0;
        end
        else begin
            case (state)

                start: begin
                    case (in)
                        1'b0: begin
                            tmp_state = one_0;
                            dec = 1'b0;
                        end
                        1'b1: begin
                            tmp_state = one_1;
                            dec = 1'b0;
                        end
                        default: begin
                            tmp_state = state;
                            dec = dec;
                        end
                    endcase
                end

                one_0: begin
                    case (in)
                        1'b0: begin
                            tmp_state = two_fail;
                            dec = 1'b0;
                        end
                        1'b1: begin
                            tmp_state = two_01;
                            dec = 1'b0;
                        end
                        default: begin
                            tmp_state = state;
                            dec = dec;
                        end
                    endcase
                end

                one_1: begin
                    case (in)
                        1'b0: begin
                            tmp_state = two_10;
                            dec = 1'b0;
                        end
                        1'b1: begin
                            tmp_state = two_11;
                            dec = 1'b0;
                        end
                        default: begin
                            tmp_state = state;
                            dec = dec;
                        end
                    endcase
                end

                two_01: begin
                    case (in)
                        1'b0: begin
                            tmp_state = three_fail;
                            dec = 1'b0;
                        end
                        1'b1: begin
                            tmp_state = three_011;
                            dec = 1'b0;
                        end
                        default: begin
                            tmp_state = state;
                            dec = dec;
                        end
                    endcase
                end

                two_11: begin
                    case (in)
                        1'b0: begin
                            tmp_state = three_fail;
                            dec = 1'b0;
                        end
                        1'b1: begin
                            tmp_state = three_111;
                            dec = 1'b0;
                        end
                        default: begin
                            tmp_state = state;
                            dec = dec;
                        end
                    endcase
                end

                two_10: begin
                    case (in)
                        1'b0: begin
                            tmp_state = three_100;
                            dec = 1'b0;
                        end
                        1'b1: begin
                            tmp_state = three_fail;
                            dec = 1'b0;
                        end
                        default: begin
                            tmp_state = state;
                            dec = dec;
                        end
                    endcase
                end

                two_fail: begin
                    case (in)
                        1'b0: begin
                            tmp_state = three_fail;
                            dec = 1'b0;
                        end
                        1'b1: begin
                            tmp_state = three_fail;
                            dec = 1'b0;
                        end
                        default: begin
                            tmp_state = state;
                            dec = dec;
                        end
                    endcase
                end

                three_011: begin
                    case (in)
                        1'b0: begin
                            tmp_state = start;
                            dec = 1'b0;
                        end
                        1'b1: begin
                            tmp_state = start;
                            dec = 1'b1;
                        end
                        default: begin
                            tmp_state = state;
                            dec = dec;
                        end
                    endcase
                end

                three_111: begin
                    case (in)
                        1'b0: begin
                            tmp_state = start;
                            dec = 1'b1;
                        end
                        1'b1: begin
                            tmp_state = start;
                            dec = 1'b0;
                        end
                        default: begin
                            tmp_state = state;
                            dec = dec;
                        end
                    endcase
                end

                three_100: begin
                    case (in)
                        1'b0: begin
                            tmp_state = start;
                            dec = 1'b0;
                        end
                        1'b1: begin
                            tmp_state = start;
                            dec = 1'b1;
                        end
                        default: begin
                            tmp_state = state;
                            dec = dec;
                        end
                    endcase
                end

                three_fail: begin
                    case (in)
                        1'b0: begin
                            tmp_state = start;
                            dec = 1'b0;
                        end
                        1'b1: begin
                            tmp_state = start;
                            dec = 1'b0;
                        end
                        default: begin
                            tmp_state = state;
                            dec = dec;
                        end
                    endcase
                end

                default: begin
                    tmp_state = state;
                    dec = dec;
                end

            endcase
        end
    end

endmodule
