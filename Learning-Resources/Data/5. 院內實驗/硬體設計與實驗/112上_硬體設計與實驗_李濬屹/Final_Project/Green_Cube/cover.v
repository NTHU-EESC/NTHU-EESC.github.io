module cover(
    input [9:0] h_cnt,
    input [9:0] v_cnt,
    input valid,
    input clk_bling,
    output reg [3:0] vgaRed,
    output reg [3:0] vgaGreen,
    output reg [3:0] vgaBlue,
    input [3:0] last_score_0,
    input [3:0] last_score_1,
    input [3:0] highest_score_0,
    input [3:0] highest_score_1
    );

    wire [12:0] P [14:0];
    assign P[0] =  13'b0111111111000;
    assign P[1] =  13'b0111111111100;
    assign P[2] =  13'b0111111111110;
    assign P[3] =  13'b0111000011110;
    assign P[4] =  13'b0111000001110;
    assign P[5] =  13'b0111000011110;
    assign P[6] =  13'b0111111111110;
    assign P[7] =  13'b0111111111100;
    assign P[8] =  13'b0111111111000;
    assign P[9] =  13'b0111000000000;
    assign P[10] = 13'b0111000000000;
    assign P[11] = 13'b0111000000000;
    assign P[12] = 13'b0111000000000;
    assign P[13] = 13'b0111000000000;
    assign P[14] = 13'b0111000000000;
    
    wire [12:0] R [14:0];
    assign R[0] =  13'b0111111111000;
    assign R[1] =  13'b0111111111100;
    assign R[2] =  13'b0111111111110;
    assign R[3] =  13'b0111000011110;
    assign R[4] =  13'b0111000001110;
    assign R[5] =  13'b0111000011110;
    assign R[6] =  13'b0111111111110;
    assign R[7] =  13'b0111111111100;
    assign R[8] =  13'b0111111111000;
    assign R[9] =  13'b0111001110000;
    assign R[10] = 13'b0111000111000;
    assign R[11] = 13'b0111000011100;
    assign R[12] = 13'b0111000011100;
    assign R[13] = 13'b0111000001110;
    assign R[14] = 13'b0111000001110;

    wire [12:0] E [14:0];
    assign E[0] =  13'b0111111111110;
    assign E[1] =  13'b0111111111110;
    assign E[2] =  13'b0111111111110;
    assign E[3] =  13'b0111000000000;
    assign E[4] =  13'b0111000000000;
    assign E[5] =  13'b0111000000000;
    assign E[6] =  13'b0111111111110;
    assign E[7] =  13'b0111111111110;
    assign E[8] =  13'b0111111111110;
    assign E[9] =  13'b0111000000000;
    assign E[10] = 13'b0111000000000;
    assign E[11] = 13'b0111000000000;
    assign E[12] = 13'b0111111111110;
    assign E[13] = 13'b0111111111110;
    assign E[14] = 13'b0111111111110;

    wire [12:0] S [14:0];
    assign S[0] =  13'b0001111111110;
    assign S[1] =  13'b0011111111110;
    assign S[2] =  13'b0111111111110;
    assign S[3] =  13'b0111000000000;
    assign S[4] =  13'b0111000000000;
    assign S[5] =  13'b0111000000000;
    assign S[6] =  13'b0111111111000;
    assign S[7] =  13'b0011111111100;
    assign S[8] =  13'b0001111111110;
    assign S[9] =  13'b0000000001110;
    assign S[10] = 13'b0000000001110;
    assign S[11] = 13'b0000000001110;
    assign S[12] = 13'b0111111111110;
    assign S[13] = 13'b0111111111100;
    assign S[14] = 13'b0111111111000;

    wire [12:0] N [14:0];
    assign N[0] =  13'b0111000001110;
    assign N[1] =  13'b0111100001110;
    assign N[2] =  13'b0111100001110;
    assign N[3] =  13'b0111110001110;
    assign N[4] =  13'b0111110001110;
    assign N[5] =  13'b0111111001110;
    assign N[6] =  13'b0111111001110;
    assign N[7] =  13'b0111011101110;
    assign N[8] =  13'b0111001111110;
    assign N[9] =  13'b0111001111110;
    assign N[10] = 13'b0111000111110;
    assign N[11] = 13'b0111000111110;
    assign N[12] = 13'b0111000011110;
    assign N[13] = 13'b0111000011110;
    assign N[14] = 13'b0111000001110;

    wire [12:0] T [14:0];
    assign T[0] =  13'b0111111111110;
    assign T[1] =  13'b0111111111110;
    assign T[2] =  13'b0111111111110;
    assign T[3] =  13'b0000011100000;
    assign T[4] =  13'b0000011100000;
    assign T[5] =  13'b0000011100000;
    assign T[6] =  13'b0000011100000;
    assign T[7] =  13'b0000011100000;
    assign T[8] =  13'b0000011100000;
    assign T[9] =  13'b0000011100000;
    assign T[10] = 13'b0000011100000;
    assign T[11] = 13'b0000011100000;
    assign T[12] = 13'b0000011100000;
    assign T[13] = 13'b0000011100000;
    assign T[14] = 13'b0000011100000;

    wire [12:0] L [14:0];
    assign L[0] =  13'b0111000000000;
    assign L[1] =  13'b0111000000000;
    assign L[2] =  13'b0111000000000;
    assign L[3] =  13'b0111000000000;
    assign L[4] =  13'b0111000000000;
    assign L[5] =  13'b0111000000000;
    assign L[6] =  13'b0111000000000;
    assign L[7] =  13'b0111000000000;
    assign L[8] =  13'b0111000000000;
    assign L[9] =  13'b0111000000000;
    assign L[10] = 13'b0111000000000;
    assign L[11] = 13'b0111000000000;
    assign L[12] = 13'b0111111111110;
    assign L[13] = 13'b0111111111110;
    assign L[14] = 13'b0111111111110;

    wire [12:0] I [14:0];
    assign I[0] =  13'b0111111111110;
    assign I[1] =  13'b0111111111110;
    assign I[2] =  13'b0111111111110;
    assign I[3] =  13'b0000011100000;
    assign I[4] =  13'b0000011100000;
    assign I[5] =  13'b0000011100000;
    assign I[6] =  13'b0000011100000;
    assign I[7] =  13'b0000011100000;
    assign I[8] =  13'b0000011100000;
    assign I[9] =  13'b0000011100000;
    assign I[10] = 13'b0000011100000;
    assign I[11] = 13'b0000011100000;
    assign I[12] = 13'b0111111111110;
    assign I[13] = 13'b0111111111110;
    assign I[14] = 13'b0111111111110;

    wire [12:0] M [14:0];
    assign M[0] =  13'b0111000001110;
    assign M[1] =  13'b0111100011110;
    assign M[2] =  13'b0111100011110;
    assign M[3] =  13'b0111110111110;
    assign M[4] =  13'b0111111111110;
    assign M[5] =  13'b0111111111110;
    assign M[6] =  13'b0111111111110;
    assign M[7] =  13'b0111111111110;
    assign M[8] =  13'b0111011101110;
    assign M[9] =  13'b0111011101110;
    assign M[10] = 13'b0111011101110;
    assign M[11] = 13'b0111011101110;
    assign M[12] = 13'b0111011101110;
    assign M[13] = 13'b0111011101110;
    assign M[14] = 13'b0111011101110;

    wire [12:0] U [14:0];
    assign U[0] =  13'b0111000001110;
    assign U[1] =  13'b0111000001110;
    assign U[2] =  13'b0111000001110;
    assign U[3] =  13'b0111000001110;
    assign U[4] =  13'b0111000001110;
    assign U[5] =  13'b0111000001110;
    assign U[6] =  13'b0111000001110;
    assign U[7] =  13'b0111000001110;
    assign U[8] =  13'b0111000001110;
    assign U[9] =  13'b0111000001110;
    assign U[10] = 13'b0111000001110;
    assign U[11] = 13'b0111100011110;
    assign U[12] = 13'b0011111111100;
    assign U[13] = 13'b0001111111000;
    assign U[14] = 13'b0000111110000;

    wire [12:0] J [14:0];
    assign J[0] =  13'b0111111111110;
    assign J[1] =  13'b0111111111110;
    assign J[2] =  13'b0111111111110;
    assign J[3] =  13'b0000011100000;
    assign J[4] =  13'b0000011100000;
    assign J[5] =  13'b0000011100000;
    assign J[6] =  13'b0000011100000;
    assign J[7] =  13'b0000011100000;
    assign J[8] =  13'b0000011100000;
    assign J[9] =  13'b0000011100000;
    assign J[10] = 13'b0000011100000;
    assign J[11] = 13'b0000011100000;
    assign J[12] = 13'b0111111100000;
    assign J[13] = 13'b0111111100000;
    assign J[14] = 13'b0111110000000;

    wire [12:0] C [14:0];
    assign C[0] =  13'b0000111111000;
    assign C[1] =  13'b0001111111100;
    assign C[2] =  13'b0011111111110;
    assign C[3] =  13'b0111110011110;
    assign C[4] =  13'b0111100001110;
    assign C[5] =  13'b0111000000000;
    assign C[6] =  13'b0111000000000;
    assign C[7] =  13'b0111000000000;
    assign C[8] =  13'b0111000000000;
    assign C[9] =  13'b0111000000000;
    assign C[10] = 13'b0111100001110;
    assign C[11] = 13'b0111110011110;
    assign C[12] = 13'b0011111111110;
    assign C[13] = 13'b0001111111100;
    assign C[14] = 13'b0000111111000;

    wire [12:0] O [14:0];
    assign O[0] =  13'b0000111110000;
    assign O[1] =  13'b0001111111000;
    assign O[2] =  13'b0011111111100;
    assign O[3] =  13'b0111110111110;
    assign O[4] =  13'b0111100011110;
    assign O[5] =  13'b0111000001110;
    assign O[6] =  13'b0111000001110;
    assign O[7] =  13'b0111000001110;
    assign O[8] =  13'b0111000001110;
    assign O[9] =  13'b0111000001110;
    assign O[10] = 13'b0111100011110;
    assign O[11] = 13'b0111110111110;
    assign O[12] = 13'b0011111111100;
    assign O[13] = 13'b0001111111000;
    assign O[14] = 13'b0000111110000;

    wire [12:0] A [14:0];
    assign A[0] =  13'b0000011100000;
    assign A[1] =  13'b0000111110000;
    assign A[2] =  13'b0000111110000;
    assign A[3] =  13'b0001111111000;
    assign A[4] =  13'b0001110111000;
    assign A[5] =  13'b0011100011100;
    assign A[6] =  13'b0011100011100;
    assign A[7] =  13'b0011000001100;
    assign A[8] =  13'b0111000001110;
    assign A[9] =  13'b0111000001110;
    assign A[10] = 13'b0111111111110;
    assign A[11] = 13'b0111111111110;
    assign A[12] = 13'b0111111111110;
    assign A[13] = 13'b0111000001110;
    assign A[14] = 13'b0111000001110;

    wire [12:0] H [14:0];
    assign H[0] =  13'b0111000001110;
    assign H[1] =  13'b0111000001110;
    assign H[2] =  13'b0111000001110;
    assign H[3] =  13'b0111000001110;
    assign H[4] =  13'b0111000001110;
    assign H[5] =  13'b0111000001110;
    assign H[6] =  13'b0111111111110;
    assign H[7] =  13'b0111111111110;
    assign H[8] =  13'b0111111111110;
    assign H[9] =  13'b0111000001110;
    assign H[10] = 13'b0111000001110;
    assign H[11] = 13'b0111000001110;
    assign H[12] = 13'b0111000001110;
    assign H[13] = 13'b0111000001110;
    assign H[14] = 13'b0111000001110;

    wire [12:0] G [14:0];
    assign G[0] =  13'b0000111111000;
    assign G[1] =  13'b0001111111100;
    assign G[2] =  13'b0011111111110;
    assign G[3] =  13'b0111110011110;
    assign G[4] =  13'b0111100001110;
    assign G[5] =  13'b0111000000000;
    assign G[6] =  13'b0111000000000;
    assign G[7] =  13'b0111000111110;
    assign G[8] =  13'b0111000111110;
    assign G[9] =  13'b0111000111110;
    assign G[10] = 13'b0111100001110;
    assign G[11] = 13'b0111110011110;
    assign G[12] = 13'b0011111111110;
    assign G[13] = 13'b0001111111100;
    assign G[14] = 13'b0000111111000;

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
   
    always @(*) begin
        if (!valid) {vgaRed, vgaGreen, vgaBlue} = 12'h000;
        else begin
            //slime jump
            if(h_cnt >= 10'd265 && h_cnt < 10'd278 && v_cnt >= 10'd120 && v_cnt < 10'd135)begin
                if (S[v_cnt - 10'd120][10'd12 - (h_cnt - 10'd265)]) {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
                else {vgaRed, vgaGreen, vgaBlue} = 12'h000;
            end
            else if(h_cnt >= 10'd278 && h_cnt < 10'd291 && v_cnt >= 10'd120 && v_cnt < 10'd135)begin
                if (L[v_cnt - 10'd120][10'd12 - (h_cnt - 10'd278)]) {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
                else {vgaRed, vgaGreen, vgaBlue} = 12'h000;
            end
            else if(h_cnt >= 10'd291 && h_cnt < 10'd304 && v_cnt >= 10'd120 && v_cnt < 10'd135)begin
                if (I[v_cnt - 10'd120][10'd12 - (h_cnt - 10'd291)]) {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
                else {vgaRed, vgaGreen, vgaBlue} = 12'h000;
            end
            else if(h_cnt >= 10'd304 && h_cnt < 10'd317 && v_cnt >= 10'd120 && v_cnt < 10'd135)begin
                if (M[v_cnt - 10'd120][10'd12 - (h_cnt - 10'd304)]) {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
                else {vgaRed, vgaGreen, vgaBlue} = 12'h000;
            end
            else if(h_cnt >= 10'd317 && h_cnt < 10'd330 && v_cnt >= 10'd120 && v_cnt < 10'd135)begin
                if (E[v_cnt - 10'd120][10'd12 - (h_cnt - 10'd317)]) {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
                else {vgaRed, vgaGreen, vgaBlue} = 12'h000;
            end
            else if(h_cnt >= 10'd343 && h_cnt < 10'd356 && v_cnt >= 10'd120 && v_cnt < 10'd135)begin
                if (J[v_cnt - 10'd120][10'd12 - (h_cnt - 10'd343)]) {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
                else {vgaRed, vgaGreen, vgaBlue} = 12'h000;
            end
            else if(h_cnt >= 10'd356 && h_cnt < 10'd369 && v_cnt >= 10'd120 && v_cnt < 10'd135)begin
                if (U[v_cnt - 10'd120][10'd12 - (h_cnt - 10'd356)]) {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
                else {vgaRed, vgaGreen, vgaBlue} = 12'h000;
            end
            else if(h_cnt >= 10'd369 && h_cnt < 10'd382 && v_cnt >= 10'd120 && v_cnt < 10'd135)begin
                if (M[v_cnt - 10'd120][10'd12 - (h_cnt - 10'd369)]) {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
                else {vgaRed, vgaGreen, vgaBlue} = 12'h000;
            end
            else if(h_cnt >= 10'd382 && h_cnt < 10'd395 && v_cnt >= 10'd120 && v_cnt < 10'd135)begin
                if (P[v_cnt - 10'd120][10'd12 - (h_cnt - 10'd382)]) {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
                else {vgaRed, vgaGreen, vgaBlue} = 12'h000;
            end

            //last score
            else if(h_cnt >= 10'd230 && h_cnt < 10'd243 && v_cnt >= 10'd200 && v_cnt < 10'd215)begin
                if (L[v_cnt - 10'd200][10'd12 - (h_cnt - 10'd230)]) {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
                else {vgaRed, vgaGreen, vgaBlue} = 12'h000;
            end
            else if(h_cnt >= 10'd243 && h_cnt < 10'd256 && v_cnt >= 10'd200 && v_cnt < 10'd215)begin
                if (A[v_cnt - 10'd200][10'd12 - (h_cnt - 10'd243)]) {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
                else {vgaRed, vgaGreen, vgaBlue} = 12'h000;
            end
            else if(h_cnt >= 10'd256 && h_cnt < 10'd269 && v_cnt >= 10'd200 && v_cnt < 10'd215)begin
                if (S[v_cnt - 10'd200][10'd12 - (h_cnt - 10'd256)]) {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
                else {vgaRed, vgaGreen, vgaBlue} = 12'h000;
            end
            else if(h_cnt >= 10'd269 && h_cnt < 10'd282 && v_cnt >= 10'd200 && v_cnt < 10'd215)begin
                if (T[v_cnt - 10'd200][10'd12 - (h_cnt - 10'd269)]) {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
                else {vgaRed, vgaGreen, vgaBlue} = 12'h000;
            end
            else if(h_cnt >= 10'd295 && h_cnt < 10'd308 && v_cnt >= 10'd200 && v_cnt < 10'd215)begin
                if (S[v_cnt - 10'd200][10'd12 - (h_cnt - 10'd295)]) {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
                else {vgaRed, vgaGreen, vgaBlue} = 12'h000;
            end
            else if(h_cnt >= 10'd308 && h_cnt < 10'd321 && v_cnt >= 10'd200 && v_cnt < 10'd215)begin
                if (C[v_cnt - 10'd200][10'd12 - (h_cnt - 10'd308)]) {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
                else {vgaRed, vgaGreen, vgaBlue} = 12'h000;
            end
            else if(h_cnt >= 10'd321 && h_cnt < 10'd334 && v_cnt >= 10'd200 && v_cnt < 10'd215)begin
                if (O[v_cnt - 10'd200][10'd12 - (h_cnt - 10'd321)]) {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
                else {vgaRed, vgaGreen, vgaBlue} = 12'h000;
            end
            else if(h_cnt >= 10'd334 && h_cnt < 10'd347 && v_cnt >= 10'd200 && v_cnt < 10'd215)begin
                if (R[v_cnt - 10'd200][10'd12 - (h_cnt - 10'd334)]) {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
                else {vgaRed, vgaGreen, vgaBlue} = 12'h000;
            end
            else if(h_cnt >= 10'd347 && h_cnt < 10'd360 && v_cnt >= 10'd200 && v_cnt < 10'd215)begin
                if (E[v_cnt - 10'd200][10'd12 - (h_cnt - 10'd347)]) {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
                else {vgaRed, vgaGreen, vgaBlue} = 12'h000;
            end
            else if(h_cnt >= 10'd390 && h_cnt < 10'd410 && v_cnt >= 10'd198 && v_cnt < 10'd218)begin
                if(h_cnt < 10'd390 + 10'd10)begin
                    case(last_score_1)
                        4'd0:    {vgaRed, vgaGreen, vgaBlue} = (num_0[10'd19 - (v_cnt - 10'd198)][10'd9 - (h_cnt - 10'd390)]) ? 12'hfff : 12'h000;
                        4'd1:    {vgaRed, vgaGreen, vgaBlue} = (num_1[10'd19 - (v_cnt - 10'd198)][10'd9 - (h_cnt - 10'd390)]) ? 12'hfff : 12'h000;
                        4'd2:    {vgaRed, vgaGreen, vgaBlue} = (num_2[10'd19 - (v_cnt - 10'd198)][10'd9 - (h_cnt - 10'd390)]) ? 12'hfff : 12'h000;
                        4'd3:    {vgaRed, vgaGreen, vgaBlue} = (num_3[10'd19 - (v_cnt - 10'd198)][10'd9 - (h_cnt - 10'd390)]) ? 12'hfff : 12'h000;
                        4'd4:    {vgaRed, vgaGreen, vgaBlue} = (num_4[10'd19 - (v_cnt - 10'd198)][10'd9 - (h_cnt - 10'd390)]) ? 12'hfff : 12'h000;
                        4'd5:    {vgaRed, vgaGreen, vgaBlue} = (num_5[10'd19 - (v_cnt - 10'd198)][10'd9 - (h_cnt - 10'd390)]) ? 12'hfff : 12'h000;
                        4'd6:    {vgaRed, vgaGreen, vgaBlue} = (num_6[10'd19 - (v_cnt - 10'd198)][10'd9 - (h_cnt - 10'd390)]) ? 12'hfff : 12'h000;
                        4'd7:    {vgaRed, vgaGreen, vgaBlue} = (num_7[10'd19 - (v_cnt - 10'd198)][10'd9 - (h_cnt - 10'd390)]) ? 12'hfff : 12'h000;
                        4'd8:    {vgaRed, vgaGreen, vgaBlue} = (num_8[10'd19 - (v_cnt - 10'd198)][10'd9 - (h_cnt - 10'd390)]) ? 12'hfff : 12'h000;
                        default:    {vgaRed, vgaGreen, vgaBlue} = (num_9[10'd19 - (v_cnt - 10'd198)][10'd9 - (h_cnt - 10'd390)]) ? 12'hfff : 12'h000;
                    endcase
                end
                else begin
                    case(last_score_0)
                        4'd0:    {vgaRed, vgaGreen, vgaBlue} = (num_0[10'd19 - (v_cnt - 10'd198)][10'd9 - (h_cnt - 10'd400)]) ? 12'hfff : 12'h000;
                        4'd1:    {vgaRed, vgaGreen, vgaBlue} = (num_1[10'd19 - (v_cnt - 10'd198)][10'd9 - (h_cnt - 10'd400)]) ? 12'hfff : 12'h000;
                        4'd2:    {vgaRed, vgaGreen, vgaBlue} = (num_2[10'd19 - (v_cnt - 10'd198)][10'd9 - (h_cnt - 10'd400)]) ? 12'hfff : 12'h000;
                        4'd3:    {vgaRed, vgaGreen, vgaBlue} = (num_3[10'd19 - (v_cnt - 10'd198)][10'd9 - (h_cnt - 10'd400)]) ? 12'hfff : 12'h000;
                        4'd4:    {vgaRed, vgaGreen, vgaBlue} = (num_4[10'd19 - (v_cnt - 10'd198)][10'd9 - (h_cnt - 10'd400)]) ? 12'hfff : 12'h000;
                        4'd5:    {vgaRed, vgaGreen, vgaBlue} = (num_5[10'd19 - (v_cnt - 10'd198)][10'd9 - (h_cnt - 10'd400)]) ? 12'hfff : 12'h000;
                        4'd6:    {vgaRed, vgaGreen, vgaBlue} = (num_6[10'd19 - (v_cnt - 10'd198)][10'd9 - (h_cnt - 10'd400)]) ? 12'hfff : 12'h000;
                        4'd7:    {vgaRed, vgaGreen, vgaBlue} = (num_7[10'd19 - (v_cnt - 10'd198)][10'd9 - (h_cnt - 10'd400)]) ? 12'hfff : 12'h000;
                        4'd8:    {vgaRed, vgaGreen, vgaBlue} = (num_8[10'd19 - (v_cnt - 10'd198)][10'd9 - (h_cnt - 10'd400)]) ? 12'hfff : 12'h000;
                        default:    {vgaRed, vgaGreen, vgaBlue} = (num_9[10'd19 - (v_cnt - 10'd198)][10'd9 - (h_cnt - 10'd400)]) ? 12'hfff : 12'h000;
                    endcase
                end
            end

            //highest score
            else if(h_cnt >= 10'd230 && h_cnt < 10'd243 && v_cnt >= 10'd175 && v_cnt < 10'd190)begin
                if (H[v_cnt - 10'd175][10'd12 - (h_cnt - 10'd230)]) {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
                else {vgaRed, vgaGreen, vgaBlue} = 12'h000;
            end
            else if(h_cnt >= 10'd243 && h_cnt < 10'd256 && v_cnt >= 10'd175 && v_cnt < 10'd190)begin
                if (I[v_cnt - 10'd175][10'd12 - (h_cnt - 10'd243)]) {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
                else {vgaRed, vgaGreen, vgaBlue} = 12'h000;
            end
            else if(h_cnt >= 10'd256 && h_cnt < 10'd269 && v_cnt >= 10'd175 && v_cnt < 10'd190)begin
                if (G[v_cnt - 10'd175][10'd12 - (h_cnt - 10'd256)]) {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
                else {vgaRed, vgaGreen, vgaBlue} = 12'h000;
            end
            else if(h_cnt >= 10'd269 && h_cnt < 10'd282 && v_cnt >= 10'd175 && v_cnt < 10'd190)begin
                if (H[v_cnt - 10'd175][10'd12 - (h_cnt - 10'd269)]) {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
                else {vgaRed, vgaGreen, vgaBlue} = 12'h000;
            end
            else if(h_cnt >= 10'd282 && h_cnt < 10'd295 && v_cnt >= 10'd175 && v_cnt < 10'd190)begin
                if (E[v_cnt - 10'd175][10'd12 - (h_cnt - 10'd282)]) {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
                else {vgaRed, vgaGreen, vgaBlue} = 12'h000;
            end
            else if(h_cnt >= 10'd295 && h_cnt < 10'd308 && v_cnt >= 10'd175 && v_cnt < 10'd190)begin
                if (S[v_cnt - 10'd175][10'd12 - (h_cnt - 10'd295)]) {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
                else {vgaRed, vgaGreen, vgaBlue} = 12'h000;
            end
            else if(h_cnt >= 10'd308 && h_cnt < 10'd321 && v_cnt >= 10'd175 && v_cnt < 10'd190)begin
                if (T[v_cnt - 10'd175][10'd12 - (h_cnt - 10'd308)]) {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
                else {vgaRed, vgaGreen, vgaBlue} = 12'h000;
            end
            else if(h_cnt >= 10'd334 && h_cnt < 10'd347 &&v_cnt >= 10'd175 && v_cnt < 10'd190)begin
                if (S[v_cnt - 10'd175][10'd12 - (h_cnt - 10'd334)]) {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
                else {vgaRed, vgaGreen, vgaBlue} = 12'h000;
            end
            else if(h_cnt >= 10'd347 && h_cnt < 10'd360 && v_cnt >= 10'd175 && v_cnt < 10'd190)begin
                if (C[v_cnt - 10'd175][10'd12 - (h_cnt - 10'd347)]) {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
                else {vgaRed, vgaGreen, vgaBlue} = 12'h000;
            end
            else if(h_cnt >= 10'd360 && h_cnt < 10'd373 &&v_cnt >= 10'd175 && v_cnt < 10'd190)begin
                if (O[v_cnt - 10'd175][10'd12 - (h_cnt - 10'd360)]) {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
                else {vgaRed, vgaGreen, vgaBlue} = 12'h000;
            end
            else if(h_cnt >= 10'd373 && h_cnt < 10'd386 && v_cnt >= 10'd175 && v_cnt < 10'd190)begin
                if (R[v_cnt - 10'd175][10'd12 - (h_cnt - 10'd373)]) {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
                else {vgaRed, vgaGreen, vgaBlue} = 12'h000;
            end
            else if(h_cnt >= 10'd386 && h_cnt < 10'd399 && v_cnt >= 10'd175 && v_cnt < 10'd190)begin
                if (E[v_cnt - 10'd175][10'd12 - (h_cnt - 10'd386)]) {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
                else {vgaRed, vgaGreen, vgaBlue} = 12'h000;
            end
            else if(h_cnt >= 10'd429 && h_cnt < 10'd449 && v_cnt >= 10'd173 && v_cnt < 10'd193)begin
                if(h_cnt < 10'd429 + 10'd10)begin
                    case(highest_score_1)
                        4'd0:    {vgaRed, vgaGreen, vgaBlue} = (num_0[10'd19 - (v_cnt - 10'd173)][10'd9 - (h_cnt - 10'd429)]) ? 12'hfff : 12'h000;
                        4'd1:    {vgaRed, vgaGreen, vgaBlue} = (num_1[10'd19 - (v_cnt - 10'd173)][10'd9 - (h_cnt - 10'd429)]) ? 12'hfff : 12'h000;
                        4'd2:    {vgaRed, vgaGreen, vgaBlue} = (num_2[10'd19 - (v_cnt - 10'd173)][10'd9 - (h_cnt - 10'd429)]) ? 12'hfff : 12'h000;
                        4'd3:    {vgaRed, vgaGreen, vgaBlue} = (num_3[10'd19 - (v_cnt - 10'd173)][10'd9 - (h_cnt - 10'd429)]) ? 12'hfff : 12'h000;
                        4'd4:    {vgaRed, vgaGreen, vgaBlue} = (num_4[10'd19 - (v_cnt - 10'd173)][10'd9 - (h_cnt - 10'd429)]) ? 12'hfff : 12'h000;
                        4'd5:    {vgaRed, vgaGreen, vgaBlue} = (num_5[10'd19 - (v_cnt - 10'd173)][10'd9 - (h_cnt - 10'd429)]) ? 12'hfff : 12'h000;
                        4'd6:    {vgaRed, vgaGreen, vgaBlue} = (num_6[10'd19 - (v_cnt - 10'd173)][10'd9 - (h_cnt - 10'd429)]) ? 12'hfff : 12'h000;
                        4'd7:    {vgaRed, vgaGreen, vgaBlue} = (num_7[10'd19 - (v_cnt - 10'd173)][10'd9 - (h_cnt - 10'd429)]) ? 12'hfff : 12'h000;
                        4'd8:    {vgaRed, vgaGreen, vgaBlue} = (num_8[10'd19 - (v_cnt - 10'd173)][10'd9 - (h_cnt - 10'd429)]) ? 12'hfff : 12'h000;
                        default:    {vgaRed, vgaGreen, vgaBlue} = (num_9[10'd19 - (v_cnt - 10'd173)][10'd9 - (h_cnt - 10'd429)]) ? 12'hfff : 12'h000;
                    endcase
                end
                else begin
                    case(highest_score_0)
                        4'd0:    {vgaRed, vgaGreen, vgaBlue} = (num_0[10'd19 - (v_cnt - 10'd173)][10'd9 - (h_cnt - 10'd439)]) ? 12'hfff : 12'h000;
                        4'd1:    {vgaRed, vgaGreen, vgaBlue} = (num_1[10'd19 - (v_cnt - 10'd173)][10'd9 - (h_cnt - 10'd439)]) ? 12'hfff : 12'h000;
                        4'd2:    {vgaRed, vgaGreen, vgaBlue} = (num_2[10'd19 - (v_cnt - 10'd173)][10'd9 - (h_cnt - 10'd439)]) ? 12'hfff : 12'h000;
                        4'd3:    {vgaRed, vgaGreen, vgaBlue} = (num_3[10'd19 - (v_cnt - 10'd173)][10'd9 - (h_cnt - 10'd439)]) ? 12'hfff : 12'h000;
                        4'd4:    {vgaRed, vgaGreen, vgaBlue} = (num_4[10'd19 - (v_cnt - 10'd173)][10'd9 - (h_cnt - 10'd439)]) ? 12'hfff : 12'h000;
                        4'd5:    {vgaRed, vgaGreen, vgaBlue} = (num_5[10'd19 - (v_cnt - 10'd173)][10'd9 - (h_cnt - 10'd439)]) ? 12'hfff : 12'h000;
                        4'd6:    {vgaRed, vgaGreen, vgaBlue} = (num_6[10'd19 - (v_cnt - 10'd173)][10'd9 - (h_cnt - 10'd439)]) ? 12'hfff : 12'h000;
                        4'd7:    {vgaRed, vgaGreen, vgaBlue} = (num_7[10'd19 - (v_cnt - 10'd173)][10'd9 - (h_cnt - 10'd439)]) ? 12'hfff : 12'h000;
                        4'd8:    {vgaRed, vgaGreen, vgaBlue} = (num_8[10'd19 - (v_cnt - 10'd173)][10'd9 - (h_cnt - 10'd439)]) ? 12'hfff : 12'h000;
                        default:    {vgaRed, vgaGreen, vgaBlue} = (num_9[10'd19 - (v_cnt - 10'd173)][10'd9 - (h_cnt - 10'd439)]) ? 12'hfff : 12'h000;
                    endcase
                end
            end

            //press enter
            else if(h_cnt >= 10'd260 && h_cnt < 10'd273 && v_cnt >= 10'd360 && v_cnt < 10'd375)begin
                if (P[v_cnt - 10'd360][10'd12 - (h_cnt - 10'd260)] && clk_bling) {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
                else {vgaRed, vgaGreen, vgaBlue} = 12'h000;
            end
            else if(h_cnt >= 10'd273 && h_cnt < 10'd286 && v_cnt >= 10'd360 && v_cnt < 10'd375)begin
                if (R[v_cnt - 10'd360][10'd12 - (h_cnt - 10'd273)] && clk_bling) {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
                else {vgaRed, vgaGreen, vgaBlue} = 12'h000;
            end
            else if(h_cnt >= 10'd286 && h_cnt < 10'd299 && v_cnt >= 10'd360 && v_cnt < 10'd375)begin
                if (E[v_cnt - 10'd360][10'd12 - (h_cnt - 10'd286)] && clk_bling) {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
                else {vgaRed, vgaGreen, vgaBlue} = 12'h000;
            end
            else if(h_cnt >= 10'd299 && h_cnt < 10'd312 && v_cnt >= 10'd360 && v_cnt < 10'd375)begin
                if (S[v_cnt - 10'd360][10'd12 - (h_cnt - 10'd299)] && clk_bling) {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
                else {vgaRed, vgaGreen, vgaBlue} = 12'h000;
            end
            else if(h_cnt >= 10'd312 && h_cnt < 10'd325 && v_cnt >= 10'd360 && v_cnt < 10'd375)begin
                if (S[v_cnt - 10'd360][10'd12 - (h_cnt - 10'd312)] && clk_bling) {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
                else {vgaRed, vgaGreen, vgaBlue} = 12'h000;
            end
            else if(h_cnt >= 10'd338 && h_cnt < 10'd351 && v_cnt >= 10'd360 && v_cnt < 10'd375)begin
                if (E[v_cnt - 10'd360][10'd12 - (h_cnt - 10'd338)] && clk_bling) {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
                else {vgaRed, vgaGreen, vgaBlue} = 12'h000;
            end
            else if(h_cnt >= 10'd351 && h_cnt < 10'd364 && v_cnt >= 10'd360 && v_cnt < 10'd375)begin
                if (N[v_cnt - 10'd360][10'd12 - (h_cnt - 10'd351)] && clk_bling) {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
                else {vgaRed, vgaGreen, vgaBlue} = 12'h000;
            end
            else if(h_cnt >= 10'd364 && h_cnt < 10'd377 && v_cnt >= 10'd360 && v_cnt < 10'd375)begin
                if (T[v_cnt - 10'd360][10'd12 - (h_cnt - 10'd364)] && clk_bling) {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
                else {vgaRed, vgaGreen, vgaBlue} = 12'h000;
            end
            else if(h_cnt >= 10'd377 && h_cnt < 10'd390 && v_cnt >= 10'd360 && v_cnt < 10'd375)begin
                if (E[v_cnt - 10'd360][10'd12 - (h_cnt - 10'd377)] && clk_bling) {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
                else {vgaRed, vgaGreen, vgaBlue} = 12'h000;
            end
            else if(h_cnt >= 10'd390 && h_cnt < 10'd403 && v_cnt >= 10'd360 && v_cnt < 10'd375)begin
                if (R[v_cnt - 10'd360][10'd12 - (h_cnt - 10'd390)] && clk_bling) {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
                else {vgaRed, vgaGreen, vgaBlue} = 12'h000;
            end

            else {vgaRed, vgaGreen, vgaBlue} = 12'h000;
        end
    end

endmodule