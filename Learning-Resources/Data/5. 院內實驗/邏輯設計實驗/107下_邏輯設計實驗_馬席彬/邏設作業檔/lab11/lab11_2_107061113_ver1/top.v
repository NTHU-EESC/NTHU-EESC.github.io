module top(
  inout PS2_DATA,
  inout PS2_CLK,
  input clk_100MHz,
  input rst,
  output [3:0] vgaRed,
  output [3:0] vgaGreen,
  output [3:0] vgaBlue,
  output hsync,
  output vsync
);
wire rst_n;
wire [3:0]first_digit[1:0];
wire [3:0]second_digit[1:0];
wire [3:0]result_digit[3:0];
wire [1:0]mode_arith;
wire [11:0] data;
wire clk_25MHz;
wire clk_22;
wire [16:0] pixel_addr;
wire [11:0] pixel;
wire valid;
wire [9:0] h_cnt; //640
wire [9:0] v_cnt;  //480

assign rst_n = ~rst;
assign {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel:12'h0;

// calculate result from keyboard inputs
calculate calc (
	.clk_100MHz(clk_100MHz),
	.rst_n(rst_n),
	.PS2_DATA(PS2_DATA),
	.PS2_CLK(PS2_CLK),
	.mode_arith(mode_arith),
	.first_digit1(first_digit[1]),
	.first_digit0(first_digit[0]),
	.second_digit1(second_digit[1]),
	.second_digit0(second_digit[0]),
	.result_digit3(result_digit[3]),
	.result_digit2(result_digit[2]),
	.result_digit1(result_digit[1]),
	.result_digit0(result_digit[0]));
	
// Frequency Divider
clock_divisor clk_wiz_0_inst(
  .clk(clk_100MHz),
  .clk1(clk_25MHz),
  .clk22(clk_22)
);

// Reduce frame address from 640x480 to 320x240
mem_addr_gen mem_addr_gen_inst(
  .clk(clk_22),
  .rst(rst),
  .valid(valid),
  .h_cnt(h_cnt),
  .v_cnt(v_cnt),
  .mode_arith(mode_arith),
  .first_digit1(first_digit[1]),
  .first_digit0(first_digit[0]),
  .second_digit1(second_digit[1]),
  .second_digit0(second_digit[0]),
  .result_digit3(result_digit[3]),
  .result_digit2(result_digit[2]),
  .result_digit1(result_digit[1]),
  .result_digit0(result_digit[0]),
  .pixel_addr(pixel_addr)
);
     
// Use reduced 320x240 address to output the saved picture from RAM 
blk_mem_gen_0 blk_mem_gen_0_inst(
  .clka(clk_25MHz),
  .wea(0),
  .addra(pixel_addr),
  .dina(data[11:0]),
  .douta(pixel)
); 

// Render the picture by VGA controller
vga_controller vga_inst(
  .pclk(clk_25MHz),
  .reset(rst),
  .hsync(hsync),
  .vsync(vsync),
  .valid(valid),
  .h_cnt(h_cnt),
  .v_cnt(v_cnt)
);
      
endmodule
