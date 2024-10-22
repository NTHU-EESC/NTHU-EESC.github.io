`timescale 1ns / 1ps

module Lab5_Team28_Music_fpga(
    inout wire PS2_DATA,
    inout wire PS2_CLK,
    input clk,
    input rst,
    output pmod_1,	//AIN
	output pmod_2,	//GAIN
	output pmod_4	//SHUTDOWN_N
);

reg [4:0] tone, next_tone;
wire W, S, R, rst_n;
wire One_second, Half_second;

reg direction;
reg sec; // sec = 0......onesecond
wire Timer;

Keyboard K(
    .W(W),
    .S(S),
    .R(R),
    .rst_n(rst_n),
    .PS2_DATA(PS2_DATA),
    .PS2_CLK(PS2_CLK),
    .rst(rst),
    .clk(clk)
);

 clk_generator c(
    .clk(clk),
    .rst_n(rst_n),
    .One_second(One_second),
    .Half_second(Half_second)
 );

assign Timer = (sec == 1'b0) ? One_second : Half_second;

Audio A(
    .clk(clk),
    .reset(rst),
    .tone(tone), //piano keys
	.pmod_1(pmod_1),	//AIN
	.pmod_2(pmod_2),	//GAIN
	.pmod_4(pmod_4)	//SHUTDOWN_N
);

always@(posedge clk)begin
    if(rst_n == 1'b1)begin
        tone <= 5'd0;
    end
    else begin
        if(Timer == 1'b1)begin
            tone <= next_tone;
        end
        else begin
            tone <= tone;
        end
    end
end

always@(posedge clk)begin
    if(rst_n == 1'b1)begin
        sec <= 1'b0;
    end
    else begin
        if(R)begin
            sec <= !sec;
        end
        else begin
            sec <= sec;
        end
    end
end

always@(posedge clk)begin
    if(rst_n == 1'b1)begin
        direction <= 1'b1;
    end
    else begin
        if(W == 1'b1)begin
            direction <= 1'b1;
        end
        else if(S == 1'b1)begin
            direction <= 1'b0;
        end
        else begin
            direction <= direction;
        end
    end
end

always@(*)begin
    if(direction == 1'b1 && tone != 5'd21)begin
        next_tone = tone + 5'd1;
    end 
    else if(direction == 1'b1 && tone == 5'd21)begin
        next_tone = tone;
    end 
    else if(direction == 1'b0 && tone != 5'd0)begin
        next_tone = tone - 5'd1;
    end
    else begin
        next_tone = tone;
    end
end

endmodule




module Audio (
    input clk,
    input reset,
    input [4:0] tone, //piano keys
	output pmod_1,	//AIN
	output pmod_2,	//GAIN
	output pmod_4	//SHUTDOWN_N
);
	
wire [31:0] freq;
assign pmod_2 = 1'd1;	//no gain(6dB)
assign pmod_4 = 1'd1;	//turn-on
	
Decoder decoder00 (
	.tone(tone),
	.freq(freq)
);

PWM_gen pwm_0 ( 
	.clk(clk), 
	.reset(reset), 
	.freq(freq),
	.duty(10'd512), 
	.PWM(pmod_1)
);

endmodule



module Decoder (
	input [4:0] tone,
	output reg [31:0] freq 
);
always @(*) begin
	case (tone)
		5'd0: freq = 32'd262;	//Do-m
		5'd1: freq = 32'd294;	//Re-m
		5'd2: freq = 32'd330;	//Mi-m
		5'd3: freq = 32'd349;	//Fa-m
		5'd4: freq = 32'd392;	//Sol-m
		5'd5: freq = 32'd440;	//La-m
		5'd6: freq = 32'd494;	//Si-m
		5'd7: freq = 32'd262 << 1;	//Do-h
		5'd8: freq = 32'd294 << 1;
		5'd9: freq = 32'd330 << 1;
		5'd10: freq = 32'd349 << 1;
		5'd11: freq = 32'd392 << 1;
		5'd12: freq = 32'd440 << 1;
		5'd13: freq = 32'd494 << 1;
		5'd14: freq = 32'd262 << 2;
		5'd15: freq = 32'd294 << 2;
		5'd16: freq = 32'd330 << 2;
		5'd17: freq = 32'd349 << 2;
		5'd18: freq = 32'd392 << 2;
		5'd19: freq = 32'd440 << 2;
		5'd20: freq = 32'd494 << 2;
		5'd21: freq = 32'd262 << 3;
		default : freq = 32'd20000;	//Do-dummy
	endcase
end

endmodule


module PWM_gen (
    input wire clk,
    input wire reset,
	input [31:0] freq,
    input [9:0] duty,
    output reg PWM
);

wire [31:0] count_max = 100_000_000 / freq;
wire [31:0] count_duty = count_max * duty / 1024;
reg [31:0] count;
    
always @(posedge clk, posedge reset) begin
    if (reset) begin
        count <= 0;
        PWM <= 0;
    end else if (count < count_max) begin
        count <= count + 1;
		if(count < count_duty)
            PWM <= 1;
        else
            PWM <= 0;
    end else begin
        count <= 0;
        PWM <= 0;
    end
end

endmodule






module Keyboard(
    output reg W,
    output reg S,
    output reg R,
    output reg rst_n,
    inout wire PS2_DATA,
    inout wire PS2_CLK,
    input rst,
    input wire clk
    );

    parameter [8:0] KEY_CODES_W = 9'b0_0001_1101; // w => 1D
    parameter [8:0] KEY_CODES_S = 9'b0_0001_1011; // s => 1B
    parameter [8:0] KEY_CODES_R = 9'b0_0010_1101; // r => 2D
    parameter [8:0] KEY_CODES_ENTER = 9'b0_0101_1010; // enter => 5A
    parameter [8:0] KEY_CODES_RIGHT_ENTER = 9'b1_0101_1010; // enter => 5A
    
    wire [511:0] key_down;
    wire [8:0] last_change;
    wire been_ready;
        
    KeyboardDecoder key_de (
        .key_down(key_down),
        .last_change(last_change),
        .key_valid(been_ready),
        .PS2_DATA(PS2_DATA),
        .PS2_CLK(PS2_CLK),
        .rst(rst),
        .clk(clk)
    );
    
    always @ (*) begin
        if (been_ready && key_down[last_change] == 1'b1) begin
            case (last_change)
                KEY_CODES_W : begin
                    W = 1'b1;
                    R = 1'b0;
                    S = 1'b0;
                    rst_n = 1'b0;
                end
                KEY_CODES_S : begin
                    W = 1'b0;
                    R = 1'b0;
                    S = 1'b1;
                    rst_n = 1'b0;
                end
                KEY_CODES_R : begin
                    W = 1'b0;
                    R = 1'b1;
                    S = 1'b0;
                    rst_n = 1'b0;
                end
                KEY_CODES_ENTER : begin
                    W = 1'b0;
                    R = 1'b0;
                    S = 1'b0;
                    rst_n = 1'b1;
                end   
                KEY_CODES_RIGHT_ENTER : begin
                    W = 1'b0;
                    R = 1'b0;
                    S = 1'b0;
                    rst_n = 1'b1;
                end
                default     : begin
                    W = 1'b0;
                    R = 1'b0;
                    S = 1'b0;
                    rst_n = 1'b0;
                end
            endcase
        end 
        else begin
                W = 1'b0;
                R = 1'b0;
                S = 1'b0;
                rst_n = 1'b0;
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


module clk_generator(clk, rst_n, One_second, Half_second);
input clk;
input rst_n;
output reg One_second;
output reg Half_second;

reg [27-1:0] count = 27'd0;
reg [26-1:0] half_second_count = 26'd0;

always@(posedge clk)begin
    if(rst_n == 1'b1)begin
        count <= 27'd1;
        half_second_count <= 26'd1;
    end
    else begin
        if(count==27'd99999999)begin
            count <= 27'd0;
        end
        else begin
            count <= count + 27'd1;
        end
        
        if(half_second_count == 26'd49999999)begin
            half_second_count <= 26'd0;
        end
        else begin
            half_second_count <= half_second_count + 26'd1;
        end
    end
end

always@(*)begin
    if(half_second_count == 26'd49999999)begin
        Half_second = 1'b1;
    end
    else begin
        Half_second = 1'b0;
    end
end

always@(*)begin
    if(count == 27'd99999999)begin
        One_second = 1'b1;
    end
    else begin
        One_second = 1'b0;
    end
end

endmodule
