module record(
    input [3:0] score_0,
    input [3:0] score_1,
    input rst,
    input slime_die,
    input clk,
    output reg [3:0] last_score_0,
    output reg [3:0] last_score_1,
    output reg [3:0] highest_score_0,
    output reg [3:0] highest_score_1
);

    always @ (posedge clk) begin
        if (rst) begin
            last_score_0 <= 4'd0;
            last_score_1 <= 4'd0;
            highest_score_0 <= 4'd0;
            highest_score_1 <= 4'd0;
        end
        else if (slime_die) begin
            last_score_0 <= (score_1 == 4'd10) ? 4'd9 : score_0;
            last_score_1 <= (score_1 == 4'd10) ? 4'd9 : score_1;
            if (score_1 > highest_score_1) begin
                highest_score_0 <= (score_1 == 4'd10) ? 4'd9 : score_0;
                highest_score_1 <= (score_1 == 4'd10) ? 4'd9 : score_1;
            end
            else if (score_1 == highest_score_1) begin
                if (score_0 > highest_score_0) begin
                    highest_score_0 <= (score_1 == 4'd10) ? 4'd9 : score_0;
                    highest_score_1 <= (score_1 == 4'd10) ? 4'd9 : score_1;
                end
                else begin
                    highest_score_0 <= highest_score_0;
                    highest_score_1 <= highest_score_1;
                end
            end
            else begin
                highest_score_0 <= highest_score_0;
                highest_score_1 <= highest_score_1;
            end
        end
        else begin
            last_score_0 <= last_score_0;
            last_score_1 <= last_score_1;
            highest_score_0 <= highest_score_0;
            highest_score_1 <= highest_score_1;
        end
    end

endmodule