`timescale 1ns / 1ps

module Lab5_Team28_Vending_Machine_fpga(rst, insert5, insert10, insert50, cancel, clk, PS2_DATA, PS2_CLK, display, digit, led);
    input wire rst, insert5, insert10, insert50, cancel;
    input wire clk;
    inout wire PS2_DATA;
    inout wire PS2_CLK;
    output wire [7:0] display;
    output wire [3:0] digit;
    output wire [3:0] led;

    wire db_rst, db_insert5, db_insert10, db_insert50, db_cancel;
    wire op_rst, op_insert5, op_insert10, op_insert50, op_cancel;

    Debounce DB_RST(
        .clk(clk),
        .input_signal(rst),
        .db_signal(db_rst)
    );

    OnePulse OP_RST(
        .clock(clk),
        .signal(db_rst),
        .signal_single_pulse(op_rst)
    );

    Debounce DB_INSERT5(
        .clk(clk),
        .input_signal(insert5),
        .db_signal(db_insert5)
    );

    OnePulse OP_INSERT5(
        .clock(clk),
        .signal(db_insert5),
        .signal_single_pulse(op_insert5)
    );

    Debounce DB_INSERT10(
        .clk(clk),
        .input_signal(insert10),
        .db_signal(db_insert10)
    );

    OnePulse OP_INSERT10(
        .clock(clk),
        .signal(db_insert10),
        .signal_single_pulse(op_insert10)
    );

    Debounce DB_INSERT50(
        .clk(clk),
        .input_signal(insert50),
        .db_signal(db_insert50)
    );

    OnePulse OP_INSERT50(
        .clock(clk),
        .signal(db_insert50),
        .signal_single_pulse(op_insert50)
    );

    Debounce DB_CANCEL(
        .clk(clk),
        .input_signal(cancel),
        .db_signal(db_cancel)
    );

    OnePulse OP_CANCEL(
        .clock(clk),
        .signal(db_cancel),
        .signal_single_pulse(op_cancel)
    );

    parameter [8:0] KEY_A = 9'h01c;
    parameter [8:0] KEY_S = 9'h01b;
    parameter [8:0] KEY_D = 9'h023;
    parameter [8:0] KEY_F = 9'h02b;

    reg [3:0] key_num;
    wire [7:0] Money_to_SSD;
    wire [511:0] key_down;
    wire [8:0] last_change;
    wire been_ready;

    SevenSegment seven_seg (
        .display(display),
        .digit(digit),
        .nums(Money_to_SSD),
        .rst(op_rst),
        .clk(clk)
    );

    KeyboardDecoder key_de (
        .key_down(key_down),
        .last_change(last_change),
        .key_valid(been_ready),
        .PS2_DATA(PS2_DATA),
        .PS2_CLK(PS2_CLK),
        .rst(op_rst),
        .clk(clk)
    );

    Money MNY(
        .rst(op_rst),
        .clk(clk),
        .insert5(op_insert5),
        .insert10(op_insert10),
        .insert50(op_insert50),
        .cancel(op_cancel),
        .asdf(key_num),
        .sumMoney(Money_to_SSD),
        .led(led)
    );

    always @ (posedge clk) begin
        if (been_ready && key_down[last_change]) begin
            case (last_change)
                KEY_A: key_num <= 4'b1000;
                KEY_S: key_num <= 4'b0100;
                KEY_D: key_num <= 4'b0010;
                KEY_F: key_num <= 4'b0001;
                default: key_num <= 4'b0000;
            endcase
        end
        else begin
            key_num <= 4'b0000;
        end
            
    end

endmodule

module Money(rst, clk, insert5, insert10, insert50, cancel, asdf, sumMoney, led);
    input wire rst, clk, insert5, insert10, insert50, cancel;
    input wire [3:0] asdf;
    output reg [7:0] sumMoney;
    output reg [3:0] led;
    reg [7:0] tmp_sumMoney;
    reg state, tmp_state;
    reg [26:0] count, tmp_count;
    
    parameter INSERT_MONEY = 1'b0;
    parameter RETURN_MONEY = 1'b1;

    parameter Coffee = 8'd80;
    parameter Coke = 8'd30;
    parameter Oolong = 8'd25;
    parameter Water = 8'd20;

    always @ (*) begin
        led[3] = !(sumMoney < Coffee);
        led[2] = !(sumMoney < Coke);
        led[1] = !(sumMoney < Oolong);
        led[0] = !(sumMoney < Water);
    end

    always @ (posedge clk) begin
        sumMoney <= tmp_sumMoney;
        state <= tmp_state;
        count <= tmp_count;
    end

    always @ (*) begin
        if (rst) begin
            tmp_state = INSERT_MONEY;
            tmp_sumMoney = 8'd0;
            tmp_count = 27'd0;
        end
        else begin
            case (state)

                INSERT_MONEY: begin
                    case ({asdf, cancel})
                        5'b10000: begin
                            if (led[3]) begin
                                tmp_state = RETURN_MONEY;
                                tmp_sumMoney = sumMoney - Coffee;
                                tmp_count = 27'd0;
                            end
                            else begin
                                tmp_state = INSERT_MONEY;
                                tmp_sumMoney = sumMoney;
                                tmp_count = 27'd0;
                            end
                        end
                        5'b01000: begin
                            if (led[2]) begin
                                tmp_state = RETURN_MONEY;
                                tmp_sumMoney = sumMoney - Coke;
                                tmp_count = 27'd0;
                            end
                            else begin
                                tmp_state = INSERT_MONEY;
                                tmp_sumMoney = sumMoney;
                                tmp_count = 27'd0;
                            end
                        end
                        5'b00100: begin
                            if (led[1]) begin
                                tmp_state = RETURN_MONEY;
                                tmp_sumMoney = sumMoney - Oolong;
                                tmp_count = 27'd0;
                            end
                            else begin
                                tmp_state = INSERT_MONEY;
                                tmp_sumMoney = sumMoney;
                                tmp_count = 27'd0;
                            end
                        end
                        5'b00010: begin
                            if (led[0]) begin
                                tmp_state = RETURN_MONEY;
                                tmp_sumMoney = sumMoney - Water;
                                tmp_count = 27'd0;
                            end
                            else begin
                                tmp_state = INSERT_MONEY;
                                tmp_sumMoney = sumMoney;
                                tmp_count = 27'd0;
                            end
                        end
                        5'b00001: begin
                            tmp_state = RETURN_MONEY;
                            tmp_sumMoney = sumMoney;
                            tmp_count = 27'd0;
                        end
                        default: begin
                            tmp_state = INSERT_MONEY;
                            tmp_sumMoney = sumMoney + insert5 * 5 + insert10 * 10 + insert50 * 50;
                            tmp_sumMoney = tmp_sumMoney > 8'd100 ? 8'd100 : tmp_sumMoney;
                            tmp_count = 27'd0;
                        end
                    endcase
                end

                RETURN_MONEY: begin

                    if (count == 27'd99999999) tmp_count = 27'd0;
                    else tmp_count = count + 1;

                    if (count == 27'd99999999) begin
                        if (sumMoney > 8'd5) begin
                            tmp_state = RETURN_MONEY;
                            tmp_sumMoney = sumMoney - 8'd5;
                        end
                        else begin
                            tmp_state = INSERT_MONEY;
                            tmp_sumMoney = 8'd0;
                        end
                    end
                    else begin
                        tmp_state = RETURN_MONEY;
                        tmp_sumMoney = sumMoney;
                    end
                end

                default: begin
                    tmp_count = count;
                    tmp_state  = state;
                    tmp_sumMoney = sumMoney;
                end

            endcase
        end
    end

endmodule

module KeyboardDecoder(
    output reg [511:0] key_down,
    output wire [8:0] last_change,
    output reg key_valid,
    inout wire PS2_DATA,
    inout wire PS2_CLK,
    input wire rst,
    input wire clk
    );
    
    parameter [1:0] INIT			= 2'b00;
    parameter [1:0] WAIT_FOR_SIGNAL = 2'b01;
    parameter [1:0] GET_SIGNAL_DOWN = 2'b10;
    parameter [1:0] WAIT_RELEASE    = 2'b11;
    
    parameter [7:0] IS_INIT			= 8'hAA;
    parameter [7:0] IS_EXTEND		= 8'hE0;
    parameter [7:0] IS_BREAK		= 8'hF0;
    
    reg [9:0] key, next_key;		// key = {been_extend, been_break, key_in}
    reg [1:0] state, next_state;
    reg been_ready, been_extend, been_break;
    reg next_been_ready, next_been_extend, next_been_break;
    
    wire [7:0] key_in;
    wire is_extend;
    wire is_break;
    wire valid;
    wire err;
    
    wire [511:0] key_decode = 1 << last_change;
    assign last_change = {key[9], key[7:0]};
    
    KeyboardCtrl_0 inst (
        .key_in(key_in),
        .is_extend(is_extend),
        .is_break(is_break),
        .valid(valid),
        .err(err),
        .PS2_DATA(PS2_DATA),
        .PS2_CLK(PS2_CLK),
        .rst(rst),
        .clk(clk)
    );
    
    OnePulse op (
        .signal_single_pulse(pulse_been_ready),
        .signal(been_ready),
        .clock(clk)
    );
    
    always @ (posedge clk, posedge rst) begin
        if (rst) begin
            state <= INIT;
            been_ready  <= 1'b0;
            been_extend <= 1'b0;
            been_break  <= 1'b0;
            key <= 10'b0_0_0000_0000;
        end else begin
            state <= next_state;
            been_ready  <= next_been_ready;
            been_extend <= next_been_extend;
            been_break  <= next_been_break;
            key <= next_key;
        end
    end
    
    always @ (*) begin
        case (state)
            INIT:            next_state = (key_in == IS_INIT) ? WAIT_FOR_SIGNAL : INIT;
            WAIT_FOR_SIGNAL: next_state = (valid == 1'b0) ? WAIT_FOR_SIGNAL : GET_SIGNAL_DOWN;
            GET_SIGNAL_DOWN: next_state = WAIT_RELEASE;
            WAIT_RELEASE:    next_state = (valid == 1'b1) ? WAIT_RELEASE : WAIT_FOR_SIGNAL;
            default:         next_state = INIT;
        endcase
    end
    always @ (*) begin
        next_been_ready = been_ready;
        case (state)
            INIT:            next_been_ready = (key_in == IS_INIT) ? 1'b0 : next_been_ready;
            WAIT_FOR_SIGNAL: next_been_ready = (valid == 1'b0) ? 1'b0 : next_been_ready;
            GET_SIGNAL_DOWN: next_been_ready = 1'b1;
            WAIT_RELEASE:    next_been_ready = next_been_ready;
            default:         next_been_ready = 1'b0;
        endcase
    end
    always @ (*) begin
        next_been_extend = (is_extend) ? 1'b1 : been_extend;
        case (state)
            INIT:            next_been_extend = (key_in == IS_INIT) ? 1'b0 : next_been_extend;
            WAIT_FOR_SIGNAL: next_been_extend = next_been_extend;
            GET_SIGNAL_DOWN: next_been_extend = next_been_extend;
            WAIT_RELEASE:    next_been_extend = (valid == 1'b1) ? next_been_extend : 1'b0;
            default:         next_been_extend = 1'b0;
        endcase
    end
    always @ (*) begin
        next_been_break = (is_break) ? 1'b1 : been_break;
        case (state)
            INIT:            next_been_break = (key_in == IS_INIT) ? 1'b0 : next_been_break;
            WAIT_FOR_SIGNAL: next_been_break = next_been_break;
            GET_SIGNAL_DOWN: next_been_break = next_been_break;
            WAIT_RELEASE:    next_been_break = (valid == 1'b1) ? next_been_break : 1'b0;
            default:         next_been_break = 1'b0;
        endcase
    end
    always @ (*) begin
        next_key = key;
        case (state)
            INIT:            next_key = (key_in == IS_INIT) ? 10'b0_0_0000_0000 : next_key;
            WAIT_FOR_SIGNAL: next_key = next_key;
            GET_SIGNAL_DOWN: next_key = {been_extend, been_break, key_in};
            WAIT_RELEASE:    next_key = next_key;
            default:         next_key = 10'b0_0_0000_0000;
        endcase
    end

    always @ (posedge clk, posedge rst) begin
        if (rst) begin
            key_valid <= 1'b0;
            key_down <= 511'b0;
        end else if (key_decode[last_change] && pulse_been_ready) begin
            key_valid <= 1'b1;
            if (key[8] == 0) begin
                key_down <= key_down | key_decode;
            end else begin
                key_down <= key_down & (~key_decode);
            end
        end else begin
            key_valid <= 1'b0;
            key_down <= key_down;
        end
    end

endmodule

module SevenSegment(
    output reg [7:0] display,
    output reg [3:0] digit,
    input wire [7:0] nums,
    input wire rst,
    input wire clk
    );
    
    reg [15:0] clk_divider;
    reg [3:0] display_num;
    reg [3:0] mux2, mux1, mux0;
    
    always @ (posedge clk, posedge rst) begin
        if (rst) begin
            clk_divider <= 16'b0;
        end else begin
            clk_divider <= clk_divider + 16'b1;
        end
    end
    
    always @ (*) begin
        if (nums == 8'd100) mux2 = 4'd1;
        else mux2 = 4'd0;
    end

    always @ (*) begin
        if (nums == 8'd100) mux1 = 4'd0;
        else if (nums > 8'd89) mux1 = 4'd9;
        else if (nums > 8'd79) mux1 = 4'd8;
        else if (nums > 8'd69) mux1 = 4'd7;
        else if (nums > 8'd59) mux1 = 4'd6;
        else if (nums > 8'd49) mux1 = 4'd5;
        else if (nums > 8'd39) mux1 = 4'd4;
        else if (nums > 8'd29) mux1 = 4'd3;
        else if (nums > 8'd19) mux1 = 4'd2;
        else if (nums > 8'd9) mux1 = 4'd1;
        else mux1 = 4'd0;
    end

    always @ (*) begin
        case (nums)
            8'd100: mux0 = 4'd0;
            8'd99: mux0 = 4'd9;
            8'd98: mux0 = 4'd8;
            8'd97: mux0 = 4'd7;
            8'd96: mux0 = 4'd6;
            8'd95: mux0 = 4'd5;
            8'd94: mux0 = 4'd4;
            8'd93: mux0 = 4'd3;
            8'd92: mux0 = 4'd2;
            8'd91: mux0 = 4'd1;

            8'd90: mux0 = 4'd0;
            8'd89: mux0 = 4'd9;
            8'd88: mux0 = 4'd8;
            8'd87: mux0 = 4'd7;
            8'd86: mux0 = 4'd6;
            8'd85: mux0 = 4'd5;
            8'd84: mux0 = 4'd4;
            8'd83: mux0 = 4'd3;
            8'd82: mux0 = 4'd2;
            8'd81: mux0 = 4'd1;

            8'd80: mux0 = 4'd0;
            8'd79: mux0 = 4'd9;
            8'd78: mux0 = 4'd8;
            8'd77: mux0 = 4'd7;
            8'd76: mux0 = 4'd6;
            8'd75: mux0 = 4'd5;
            8'd74: mux0 = 4'd4;
            8'd73: mux0 = 4'd3;
            8'd72: mux0 = 4'd2;
            8'd71: mux0 = 4'd1;

            8'd70: mux0 = 4'd0;
            8'd69: mux0 = 4'd9;
            8'd68: mux0 = 4'd8;
            8'd67: mux0 = 4'd7;
            8'd66: mux0 = 4'd6;
            8'd65: mux0 = 4'd5;
            8'd64: mux0 = 4'd4;
            8'd63: mux0 = 4'd3;
            8'd62: mux0 = 4'd2;
            8'd61: mux0 = 4'd1;

            8'd60: mux0 = 4'd0;
            8'd59: mux0 = 4'd9;
            8'd58: mux0 = 4'd8;
            8'd57: mux0 = 4'd7;
            8'd56: mux0 = 4'd6;
            8'd55: mux0 = 4'd5;
            8'd54: mux0 = 4'd4;
            8'd53: mux0 = 4'd3;
            8'd52: mux0 = 4'd2;
            8'd51: mux0 = 4'd1;

            8'd50: mux0 = 4'd0;
            8'd49: mux0 = 4'd9;
            8'd48: mux0 = 4'd8;
            8'd47: mux0 = 4'd7;
            8'd46: mux0 = 4'd6;
            8'd45: mux0 = 4'd5;
            8'd44: mux0 = 4'd4;
            8'd43: mux0 = 4'd3;
            8'd42: mux0 = 4'd2;
            8'd41: mux0 = 4'd1;

            8'd40: mux0 = 4'd0;
            8'd39: mux0 = 4'd9;
            8'd38: mux0 = 4'd8;
            8'd37: mux0 = 4'd7;
            8'd36: mux0 = 4'd6;
            8'd35: mux0 = 4'd5;
            8'd34: mux0 = 4'd4;
            8'd33: mux0 = 4'd3;
            8'd32: mux0 = 4'd2;
            8'd31: mux0 = 4'd1;

            8'd30: mux0 = 4'd0;
            8'd29: mux0 = 4'd9;
            8'd28: mux0 = 4'd8;
            8'd27: mux0 = 4'd7;
            8'd26: mux0 = 4'd6;
            8'd25: mux0 = 4'd5;
            8'd24: mux0 = 4'd4;
            8'd23: mux0 = 4'd3;
            8'd22: mux0 = 4'd2;
            8'd21: mux0 = 4'd1;

            8'd20: mux0 = 4'd0;
            8'd19: mux0 = 4'd9;
            8'd18: mux0 = 4'd8;
            8'd17: mux0 = 4'd7;
            8'd16: mux0 = 4'd6;
            8'd15: mux0 = 4'd5;
            8'd14: mux0 = 4'd4;
            8'd13: mux0 = 4'd3;
            8'd12: mux0 = 4'd2;
            8'd11: mux0 = 4'd1;

            8'd10: mux0 = 4'd0;
            8'd9: mux0 = 4'd9;
            8'd8: mux0 = 4'd8;
            8'd7: mux0 = 4'd7;
            8'd6: mux0 = 4'd6;
            8'd5: mux0 = 4'd5;
            8'd4: mux0 = 4'd4;
            8'd3: mux0 = 4'd3;
            8'd2: mux0 = 4'd2;
            8'd1: mux0 = 4'd1;

            8'd0: mux0 = 4'd0;

        endcase
    end

    always @ (posedge clk, posedge rst) begin
        if (rst) begin
            display_num <= 4'b0000;
            digit <= 4'b1111;
        end else if (clk_divider == {16{1'b1}}) begin
            case (digit)
                4'b1110 : begin
                    display_num <= mux1;
                    digit <= nums > 8'd9 ? 4'b1101 : 4'b1111;
                end
                4'b1101 : begin
                    display_num <= mux2;
                    digit <= nums > 8'd99 ? 4'b1011 : 4'b1111;
                end
                4'b1011 : begin
                    display_num <= 4'd0;
                    digit <= 4'b1111;
                end
                4'b0111 : begin
                    display_num <= mux0;
                    digit <= 4'b1110;
                end
                default : begin
                    display_num <= mux0;
                    digit <= 4'b1110;
                end				
            endcase
        end else begin
            display_num <= display_num;
            digit <= digit;
        end
    end
    
    always @ (*) begin
        case (display_num)
            0 : display = 8'b00000011;	//0000
            1 : display = 8'b10011111;   //0001                                                
            2 : display = 8'b00100101;   //0010                                                
            3 : display = 8'b00001101;   //0011                                             
            4 : display = 8'b10011001;   //0100                                               
            5 : display = 8'b01001001;   //0101                                               
            6 : display = 8'b01000001;   //0110
            7 : display = 8'b00011011;   //0111
            8 : display = 8'b00000001;   //1000
            9 : display = 8'b00001001;	//1001
            default : display = 8'b11111111;
        endcase
    end
    
endmodule

module OnePulse (
    output reg signal_single_pulse,
    input wire signal,
    input wire clock
    );
    
    reg signal_delay;

    always @(posedge clock) begin
        if (signal == 1'b1 & signal_delay == 1'b0)
            signal_single_pulse <= 1'b1;
        else
            signal_single_pulse <= 1'b0;
        signal_delay <= signal;
    end
endmodule

module Debounce(clk, input_signal, db_signal);
    input wire clk, input_signal;
    output wire db_signal;
    reg [3:0] DFF;
    reg [19:0] count;

    assign db_signal = DFF == 4'b1111;

    always @ (posedge clk) begin
        count <= count + 1;
        if (count == 19'd0) begin
            DFF <= {DFF[2:0], input_signal};
        end
        else begin
            DFF <= DFF;
        end
    end

endmodule