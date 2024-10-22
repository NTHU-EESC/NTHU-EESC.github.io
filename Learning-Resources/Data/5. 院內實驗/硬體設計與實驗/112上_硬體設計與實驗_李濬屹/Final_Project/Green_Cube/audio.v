module Audio (
    input clk,
    input reset,
    input game_state,
    input tone, //piano keys
    input [8:0] time_gap,
	output pmod_1,	//AIN
	output pmod_2,	//GAIN
	output pmod_4	//SHUTDOWN_N
);
	
wire [31:0] freq;
assign pmod_2 = 1'd1;	//no gain(6dB)
assign pmod_4 = 1'd1;	//turn-on
wire new_tone;

assign new_tone = (game_state==1'b1) && (tone==1'b1);

Decoder decoder00 (
    .time_gap(time_gap),
	.tone(new_tone),
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
    input [8:0] time_gap,
	input tone,
	output reg [31:0] freq 
);
always @(*) begin
	if(tone==1'b1) begin
        if(time_gap<9'd2) begin
            freq = 32'd277 << 1;	
        end
        else if(time_gap<9'd4) begin
            freq = 32'd294 << 1;	
        end
        else if(time_gap<9'd6) begin
            freq = 32'd311 << 1;	
        end
		else if(time_gap<9'd8) begin
            freq = 32'd330 << 1;	
        end
        else if(time_gap<9'd10) begin
            freq = 32'd349 << 1;	
        end
        else if(time_gap<9'd12) begin
            freq = 32'd370 << 1;	
        end
        else if(time_gap<9'd14) begin
            freq = 32'd392 << 1;	
        end
		else if(time_gap<9'd16) begin
            freq = 32'd415 << 1;	
        end
        else if(time_gap<9'd18) begin
            freq = 32'd440 << 1;	
        end
        else begin
            freq = 32'd466 << 1;	
        end
    end
    else begin
        freq = 32'd0;
    end
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