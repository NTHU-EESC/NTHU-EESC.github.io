module pixel_gen(
     input [9:0] h_cnt,
     input [9:0] v_cnt,
     input valid,
     input [9:0] slime_pos_x,
     input [9:0] slime_pos_y,
     input [9:0] floor_pos_x0,
     input [9:0] floor_pos_y0,
     input [9:0] floor_pos_x1,
     input [9:0] floor_pos_y1,
     input [9:0] floor_pos_x2,
     input [9:0] floor_pos_y2,
     input [9:0] floor_pos_x3,
     input [9:0] floor_pos_y3,
     input [9:0] floor_pos_x4,
     input [9:0] floor_pos_y4,
     input [9:0] floor_pos_x5,
     input [9:0] floor_pos_y5,
     input [9:0] floor_pos_x6,
     input [9:0] floor_pos_y6,
     input [9:0] floor_pos_x7,
     input [9:0] floor_pos_y7,
     input [7:0] enable,
     input [3:0] score_0,
     input [3:0] score_1,
     output reg [3:0] vgaRed,
     output reg [3:0] vgaGreen,
     output reg [3:0] vgaBlue,
     input double_jump
     );

     wire [19:0] slime_face [19:0];
     wire [9:0] num_0 [19:0];
     wire [9:0] num_1 [19:0];
     wire [9:0] num_2 [19:0];
     wire [9:0] num_3 [19:0];
     wire [9:0] num_4 [19:0];
     wire [9:0] num_5 [19:0];
     wire [9:0] num_6 [19:0];
     wire [9:0] num_7 [19:0];
     wire [9:0] num_8 [19:0];
     wire [9:0] num_9 [19:0];

     assign slime_face[19] = 20'b00000000000000000000;
     assign slime_face[18] = 20'b00000000000000000000;
     assign slime_face[17] = 20'b00001100000000110000;
     assign slime_face[16] = 20'b00011110000001111000;
     assign slime_face[15] = 20'b00111111000011111100;
     assign slime_face[14] = 20'b00110011000011001100;
     assign slime_face[13] = 20'b00100001000010000100;
     assign slime_face[12] = 20'b00000000011000000000;
     assign slime_face[11] = 20'b00000000111100000000;
     assign slime_face[10] = 20'b00000001100110000000;
     assign slime_face[9] =  20'b00110001000010001100;
     assign slime_face[8] =  20'b00111100000000111100;
     assign slime_face[7] =  20'b00011111111111111000;
     assign slime_face[6] =  20'b00011111111111111000;
     assign slime_face[5] =  20'b00001111111111110000;
     assign slime_face[4] =  20'b00000111111111100000;
     assign slime_face[3] =  20'b00000001111110000000;
     assign slime_face[2] =  20'b00000000000000000000;
     assign slime_face[1] =  20'b00000000000000000000;
     assign slime_face[0] =  20'b00000000000000000000;

     assign num_0[19] = 10'b0000000000;
     assign num_0[18] = 10'b0000000000;
     assign num_0[17] = 10'b0000000000;
     assign num_0[16] = 10'b0111111110;
     assign num_0[15] = 10'b0111111110;
     assign num_0[14] = 10'b0110000110;
     assign num_0[13] = 10'b0110000110;
     assign num_0[12] = 10'b0110000110;
     assign num_0[11] = 10'b0110000110;
     assign num_0[10] = 10'b0110000110;
     assign num_0[9] =  10'b0110000110;
     assign num_0[8] =  10'b0110000110;
     assign num_0[7] =  10'b0110000110;
     assign num_0[6] =  10'b0110000110;
     assign num_0[5] =  10'b0110000110;
     assign num_0[4] =  10'b0111111110;
     assign num_0[3] =  10'b0111111110;
     assign num_0[2] =  10'b0000000000;
     assign num_0[1] =  10'b0000000000;
     assign num_0[0] =  10'b0000000000;

     assign num_1[19] = 10'b0000000000;
     assign num_1[18] = 10'b0000000000;
     assign num_1[17] = 10'b0000000000;
     assign num_1[16] = 10'b0000110000;
     assign num_1[15] = 10'b0011110000;
     assign num_1[14] = 10'b0011110000;
     assign num_1[13] = 10'b0000110000;
     assign num_1[12] = 10'b0000110000;
     assign num_1[11] = 10'b0000110000;
     assign num_1[10] = 10'b0000110000;
     assign num_1[9] =  10'b0000110000;
     assign num_1[8] =  10'b0000110000;
     assign num_1[7] =  10'b0000110000;
     assign num_1[6] =  10'b0000110000;
     assign num_1[5] =  10'b0000110000;
     assign num_1[4] =  10'b0111111110;
     assign num_1[3] =  10'b0111111110;
     assign num_1[2] =  10'b0000000000;
     assign num_1[1] =  10'b0000000000;
     assign num_1[0] =  10'b0000000000;

     assign num_2[19] = 10'b0000000000;
     assign num_2[18] = 10'b0000000000;
     assign num_2[17] = 10'b0000000000;
     assign num_2[16] = 10'b0111111110;
     assign num_2[15] = 10'b0111111110;
     assign num_2[14] = 10'b0000000110;
     assign num_2[13] = 10'b0000000110;
     assign num_2[12] = 10'b0000000110;
     assign num_2[11] = 10'b0000000110;
     assign num_2[10] = 10'b0111111110;
     assign num_2[9] =  10'b0111111110;
     assign num_2[8] =  10'b0110000000;
     assign num_2[7] =  10'b0110000000;
     assign num_2[6] =  10'b0110000000;
     assign num_2[5] =  10'b0110000000;
     assign num_2[4] =  10'b0111111110;
     assign num_2[3] =  10'b0111111110;
     assign num_2[2] =  10'b0000000000;
     assign num_2[1] =  10'b0000000000;
     assign num_2[0] =  10'b0000000000;

     assign num_3[19] = 10'b0000000000;
     assign num_3[18] = 10'b0000000000;
     assign num_3[17] = 10'b0000000000;
     assign num_3[16] = 10'b0111111110;
     assign num_3[15] = 10'b0111111110;
     assign num_3[14] = 10'b0000000110;
     assign num_3[13] = 10'b0000000110;
     assign num_3[12] = 10'b0000000110;
     assign num_3[11] = 10'b0000000110;
     assign num_3[10] = 10'b0111111110;
     assign num_3[9] =  10'b0111111110;
     assign num_3[8] =  10'b0000000110;
     assign num_3[7] =  10'b0000000110;
     assign num_3[6] =  10'b0000000110;
     assign num_3[5] =  10'b0000000110;
     assign num_3[4] =  10'b0111111110;
     assign num_3[3] =  10'b0111111110;
     assign num_3[2] =  10'b0000000000;
     assign num_3[1] =  10'b0000000000;
     assign num_3[0] =  10'b0000000000;

     assign num_4[19] = 10'b0000000000;
     assign num_4[18] = 10'b0000000000;
     assign num_4[17] = 10'b0000000000;
     assign num_4[16] = 10'b0110000110;
     assign num_4[15] = 10'b0110000110;
     assign num_4[14] = 10'b0110000110;
     assign num_4[13] = 10'b0110000110;
     assign num_4[12] = 10'b0110000110;
     assign num_4[11] = 10'b0110000110;
     assign num_4[10] = 10'b0111111110;
     assign num_4[9] =  10'b0111111110;
     assign num_4[8] =  10'b0000000110;
     assign num_4[7] =  10'b0000000110;
     assign num_4[6] =  10'b0000000110;
     assign num_4[5] =  10'b0000000110;
     assign num_4[4] =  10'b0000000110;
     assign num_4[3] =  10'b0000000110;
     assign num_4[2] =  10'b0000000000;
     assign num_4[1] =  10'b0000000000;
     assign num_4[0] =  10'b0000000000;

     assign num_5[19] = 10'b0000000000;
     assign num_5[18] = 10'b0000000000;
     assign num_5[17] = 10'b0000000000;
     assign num_5[16] = 10'b0111111110;
     assign num_5[15] = 10'b0111111110;
     assign num_5[14] = 10'b0110000000;
     assign num_5[13] = 10'b0110000000;
     assign num_5[12] = 10'b0110000000;
     assign num_5[11] = 10'b0110000000;
     assign num_5[10] = 10'b0111111110;
     assign num_5[9] =  10'b0111111110;
     assign num_5[8] =  10'b0000000110;
     assign num_5[7] =  10'b0000000110;
     assign num_5[6] =  10'b0000000110;
     assign num_5[5] =  10'b0000000110;
     assign num_5[4] =  10'b0111111110;
     assign num_5[3] =  10'b0111111110;
     assign num_5[2] =  10'b0000000000;
     assign num_5[1] =  10'b0000000000;
     assign num_5[0] =  10'b0000000000;

     assign num_6[19] = 10'b0000000000;
     assign num_6[18] = 10'b0000000000;
     assign num_6[17] = 10'b0000000000;
     assign num_6[16] = 10'b0111111110;
     assign num_6[15] = 10'b0111111110;
     assign num_6[14] = 10'b0110000000;
     assign num_6[13] = 10'b0110000000;
     assign num_6[12] = 10'b0110000000;
     assign num_6[11] = 10'b0110000000;
     assign num_6[10] = 10'b0111111110;
     assign num_6[9] =  10'b0111111110;
     assign num_6[8] =  10'b0110000110;
     assign num_6[7] =  10'b0110000110;
     assign num_6[6] =  10'b0110000110;
     assign num_6[5] =  10'b0110000110;
     assign num_6[4] =  10'b0111111110;
     assign num_6[3] =  10'b0111111110;
     assign num_6[2] =  10'b0000000000;
     assign num_6[1] =  10'b0000000000;
     assign num_6[0] =  10'b0000000000;

     assign num_7[19] = 10'b0000000000;
     assign num_7[18] = 10'b0000000000;
     assign num_7[17] = 10'b0000000000;
     assign num_7[16] = 10'b0111111110;
     assign num_7[15] = 10'b0111111110;
     assign num_7[14] = 10'b0110000110;
     assign num_7[13] = 10'b0110000110;
     assign num_7[12] = 10'b0110000110;
     assign num_7[11] = 10'b0110000110;
     assign num_7[10] = 10'b0000000110;
     assign num_7[9] =  10'b0000000110;
     assign num_7[8] =  10'b0000000110;
     assign num_7[7] =  10'b0000000110;
     assign num_7[6] =  10'b0000000110;
     assign num_7[5] =  10'b0000000110;
     assign num_7[4] =  10'b0000000110;
     assign num_7[3] =  10'b0000000110;
     assign num_7[2] =  10'b0000000000;
     assign num_7[1] =  10'b0000000000;
     assign num_7[0] =  10'b0000000000;

     assign num_8[19] = 10'b0000000000;
     assign num_8[18] = 10'b0000000000;
     assign num_8[17] = 10'b0000000000;
     assign num_8[16] = 10'b0111111110;
     assign num_8[15] = 10'b0111111110;
     assign num_8[14] = 10'b0110000110;
     assign num_8[13] = 10'b0110000110;
     assign num_8[12] = 10'b0110000110;
     assign num_8[11] = 10'b0110000110;
     assign num_8[10] = 10'b0111111110;
     assign num_8[9] =  10'b0111111110;
     assign num_8[8] =  10'b0110000110;
     assign num_8[7] =  10'b0110000110;
     assign num_8[6] =  10'b0110000110;
     assign num_8[5] =  10'b0110000110;
     assign num_8[4] =  10'b0111111110;
     assign num_8[3] =  10'b0111111110;
     assign num_8[2] =  10'b0000000000;
     assign num_8[1] =  10'b0000000000;
     assign num_8[0] =  10'b0000000000;

     assign num_9[19] = 10'b0000000000;
     assign num_9[18] = 10'b0000000000;
     assign num_9[17] = 10'b0000000000;
     assign num_9[16] = 10'b0111111110;
     assign num_9[15] = 10'b0111111110;
     assign num_9[14] = 10'b0110000110;
     assign num_9[13] = 10'b0110000110;
     assign num_9[12] = 10'b0110000110;
     assign num_9[11] = 10'b0110000110;
     assign num_9[10] = 10'b0111111110;
     assign num_9[9] =  10'b0111111110;
     assign num_9[8] =  10'b0000000110;
     assign num_9[7] =  10'b0000000110;
     assign num_9[6] =  10'b0000000110;
     assign num_9[5] =  10'b0000000110;
     assign num_9[4] =  10'b0111111110;
     assign num_9[3] =  10'b0111111110;
     assign num_9[2] =  10'b0000000000;
     assign num_9[1] =  10'b0000000000;
     assign num_9[0] =  10'b0000000000;

     wire [11:0] SLIME_COLOR, BLOCK_COLOR, BACKGROUND;

     assign SLIME_COLOR = (double_jump) ? 12'hf11 : ((score_1 >= 4'd2) ? 12'h1f1 : 12'hfff);
     assign BLOCK_COLOR = (score_1 >= 4'd5) ? 12'hb62 : 12'hfff;
     assign BACKGROUND = (score_1 >= 4'd5) ? 12'h8df : 12'h000;
     parameter BLACK = 12'h000;
   
     always @(*) begin
          if (!valid) {vgaRed, vgaGreen, vgaBlue} = 12'h000;
          else begin
               if ((h_cnt >= slime_pos_x && h_cnt < slime_pos_x + 10'd20) && (v_cnt < slime_pos_y && v_cnt >= slime_pos_y - 10'd20)) begin
                    if(score_0 == 4'd0 && score_1 == 4'd0) begin
                         if (slime_face[slime_pos_y - v_cnt - 10'd1][h_cnt - slime_pos_x]) {vgaRed, vgaGreen, vgaBlue} = 12'h000;
                         else {vgaRed, vgaGreen, vgaBlue} = SLIME_COLOR;
                    end
                    else begin
                         if(h_cnt < slime_pos_x + 10'd10)begin
                              case(score_1)
                                   4'd0:    {vgaRed, vgaGreen, vgaBlue} = (num_0[slime_pos_y - v_cnt - 10'd1][10'd9 - (h_cnt - slime_pos_x)]) ? BLACK : SLIME_COLOR;
                                   4'd1:    {vgaRed, vgaGreen, vgaBlue} = (num_1[slime_pos_y - v_cnt - 10'd1][10'd9 - (h_cnt - slime_pos_x)]) ? BLACK : SLIME_COLOR;
                                   4'd2:    {vgaRed, vgaGreen, vgaBlue} = (num_2[slime_pos_y - v_cnt - 10'd1][10'd9 - (h_cnt - slime_pos_x)]) ? BLACK : SLIME_COLOR;
                                   4'd3:    {vgaRed, vgaGreen, vgaBlue} = (num_3[slime_pos_y - v_cnt - 10'd1][10'd9 - (h_cnt - slime_pos_x)]) ? BLACK : SLIME_COLOR;
                                   4'd4:    {vgaRed, vgaGreen, vgaBlue} = (num_4[slime_pos_y - v_cnt - 10'd1][10'd9 - (h_cnt - slime_pos_x)]) ? BLACK : SLIME_COLOR;
                                   4'd5:    {vgaRed, vgaGreen, vgaBlue} = (num_5[slime_pos_y - v_cnt - 10'd1][10'd9 - (h_cnt - slime_pos_x)]) ? BLACK : SLIME_COLOR;
                                   4'd6:    {vgaRed, vgaGreen, vgaBlue} = (num_6[slime_pos_y - v_cnt - 10'd1][10'd9 - (h_cnt - slime_pos_x)]) ? BLACK : SLIME_COLOR;
                                   4'd7:    {vgaRed, vgaGreen, vgaBlue} = (num_7[slime_pos_y - v_cnt - 10'd1][10'd9 - (h_cnt - slime_pos_x)]) ? BLACK : SLIME_COLOR;
                                   4'd8:    {vgaRed, vgaGreen, vgaBlue} = (num_8[slime_pos_y - v_cnt - 10'd1][10'd9 - (h_cnt - slime_pos_x)]) ? BLACK : SLIME_COLOR;
                                   default: {vgaRed, vgaGreen, vgaBlue} = (num_9[slime_pos_y - v_cnt - 10'd1][10'd9 - (h_cnt - slime_pos_x)]) ? BLACK : SLIME_COLOR;
                              endcase
                         end
                         else begin
                              case(score_0)
                                   4'd0:    {vgaRed, vgaGreen, vgaBlue} = (num_0[slime_pos_y - v_cnt - 10'd1][10'd19 - (h_cnt - slime_pos_x)]) ? BLACK : SLIME_COLOR;
                                   4'd1:    {vgaRed, vgaGreen, vgaBlue} = (num_1[slime_pos_y - v_cnt - 10'd1][10'd19 - (h_cnt - slime_pos_x)]) ? BLACK : SLIME_COLOR;
                                   4'd2:    {vgaRed, vgaGreen, vgaBlue} = (num_2[slime_pos_y - v_cnt - 10'd1][10'd19 - (h_cnt - slime_pos_x)]) ? BLACK : SLIME_COLOR;
                                   4'd3:    {vgaRed, vgaGreen, vgaBlue} = (num_3[slime_pos_y - v_cnt - 10'd1][10'd19 - (h_cnt - slime_pos_x)]) ? BLACK : SLIME_COLOR;
                                   4'd4:    {vgaRed, vgaGreen, vgaBlue} = (num_4[slime_pos_y - v_cnt - 10'd1][10'd19 - (h_cnt - slime_pos_x)]) ? BLACK : SLIME_COLOR;
                                   4'd5:    {vgaRed, vgaGreen, vgaBlue} = (num_5[slime_pos_y - v_cnt - 10'd1][10'd19 - (h_cnt - slime_pos_x)]) ? BLACK : SLIME_COLOR;
                                   4'd6:    {vgaRed, vgaGreen, vgaBlue} = (num_6[slime_pos_y - v_cnt - 10'd1][10'd19 - (h_cnt - slime_pos_x)]) ? BLACK : SLIME_COLOR;
                                   4'd7:    {vgaRed, vgaGreen, vgaBlue} = (num_7[slime_pos_y - v_cnt - 10'd1][10'd19 - (h_cnt - slime_pos_x)]) ? BLACK : SLIME_COLOR;
                                   4'd8:    {vgaRed, vgaGreen, vgaBlue} = (num_8[slime_pos_y - v_cnt - 10'd1][10'd19 - (h_cnt - slime_pos_x)]) ? BLACK : SLIME_COLOR;
                                   default: {vgaRed, vgaGreen, vgaBlue} = (num_9[slime_pos_y - v_cnt - 10'd1][10'd19 - (h_cnt - slime_pos_x)]) ? BLACK : SLIME_COLOR;
                              endcase
                         end
                    end
               end
               else begin
                    if ((h_cnt >= floor_pos_x0 && h_cnt < floor_pos_x0 + 10'd40) && (v_cnt >= floor_pos_y0 && v_cnt < floor_pos_y0 + 10'd5) && enable[0])
                         {vgaRed, vgaGreen, vgaBlue} = BLOCK_COLOR;

                    else if ((h_cnt >= floor_pos_x1 && h_cnt < floor_pos_x1 + 10'd40) && (v_cnt >= floor_pos_y1 && v_cnt < floor_pos_y1 + 10'd5) && enable[1])
                         {vgaRed, vgaGreen, vgaBlue} = BLOCK_COLOR;

                    else if ((h_cnt >= floor_pos_x2 && h_cnt < floor_pos_x2 + 10'd40) && (v_cnt >= floor_pos_y2 && v_cnt < floor_pos_y2 + 10'd5) && enable[2])
                         {vgaRed, vgaGreen, vgaBlue} = BLOCK_COLOR;

                    else if ((h_cnt >= floor_pos_x3 && h_cnt < floor_pos_x3 + 10'd40) && (v_cnt >= floor_pos_y3 && v_cnt < floor_pos_y3 + 10'd5) && enable[3])
                         {vgaRed, vgaGreen, vgaBlue} = BLOCK_COLOR;

                    else if ((h_cnt >= floor_pos_x4 && h_cnt < floor_pos_x4 + 10'd40) && (v_cnt >= floor_pos_y4 && v_cnt < floor_pos_y4 + 10'd5) && enable[4])
                         {vgaRed, vgaGreen, vgaBlue} = BLOCK_COLOR;

                    else if ((h_cnt >= floor_pos_x5 && h_cnt < floor_pos_x5 + 10'd40) && (v_cnt >= floor_pos_y5 && v_cnt < floor_pos_y5 + 10'd5) && enable[5])
                         {vgaRed, vgaGreen, vgaBlue} = BLOCK_COLOR;

                    else if ((h_cnt >= floor_pos_x6 && h_cnt < floor_pos_x6 + 10'd40) && (v_cnt >= floor_pos_y6 && v_cnt < floor_pos_y6 + 10'd5) && enable[6])
                         {vgaRed, vgaGreen, vgaBlue} = BLOCK_COLOR;

                    else if ((h_cnt >= floor_pos_x7 && h_cnt < floor_pos_x7 + 10'd40) && (v_cnt >= floor_pos_y7 && v_cnt < floor_pos_y7 + 10'd5) && enable[7])
                         {vgaRed, vgaGreen, vgaBlue} = BLOCK_COLOR;

                    else {vgaRed, vgaGreen, vgaBlue} = BACKGROUND;
               end
          end
     end

endmodule