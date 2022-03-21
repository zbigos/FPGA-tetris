
module shifter (
    input wire clk,
    input wire [22:0] rowfull,
    output reg [22:0] rowshift
);

    wire [5:0] point1;
    assign point1 = (rowfull[0] == 1'b1) ? 6'd1 : ((rowfull[1] == 1'b1) ? 6'd2 : ((rowfull[2] == 1'b1) ? 6'd3 : ((rowfull[3] == 1'b1) ? 6'd4 : 6'd0)));
    wire [5:0] point2;
    assign point2 = (rowfull[4] == 1'b1) ? 6'd5 : ((rowfull[5] == 1'b1) ? 6'd6 : ((rowfull[6] == 1'b1) ? 6'd7 : ((rowfull[7] == 1'b1) ? 6'd8 : 6'd0)));
    wire [5:0] point3;
    assign point3 = (rowfull[8] == 1'b1) ? 6'd9 : ((rowfull[9] == 1'b1) ? 6'd10 : ((rowfull[10] == 1'b1) ? 6'd11 : ((rowfull[11] == 1'b1) ? 6'd12 : 6'd0)));
    wire [5:0] point4;
    assign point4 = (rowfull[12] == 1'b1) ? 6'd13 : ((rowfull[13] == 1'b1) ? 6'd14 : ((rowfull[14] == 1'b1) ? 6'd15 : ((rowfull[15] == 1'b1) ? 6'd16 : 6'd0)));
    wire [5:0] point5;
    assign point5 = (rowfull[16] == 1'b1) ? 6'd17 : ((rowfull[17] == 1'b1) ? 6'd18 : ((rowfull[18] == 1'b1) ? 6'd19 : ((rowfull[19] == 1'b1) ? 6'd20 : 6'd0)));
    wire [5:0] point6;
    assign point6 = (rowfull[20] == 1'b1) ? 6'd21 : ((rowfull[21] == 1'b1) ? 6'd22 : ((rowfull[22] == 1'b1) ? 6'd23 : 6'd0));

    wire [5:0] totp;
    assign totp = (point1 > 6'd0) ? point1 : ((point2 > 6'd0) ? point2 : ((point3 > 6'd0) ? point3 : ((point4 > 6'd0) ? point4 : ((point5 > 6'd0) ? point5 : ((point6 > 6'd0) ? point6 : 6'd0)))));

    always @(posedge clk) begin
        rowshift[0] <= (6'd0 < totp);
        rowshift[1] <= (6'd1 < totp);
        rowshift[2] <= (6'd2 < totp);
        rowshift[3] <= (6'd3 < totp);
        rowshift[4] <= (6'd4 < totp);
        rowshift[5] <= (6'd5 < totp);
        rowshift[6] <= (6'd6 < totp);
        rowshift[7] <= (6'd7 < totp);
        rowshift[8] <= (6'd8 < totp);
        rowshift[9] <= (6'd9 < totp);
        rowshift[10] <= (6'd10 < totp);
        rowshift[11] <= (6'd11 < totp);
        rowshift[12] <= (6'd12 < totp);
        rowshift[13] <= (6'd13 < totp);
        rowshift[14] <= (6'd14 < totp);
        rowshift[15] <= (6'd15 < totp);
        rowshift[16] <= (6'd16 < totp);
        rowshift[17] <= (6'd17 < totp);
        rowshift[18] <= (6'd18 < totp);
        rowshift[19] <= (6'd19 < totp);
        rowshift[20] <= (6'd20 < totp);
        rowshift[21] <= (6'd21 < totp);
        rowshift[22] <= (6'd22 < totp);
    end

endmodule