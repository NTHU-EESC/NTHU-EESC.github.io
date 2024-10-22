module Top(clk, rst, vgaRed, vgaBlue, vgaGreen, hsync, vsync, PS2_DATA, PS2_CLK, led, pmod_1, pmod_2, pmod_4);
	input clk, rst;
    output wire [3:0] vgaRed, vgaGreen, vgaBlue;
    output hsync, vsync;
	inout wire PS2_DATA;
    inout wire PS2_CLK;
    output wire led;
    output pmod_1;	//AIN
	output pmod_2;	//GAIN
	output pmod_4;	//SHUTDOWN_N

    assign led = 1'b1;
	
	wire clk_d2;//25MHz
	wire clk_d18;
    wire clk_vga_x;
    wire clk_bling;
    wire clk_floor;
    wire [16:0] pixel_addr;
    wire [11:0] pixel;
	wire [11:0] data;
    wire valid;
	//640*480
    wire [9:0] h_cnt, v_cnt;

	wire [9:0] slime_pos_x, slime_pos_y;

    wire [9:0] floor_pos_x0, floor_pos_y0, floor_pos_x1, floor_pos_y1, floor_pos_x2, floor_pos_y2, floor_pos_x3, floor_pos_y3;
    wire [9:0] floor_pos_x4, floor_pos_y4, floor_pos_x5, floor_pos_y5, floor_pos_x6, floor_pos_y6, floor_pos_x7, floor_pos_y7;

    wire [7:0] enable;
    wire tone;

    wire [3:0] score_0, score_1;
    wire [3:0] last_score_0, last_score_1;
    wire [3:0] highest_score_0, highest_score_1;

    wire rst_db, rst_op;

	// keyboard
	parameter [8:0] KEY_A = 9'h01c;
    parameter [8:0] KEY_D = 9'h023;
    parameter [8:0] KEY_CODES_ENTER = 9'b0_0101_1010; // enter => 5A
    parameter [8:0] KEY_CODES_RIGHT_ENTER = 9'b1_0101_1010; // enter => 5A
    parameter [8:0] KEY_SPACE = 9'h029; // enter => 5A
    parameter COVER = 1'b0;
    parameter GAME = 1'b1;

    reg game_state, next_game_state;
    reg Enter_press;
    reg Space_press;
    wire slime_die;
    wire rst_game;

 	wire [511:0] key_down;
    wire [8:0] last_change;
    wire been_ready;
	reg [1:0] key_state;

    wire hit_ceiling;
    wire [8:0] time_gap;
    
    wire [3:0] vgaRed_cover, vgaGreen_cover, vgaBlue_cover;
    wire [3:0] vgaRed_game, vgaGreen_game, vgaBlue_game;

    wire double_jump;

	//clock
	clk_div #(2) CD0(.clk(clk), .clk_d(clk_d2));
    clk_div #(26) CD1(.clk(clk), .clk_d(clk_bling));
	// clk_div #(19) CD1(.clk(clk), .clk_d(clk_18));
    clk_vga CV(.rst(rst), .clk(clk), .dclk(clk_18), .dclk_x(clk_vga_x));
    clk_floor CF(.rst(rst), .clk(clk), .dclk(clk_floor));

    debounce DB_RST(.s(rst), .s_db(rst_db), .clk(clk));
    onepulse OP_RST(.s(rst_db), .s_op(rst_op), .clk(clk));

    record R(
        .score_0(score_0),
        .score_1(score_1),
        .rst(rst),
        .slime_die(slime_die),
        .clk(clk),
        .last_score_0(last_score_0),
        .last_score_1(last_score_1),
        .highest_score_0(highest_score_0),
        .highest_score_1(highest_score_1)
    );

    cover C(
        .h_cnt(h_cnt),
		.v_cnt(v_cnt),
		.valid(valid),
        .clk_bling(clk_bling),
        .vgaRed(vgaRed_cover),
		.vgaGreen(vgaGreen_cover),
		.vgaBlue(vgaBlue_cover),
        .last_score_0(last_score_0),
        .last_score_1(last_score_1),
        .highest_score_0(highest_score_0),
        .highest_score_1(highest_score_1)
    );

	pixel_gen PG(
		.h_cnt(h_cnt),
		.v_cnt(v_cnt),
		.valid(valid),
		.slime_pos_x(slime_pos_x),
		.slime_pos_y(slime_pos_y),
        .floor_pos_x0(floor_pos_x0),
        .floor_pos_y0(floor_pos_y0),
        .floor_pos_x1(floor_pos_x1),
        .floor_pos_y1(floor_pos_y1),
        .floor_pos_x2(floor_pos_x2),
        .floor_pos_y2(floor_pos_y2),
        .floor_pos_x3(floor_pos_x3),
        .floor_pos_y3(floor_pos_y3),
        .floor_pos_x4(floor_pos_x4),
        .floor_pos_y4(floor_pos_y4),
        .floor_pos_x5(floor_pos_x5),
        .floor_pos_y5(floor_pos_y5),
        .floor_pos_x6(floor_pos_x6),
        .floor_pos_y6(floor_pos_y6),
        .floor_pos_x7(floor_pos_x7),
        .floor_pos_y7(floor_pos_y7),
        .enable(enable),
        .score_0(score_0),
        .score_1(score_1),
		.vgaRed(vgaRed_game),
		.vgaGreen(vgaGreen_game),
		.vgaBlue(vgaBlue_game),
        .double_jump(double_jump)
	);

    assign vgaRed = (game_state == COVER) ? vgaRed_cover : vgaRed_game;
    assign vgaBlue = (game_state == COVER) ? vgaBlue_cover : vgaBlue_game;
    assign vgaGreen = (game_state == COVER) ? vgaGreen_cover : vgaGreen_game;
    assign rst_game = rst_db || slime_die;

    floor_gen FG(
        .rst(rst_game),
		.clk(clk),
        .clk_floor(clk_floor),
        .clk_vga(clk_18),

        .floor_pos_x0(floor_pos_x0),
        .floor_pos_y0(floor_pos_y0),
        .floor_pos_x1(floor_pos_x1),
        .floor_pos_y1(floor_pos_y1),
        .floor_pos_x2(floor_pos_x2),
        .floor_pos_y2(floor_pos_y2),
        .floor_pos_x3(floor_pos_x3),
        .floor_pos_y3(floor_pos_y3),

        .floor_pos_x4(floor_pos_x4),
        .floor_pos_y4(floor_pos_y4),
        .floor_pos_x5(floor_pos_x5),
        .floor_pos_y5(floor_pos_y5),
        .floor_pos_x6(floor_pos_x6),
        .floor_pos_y6(floor_pos_y6),
        .floor_pos_x7(floor_pos_x7),
        .floor_pos_y7(floor_pos_y7),

        .enable(enable),
        .time_gap(time_gap),
        .hit_ceiling(hit_ceiling)
    );

	slime_move SM(
		.rst(rst_game),
		.clk(clk),
        .clk_vga(clk_18),
        .clk_vga_x(clk_vga_x),
		.x(slime_pos_x),
		.y(slime_pos_y),
		.key(key_state),
        .floor_pos_x0(floor_pos_x0),
        .floor_pos_y0(floor_pos_y0),
        .floor_pos_x1(floor_pos_x1),
        .floor_pos_y1(floor_pos_y1),
        .floor_pos_x2(floor_pos_x2),
        .floor_pos_y2(floor_pos_y2),
        .floor_pos_x3(floor_pos_x3),
        .floor_pos_y3(floor_pos_y3),
        .floor_pos_x4(floor_pos_x4),
        .floor_pos_y4(floor_pos_y4),
        .floor_pos_x5(floor_pos_x5),
        .floor_pos_y5(floor_pos_y5),
        .floor_pos_x6(floor_pos_x6),
        .floor_pos_y6(floor_pos_y6),
        .floor_pos_x7(floor_pos_x7),
        .floor_pos_y7(floor_pos_y7),
        .enable(enable),
        .Space_press(Space_press),
        .time_gap(time_gap),
        .hit_ceiling(hit_ceiling),
        .slime_die(slime_die),
        .score_0(score_0),
        .score_1(score_1),
        .tone(tone),
        .double_jump(double_jump)
	);

	KeyboardDecoder key_de (
        .key_down(key_down),
        .last_change(last_change),
        .key_valid(been_ready),
        .PS2_DATA(PS2_DATA),
        .PS2_CLK(PS2_CLK),
        .rst(rst_db),
        .clk(clk)
    );

    vga_controller VC0(
        .pclk(clk_d2),
        .reset(rst_db),
        .hsync(hsync),
        .vsync(vsync),
        .valid(valid),
        .h_cnt(h_cnt),
        .v_cnt(v_cnt)
    );

    Audio A(
        .clk(clk),
        .reset(rst_game),
        .time_gap(time_gap),
        .game_state(game_state),
        .tone(tone),
        .pmod_1(pmod_1),	//AIN
        .pmod_2(pmod_2),	//GAIN
        .pmod_4(pmod_4)	//SHUTDOWN_N
    );

    always @ (posedge clk)begin
        if(rst) begin
            game_state <= COVER;
        end
        else begin
            game_state <= next_game_state;
        end
    end

    always @ (*) begin
        case (game_state)
            COVER: begin
                if(Enter_press) begin
                    next_game_state <= GAME;
                end
                else begin
                    next_game_state <= game_state;
                end
            end
            default: begin
                if(slime_die) begin
                    next_game_state <= COVER;
                end
                else begin
                    next_game_state <= game_state;
                end
            end
        endcase
    end

	always @ (posedge clk) begin
        if (been_ready && key_down[last_change]) begin
            if(game_state == COVER) begin
                case (last_change)
                    KEY_CODES_ENTER: begin
                        Enter_press <= 1'b1;
                    end
                    KEY_CODES_RIGHT_ENTER: begin
                        Enter_press <= 1'b1;
                    end
                    default: begin
                        Enter_press <= 1'b0;
                    end
                endcase
                key_state <= 2'b00;
                Space_press <= 1'b0;
            end
            else begin
                case (last_change)
                    KEY_A: begin
                        key_state <= 2'b10;
                        Space_press <= 1'b0;
                    end
                    KEY_D: begin
                        key_state <= 2'b01;
                        Space_press <= 1'b0;
                    end
                    KEY_SPACE: begin
                        key_state <= key_state;
                        Space_press <= 1'b1;
                    end
                    default: begin
                        key_state <= 2'b00;
                    end
                endcase
                Enter_press <= 1'b0;
            end
        end
        else begin
            key_state <= 2'b00;
            Enter_press <= 1'b0;
        end
    end
	
endmodule