module mem_addr_gen(
  input clk,
  input rst,
  input valid,
  input [9:0]h_cnt,
  input [9:0]v_cnt,
  input [1:0]mode_arith,
  input [3:0]first_digit1,
  input [3:0]first_digit0,
  input [3:0]second_digit1,
  input [3:0]second_digit0,
  input [3:0]result_digit3,
  input [3:0]result_digit2,
  input [3:0]result_digit1,
  input [3:0]result_digit0,
  output reg [16:0] pixel_addr
);

wire [8:0]h_cnt_small;
wire [8:0]v_cnt_small;
reg pixel_addr_blank;
reg [3:0]dis_num; // include num,operator (+ 10,- 11, * 12 = 13 blank 14)
reg [8:0]h_ini_pic;
reg [8:0]v_ini_pic;
reg [4:0]h_pic_cnt;

assign h_cnt_small = h_cnt >> 1;
assign v_cnt_small = v_cnt >> 1; 

always @*
	if (v_cnt_small >= 10 && v_cnt_small < 70) begin
    	if(!valid)
    		dis_num = 4'd14;
    	else if(h_cnt_small < 10)
    		dis_num = 4'd14;
    	else if(h_cnt_small < 40)
    		dis_num = first_digit1;
    	else if(h_cnt_small < 70)
    		dis_num = first_digit0;
		else if(h_cnt_small < 100)
			dis_num = mode_arith + 4'd10;
    	else if(h_cnt_small < 130)
			dis_num = second_digit1;
    	else if(h_cnt_small < 160)
			dis_num = second_digit0;
    	else if(h_cnt_small < 190)
			dis_num = 4'd13;
    	else if(h_cnt_small < 220) 
            dis_num = result_digit3;
    	else if(h_cnt_small < 250)
			dis_num = result_digit2;
    	else if(h_cnt_small < 280)
    		dis_num = result_digit1;
    	else if(h_cnt_small < 310)
    		dis_num = result_digit0;
    	else dis_num = 4'd14;
    end
 	else dis_num = 4'd14;

always @*
	case (dis_num)
    	4'd0: begin
    		h_ini_pic = 9'd0;
    		v_ini_pic = 9'd0;
    	end
    	4'd1: begin
    		h_ini_pic = 9'd30;
    		v_ini_pic = 9'd0;
    	end
    	4'd2: begin
    		h_ini_pic = 9'd60;
    		v_ini_pic = 9'd0;
    	end
    	4'd3: begin
    		h_ini_pic = 9'd90;
    		v_ini_pic = 9'd0;
    	end
    	4'd4: begin
    		h_ini_pic = 9'd120;
    		v_ini_pic = 9'd0;
    	end
    	4'd5: begin
    		h_ini_pic = 9'd0;
    		v_ini_pic = 9'd86;
    	end
    	4'd6: begin
    		h_ini_pic = 9'd30;
    		v_ini_pic = 9'd86;
    	end
    	4'd7: begin
    		h_ini_pic = 9'd60;
    		v_ini_pic = 9'd86;
    	end
    	4'd8: begin
    		h_ini_pic = 9'd90;
    		v_ini_pic = 9'd86;
    	end
    	4'd9: begin
    		h_ini_pic = 9'd120;
    		v_ini_pic = 9'd86;
    	end
    	4'd10: begin
    		h_ini_pic = 9'd0;
    		v_ini_pic = 9'd170;
    	end
    	4'd11: begin
    		h_ini_pic = 9'd30;
    		v_ini_pic = 9'd180;
    	end
    	4'd12: begin
    		h_ini_pic = 9'd53;
    		v_ini_pic = 9'd160;
    	end
    	4'd13: begin
    		h_ini_pic = 9'd83;
    		v_ini_pic = 9'd170;
    	end
    	4'd14: begin
    		h_ini_pic = 9'd0;
    		v_ini_pic = 9'd0;
    	end
    	default: begin
    		h_ini_pic = 9'd0;
    		v_ini_pic = 9'd0;
    	end
    endcase

always @*
	if (dis_num == 4'd14)  h_pic_cnt = 9'd0;
	else if (h_cnt_small < 9'd10) h_pic_cnt = 9'd0;
	else h_pic_cnt = (h_cnt_small - 9'd10) % 5'd30;
always @*
	pixel_addr = (v_cnt_small + v_ini_pic - 4'd10) * 150 + (h_ini_pic + h_pic_cnt); 
	
endmodule
