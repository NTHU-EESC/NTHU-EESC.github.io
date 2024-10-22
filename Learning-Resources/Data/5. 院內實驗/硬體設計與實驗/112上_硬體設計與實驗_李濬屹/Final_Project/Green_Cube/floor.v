module floor_gen(clk, clk_floor, clk_vga, rst, 
floor_pos_x0, floor_pos_y0, floor_pos_x1, floor_pos_y1, 
floor_pos_x2, floor_pos_y2, floor_pos_x3, floor_pos_y3, 
floor_pos_x4, floor_pos_y4, floor_pos_x5, floor_pos_y5, 
floor_pos_x6, floor_pos_y6, floor_pos_x7, floor_pos_y7, 
enable, time_gap, hit_ceiling);

    input clk, rst, hit_ceiling, clk_floor, clk_vga;
    input [8:0] time_gap;
    output reg [9:0] floor_pos_x0, floor_pos_y0, floor_pos_x1, floor_pos_y1, floor_pos_x2, floor_pos_y2, floor_pos_x3, floor_pos_y3;
    output reg [9:0] floor_pos_x4, floor_pos_y4, floor_pos_x5, floor_pos_y5, floor_pos_x6, floor_pos_y6, floor_pos_x7, floor_pos_y7;
    output reg [7:0] enable;

    reg [9:0] next_floor_pos_x0, next_floor_pos_y0, next_floor_pos_x1, next_floor_pos_y1;
    reg [9:0] next_floor_pos_x2, next_floor_pos_y2, next_floor_pos_x3, next_floor_pos_y3;
    reg [9:0] next_floor_pos_x4, next_floor_pos_y4, next_floor_pos_x5, next_floor_pos_y5;
    reg [9:0] next_floor_pos_x6, next_floor_pos_y6, next_floor_pos_x7, next_floor_pos_y7;
    reg [9:0] next_floor_pos_x, next_floor_pos_y;
    reg [9:0] tmp_floor_pos_y0, tmp_floor_pos_y1, tmp_floor_pos_y2, tmp_floor_pos_y3;
    reg [9:0] tmp_floor_pos_y4, tmp_floor_pos_y5, tmp_floor_pos_y6, tmp_floor_pos_y7;
    reg [9:0] tmp_floor_pos_x0, tmp_floor_pos_x1, tmp_floor_pos_x2, tmp_floor_pos_x3;
    reg [9:0] tmp_floor_pos_x4, tmp_floor_pos_x5, tmp_floor_pos_x6, tmp_floor_pos_x7;

    wire [9:0] random_x_pos;
    wire [3:0] random_x;
    reg [4:0] random_x_counter;

    assign random_x = random_x_counter[3:0];
    assign random_x_pos = random_x * 10'd40;

    always @ (posedge clk) begin
        if (rst) random_x_counter <= 5'd0; 
        else if(clk) random_x_counter <= random_x_counter > 5'd29 ? 5'd0 : random_x_counter + 1;
        else random_x_counter <= random_x_counter;
    end


    always @ (posedge clk) begin
        if (rst) begin
            enable <= 8'b11111111;

            floor_pos_x0 <= 10'd150;
            floor_pos_x1 <= 10'd300;
            floor_pos_x2 <= 10'd450;
            floor_pos_x3 <= 10'd600;
            floor_pos_x4 <= 10'd150;
            floor_pos_x5 <= 10'd600;
            floor_pos_x6 <= 10'd450;
            floor_pos_x7 <= 10'd300;

            tmp_floor_pos_x0 <= 10'd150;
            tmp_floor_pos_x1 <= 10'd300;
            tmp_floor_pos_x2 <= 10'd450;
            tmp_floor_pos_x3 <= 10'd600;
            tmp_floor_pos_x4 <= 10'd150;
            tmp_floor_pos_x5 <= 10'd600;
            tmp_floor_pos_x6 <= 10'd450;
            tmp_floor_pos_x7 <= 10'd300;

            floor_pos_y0 <= 10'd0;
            floor_pos_y1 <= 10'd60;
            floor_pos_y2 <= 10'd120;
            floor_pos_y3 <= 10'd180;
            floor_pos_y4 <= 10'd240;
            floor_pos_y5 <= 10'd300;
            floor_pos_y6 <= 10'd360;
            floor_pos_y7 <= 10'd420;

            tmp_floor_pos_y0 <= 10'd0;
            tmp_floor_pos_y1 <= 10'd60;
            tmp_floor_pos_y2 <= 10'd120;
            tmp_floor_pos_y3 <= 10'd180;
            tmp_floor_pos_y4 <= 10'd240;
            tmp_floor_pos_y5 <= 10'd300;
            tmp_floor_pos_y6 <= 10'd360;
            tmp_floor_pos_y7 <= 10'd420;

        end
        else if (clk_floor) begin
            enable <= 8'b11111111;

            {tmp_floor_pos_y0, tmp_floor_pos_y1, tmp_floor_pos_y2, tmp_floor_pos_y3, tmp_floor_pos_y4, tmp_floor_pos_y5, tmp_floor_pos_y6, tmp_floor_pos_y7} <= {tmp_floor_pos_y1, tmp_floor_pos_y2, tmp_floor_pos_y3, tmp_floor_pos_y4, tmp_floor_pos_y5, tmp_floor_pos_y6, tmp_floor_pos_y7, next_floor_pos_y};
            {tmp_floor_pos_x0, tmp_floor_pos_x1, tmp_floor_pos_x2, tmp_floor_pos_x3, tmp_floor_pos_x4, tmp_floor_pos_x5, tmp_floor_pos_x6, tmp_floor_pos_x7} <= {tmp_floor_pos_x1, tmp_floor_pos_x2, tmp_floor_pos_x3, tmp_floor_pos_x4, tmp_floor_pos_x5, tmp_floor_pos_x6, tmp_floor_pos_x7, next_floor_pos_x};
            /*
            floor_pos_y0 <= (clk_vga) ? tmp_floor_pos_y0 : floor_pos_y0;
            floor_pos_y1 <= (clk_vga) ? tmp_floor_pos_y1 : floor_pos_y1;
            floor_pos_y2 <= (clk_vga) ? tmp_floor_pos_y2 : floor_pos_y2;
            floor_pos_y3 <= (clk_vga) ? tmp_floor_pos_y3 : floor_pos_y3;
            floor_pos_y4 <= (clk_vga) ? tmp_floor_pos_y4 : floor_pos_y4;
            floor_pos_y5 <= (clk_vga) ? tmp_floor_pos_y5 : floor_pos_y5;
            floor_pos_y6 <= (clk_vga) ? tmp_floor_pos_y6 : floor_pos_y6;
            floor_pos_y7 <= (clk_vga) ? tmp_floor_pos_y7 : floor_pos_y7;
            */

            floor_pos_x0 <= (clk_vga) ? tmp_floor_pos_x1 : floor_pos_x0;
            floor_pos_x1 <= (clk_vga) ? tmp_floor_pos_x2 : floor_pos_x1;
            floor_pos_x2 <= (clk_vga) ? tmp_floor_pos_x3 : floor_pos_x2;
            floor_pos_x3 <= (clk_vga) ? tmp_floor_pos_x4 : floor_pos_x3;
            floor_pos_x4 <= (clk_vga) ? tmp_floor_pos_x5 : floor_pos_x4;
            floor_pos_x5 <= (clk_vga) ? tmp_floor_pos_x6 : floor_pos_x5;
            floor_pos_x6 <= (clk_vga) ? tmp_floor_pos_x7 : floor_pos_x6;
            floor_pos_x7 <= (clk_vga) ? tmp_floor_pos_x0 : floor_pos_x7;

            floor_pos_y0 <= (clk_vga) ? tmp_floor_pos_y1 : floor_pos_y0;
            floor_pos_y1 <= (clk_vga) ? tmp_floor_pos_y2 : floor_pos_y1;
            floor_pos_y2 <= (clk_vga) ? tmp_floor_pos_y3 : floor_pos_y2;
            floor_pos_y3 <= (clk_vga) ? tmp_floor_pos_y4 : floor_pos_y3;
            floor_pos_y4 <= (clk_vga) ? tmp_floor_pos_y5 : floor_pos_y4;
            floor_pos_y5 <= (clk_vga) ? tmp_floor_pos_y6 : floor_pos_y5;
            floor_pos_y6 <= (clk_vga) ? tmp_floor_pos_y7 : floor_pos_y6;
            floor_pos_y7 <= (clk_vga) ? tmp_floor_pos_y0 : floor_pos_y7;
            

        end
        else begin
            enable <= enable;
            
            floor_pos_x0 <= floor_pos_x0;
            floor_pos_x1 <= floor_pos_x1;
            floor_pos_x2 <= floor_pos_x2;
            floor_pos_x3 <= floor_pos_x3;
            floor_pos_x4 <= floor_pos_x4;
            floor_pos_x5 <= floor_pos_x5;
            floor_pos_x6 <= floor_pos_x6;
            floor_pos_x7 <= floor_pos_x7;

            tmp_floor_pos_x0 <= tmp_floor_pos_x0;
            tmp_floor_pos_x1 <= tmp_floor_pos_x1;
            tmp_floor_pos_x2 <= tmp_floor_pos_x2;
            tmp_floor_pos_x3 <= tmp_floor_pos_x3;
            tmp_floor_pos_x4 <= tmp_floor_pos_x4;
            tmp_floor_pos_x5 <= tmp_floor_pos_x5;
            tmp_floor_pos_x6 <= tmp_floor_pos_x6;
            tmp_floor_pos_x7 <= tmp_floor_pos_x7;

            floor_pos_y0 <= floor_pos_y0;
            floor_pos_y1 <= floor_pos_y1;
            floor_pos_y2 <= floor_pos_y2;
            floor_pos_y3 <= floor_pos_y3;
            floor_pos_y4 <= floor_pos_y4;
            floor_pos_y5 <= floor_pos_y5;
            floor_pos_y6 <= floor_pos_y6;
            floor_pos_y7 <= floor_pos_y7;

            tmp_floor_pos_y0 <= tmp_floor_pos_y0;
            tmp_floor_pos_y1 <= tmp_floor_pos_y1;
            tmp_floor_pos_y2 <= tmp_floor_pos_y2;
            tmp_floor_pos_y3 <= tmp_floor_pos_y3;
            tmp_floor_pos_y4 <= tmp_floor_pos_y4;
            tmp_floor_pos_y5 <= tmp_floor_pos_y5;
            tmp_floor_pos_y6 <= tmp_floor_pos_y6;
            tmp_floor_pos_y7 <= tmp_floor_pos_y7;

        end
    end

    always @ (*) begin
        if (hit_ceiling) begin
            if (time_gap > 9'd320) begin
                next_floor_pos_x = tmp_floor_pos_x0;
                next_floor_pos_y = tmp_floor_pos_y0;
                /*next_floor_pos_y0 = floor_pos_y0;
                next_floor_pos_y1 = floor_pos_y1;
                next_floor_pos_y2 = floor_pos_y2;
                next_floor_pos_y3 = floor_pos_y3;

                next_floor_pos_y4 = floor_pos_y4;
                next_floor_pos_y5 = floor_pos_y5;
                next_floor_pos_y6 = floor_pos_y6;
                next_floor_pos_y7 = floor_pos_y7;*/
            end
            else if(time_gap >= 9'd1 && time_gap < 9'd80)begin
                next_floor_pos_x = (tmp_floor_pos_y0 > 10'd479) ? random_x_pos/*random x*/ : tmp_floor_pos_x0;
                next_floor_pos_y = (tmp_floor_pos_y0 > 10'd479) ? 10'd0 : tmp_floor_pos_y0 + 10'd1;
                /*next_floor_pos_y0 = floor_pos_y0 + 10'd1;
                next_floor_pos_y1 = floor_pos_y1 + 10'd1;
                next_floor_pos_y2 = floor_pos_y2 + 10'd1;
                next_floor_pos_y3 = floor_pos_y3 + 10'd1;

                next_floor_pos_y4 = floor_pos_y4 + 10'd1;
                next_floor_pos_y5 = floor_pos_y5 + 10'd1;
                next_floor_pos_y6 = floor_pos_y6 + 10'd1;
                next_floor_pos_y7 = floor_pos_y7 + 10'd1;*/
            end
            else if(time_gap >= 9'd80 && time_gap < 9'd160)begin
                next_floor_pos_x = (tmp_floor_pos_y0 > 10'd479) ? random_x_pos/*random x*/ : tmp_floor_pos_x0;
                next_floor_pos_y = (time_gap[0] == 1'b0) ? ((tmp_floor_pos_y0 > 10'd479) ? 10'd0 : tmp_floor_pos_y0 + 10'd1) : tmp_floor_pos_y0;
                // next_floor_pos_y0 = (time_gap[0] == 1'b0) ? (/*(floor_pos_y0 > 10'd479) ? 10'd0 : */floor_pos_y0 + 10'd1) : floor_pos_y0;
                // next_floor_pos_y1 = (time_gap[0] == 1'b0) ? (/*(floor_pos_y1 > 10'd479) ? 10'd0 : */floor_pos_y1 + 10'd1) : floor_pos_y1;
                // next_floor_pos_y2 = (time_gap[0] == 1'b0) ? (/*(floor_pos_y2 > 10'd479) ? 10'd0 : */floor_pos_y2 + 10'd1) : floor_pos_y2;
                // next_floor_pos_y3 = (time_gap[0] == 1'b0) ? (/*(floor_pos_y3 > 10'd479) ? 10'd0 : */floor_pos_y3 + 10'd1) : floor_pos_y3;

                // next_floor_pos_y4 = (time_gap[0] == 1'b0) ? (/*(floor_pos_y4 > 10'd479) ? 10'd0 : */floor_pos_y4 + 10'd1) : floor_pos_y4;
                // next_floor_pos_y5 = (time_gap[0] == 1'b0) ? (/*(floor_pos_y5 > 10'd479) ? 10'd0 : */floor_pos_y5 + 10'd1) : floor_pos_y5;
                // next_floor_pos_y6 = (time_gap[0] == 1'b0) ? (/*floor_pos_y6 > 10'd479) ? 10'd0 : */floor_pos_y6 + 10'd1) : floor_pos_y6;
                // next_floor_pos_y7 = (time_gap[0] == 1'b0) ? (/*(floor_pos_y7 > 10'd479) ? 10'd0 : */floor_pos_y7 + 10'd1) : floor_pos_y7;
            end
            else if(time_gap >= 9'd160 && time_gap < 9'd240)begin
                next_floor_pos_x = (tmp_floor_pos_y0 > 10'd479) ? random_x_pos/*random x*/ : tmp_floor_pos_x0;
                next_floor_pos_y = (time_gap[1:0] == 2'b00) ? ((tmp_floor_pos_y0 > 10'd479) ? 10'd0 : tmp_floor_pos_y0 + 10'd1) : tmp_floor_pos_y0;
                // next_floor_pos_y0 = (time_gap[1:0] == 2'b00) ? (/*(floor_pos_y0 > 10'd479) ? 10'd0 : */floor_pos_y0 + 10'd1) : floor_pos_y0;
                // next_floor_pos_y1 = (time_gap[1:0] == 2'b00) ? (/*(floor_pos_y1 > 10'd479) ? 10'd0 : */floor_pos_y1 + 10'd1) : floor_pos_y1;
                // next_floor_pos_y2 = (time_gap[1:0] == 2'b00) ? (/*(floor_pos_y2 > 10'd479) ? 10'd0 : */floor_pos_y2 + 10'd1) : floor_pos_y2;
                // next_floor_pos_y3 = (time_gap[1:0] == 2'b00) ? (/*(floor_pos_y3 > 10'd479) ? 10'd0 : */floor_pos_y3 + 10'd1) : floor_pos_y3;

                // next_floor_pos_y4 = (time_gap[1:0] == 2'b00) ? (/*(floor_pos_y4 > 10'd479) ? 10'd0 : */floor_pos_y4 + 10'd1) : floor_pos_y4;
                // next_floor_pos_y5 = (time_gap[1:0] == 2'b00) ? (/*(floor_pos_y5 > 10'd479) ? 10'd0 : */floor_pos_y5 + 10'd1) : floor_pos_y5;
                // next_floor_pos_y6 = (time_gap[1:0] == 2'b00) ? (/*(floor_pos_y6 > 10'd479) ? 10'd0 : */floor_pos_y6 + 10'd1) : floor_pos_y6;
                // next_floor_pos_y7 = (time_gap[1:0] == 2'b00) ? (/*(floor_pos_y7 > 10'd479) ? 10'd0 : */floor_pos_y7 + 10'd1) : floor_pos_y7;
            end
            else if(time_gap >= 9'd240 && time_gap < 9'd320)begin
                next_floor_pos_x = (tmp_floor_pos_y0 > 10'd479) ? random_x_pos/*random x*/ : tmp_floor_pos_x0;
                next_floor_pos_y = (time_gap[2:0] == 3'b000) ? ((tmp_floor_pos_y0 > 10'd479) ? 10'd0 : tmp_floor_pos_y0 + 10'd1) : tmp_floor_pos_y0;
                // next_floor_pos_y0 = (time_gap[2:0] == 3'b000) ? (/*(floor_pos_y0 > 10'd479) ? 10'd0 : */floor_pos_y0 + 10'd1) : floor_pos_y0;
                // next_floor_pos_y1 = (time_gap[2:0] == 3'b000) ? (/*(floor_pos_y1 > 10'd479) ? 10'd0 : */floor_pos_y1 + 10'd1) : floor_pos_y1;
                // next_floor_pos_y2 = (time_gap[2:0] == 3'b000) ? (/*(floor_pos_y2 > 10'd479) ? 10'd0 : */floor_pos_y2 + 10'd1) : floor_pos_y2;
                // next_floor_pos_y3 = (time_gap[2:0] == 3'b000) ? (/*(floor_pos_y3 > 10'd479) ? 10'd0 : */floor_pos_y3 + 10'd1) : floor_pos_y3;

                // next_floor_pos_y4 = (time_gap[2:0] == 3'b000) ? (/*(floor_pos_y4 > 10'd479) ? 10'd0 : */floor_pos_y4 + 10'd1) : floor_pos_y4;
                // next_floor_pos_y5 = (time_gap[2:0] == 3'b000) ? (/*(floor_pos_y5 > 10'd479) ? 10'd0 : */floor_pos_y5 + 10'd1) : floor_pos_y5;
                // next_floor_pos_y6 = (time_gap[2:0] == 3'b000) ? (/*(floor_pos_y6 > 10'd479) ? 10'd0 : */floor_pos_y6 + 10'd1) : floor_pos_y6;
                // next_floor_pos_y7 = (time_gap[2:0] == 3'b000) ? (/*(floor_pos_y7 > 10'd479) ? 10'd0 : */floor_pos_y7 + 10'd1) : floor_pos_y7;
            end
            else begin
                next_floor_pos_x = tmp_floor_pos_x0;
                next_floor_pos_y = tmp_floor_pos_y0;
                /*next_floor_pos_y0 = floor_pos_y0;
                next_floor_pos_y1 = floor_pos_y1;
                next_floor_pos_y2 = floor_pos_y2;
                next_floor_pos_y3 = floor_pos_y3;

                next_floor_pos_y4 = floor_pos_y4;
                next_floor_pos_y5 = floor_pos_y5;
                next_floor_pos_y6 = floor_pos_y6;
                next_floor_pos_y7 = floor_pos_y7;*/
            end
        end
        else begin
            next_floor_pos_x = tmp_floor_pos_x0;
            next_floor_pos_y = tmp_floor_pos_y0;
            /*next_floor_pos_y0 = floor_pos_y0;
            next_floor_pos_y1 = floor_pos_y1;
            next_floor_pos_y2 = floor_pos_y2;
            next_floor_pos_y3 = floor_pos_y3;

            next_floor_pos_y4 = floor_pos_y4;
            next_floor_pos_y5 = floor_pos_y5;
            next_floor_pos_y6 = floor_pos_y6;
            next_floor_pos_y7 = floor_pos_y7;*/
        end
    end

endmodule