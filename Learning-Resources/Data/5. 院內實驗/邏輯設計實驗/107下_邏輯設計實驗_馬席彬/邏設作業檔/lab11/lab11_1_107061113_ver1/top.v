module top(
  input clk,
  input rst,
  input pb_en,
  output [3:0] vgaRed,
  output [3:0] vgaGreen,
  output [3:0] vgaBlue,
  output hsync,
  output vsync
);

wire rst_n;
wire en_debounced;
wire en_pulse;
wire mode_scroll;
wire [11:0] data;
wire clk_100Hz;
wire clk_25MHz;
wire clk_22;
wire [16:0] pixel_addr;
wire [11:0] pixel;
wire valid;
wire [9:0] h_cnt; //640
wire [9:0] v_cnt;  //480

assign {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel:12'h0;
assign rst_n = ~rst;
// Frequency Divider
freq_div_100 clk_100(
	.clk(clk),
	.rst_n(rst_n),
	.clk_out(clk_100Hz)
);

clock_divisor clk_wiz_0_inst(
  .clk(clk),
  .clk1(clk_25MHz),
  .clk22(clk_22)
);

debounce D0(
	.pb_in(pb_en),
	.clk(clk_100Hz),
	.rst_n(rst_n),
	.pb_debounced(en_debounced)
);

one_pulse A1(
	.in_trig(en_debounced),
	.clk(clk_100Hz),
	.rst_n(rst_n),
	.one_pulse(en_pulse)
);

FSM_scroll fsm_scroll(
	.pulse(en_pulse),
	.clk(clk_100Hz),
	.rst_n(rst_n),
	.mode(mode_scroll)
);
// Reduce frame address from 640x480 to 320x240
mem_addr_gen mem_addr_gen_inst(
  .clk(clk_22),
  .rst(rst),
  .en(mode_scroll),
  .h_cnt(h_cnt),
  .v_cnt(v_cnt),
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
vga_controller   vga_inst(
  .pclk(clk_25MHz),
  .reset(rst),
  .hsync(hsync),
  .vsync(vsync),
  .valid(valid),
  .h_cnt(h_cnt),
  .v_cnt(v_cnt)
);
      
endmodule
