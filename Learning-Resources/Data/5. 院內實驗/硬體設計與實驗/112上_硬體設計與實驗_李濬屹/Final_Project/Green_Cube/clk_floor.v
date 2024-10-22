module clk_floor(clk, rst, dclk);
    input clk, rst;
    output wire dclk;
    reg [15:0] counter;

    assign dclk = counter [14:0] == 15'd0;

    always @ (posedge clk) begin
        if (rst) counter <= 16'd0;
        else counter <= counter + 1;
    end

endmodule