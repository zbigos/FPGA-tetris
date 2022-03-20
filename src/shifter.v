
module shifter (
    input wire clk,
    input wire [22:0] rowfull,
    output wire [22:0] rowshift,
    output wire led1,
    output wire led2,
);

    wire [5:0] point1;
    assign point1 = rowfull[0] ? 6'd1 : rowfull[1] ? 6'd2 : rowfull[2] ? 6'd3 : rowfull[3] ? 6'd4 : 6'd0;
    wire [5:0] point2;
    assign point2 = rowfull[4] ? 6'd5 : rowfull[5] ? 6'd6 : rowfull[6] ? 6'd7 : rowfull[7] ? 6'd8 : 6'd0;
    wire [5:0] point3;
    assign point3 = rowfull[8] ? 6'd9 : rowfull[9] ? 6'd10 : rowfull[10] ? 6'd11 : rowfull[11] ? 6'd12 : 6'd0;
    wire [5:0] point4;
    assign point4 = rowfull[12] ? 6'd13 : rowfull[13] ? 6'd14 : rowfull[14] ? 6'd15 : rowfull[15] ? 6'd16 : 6'd0;
    wire [5:0] point5;
    assign point5 = rowfull[16] ? 6'd17 : rowfull[17] ? 6'd18 : rowfull[18] ? 6'd19 : rowfull[19] ? 6'd20 : 6'd0;
    wire [5:0] point6;
    assign point6 = rowfull[20] ? 6'd21 : rowfull[21] ? 6'd22 : rowfull[22] ? 6'd23 : 6'd0;

    wire [5:0] totp;
    assign totp = (point6 > 0) ? point6 : (point5 > 0) ? point5 : (point4 > 0) ? point4 : (point3 > 0) ? point3 : (point2 > 0) ? point2 : (point1 > 0) ? point1 : 6'd0;

    assign led1 = totp[5];
    assign led2 = totp[5];
    

    assign rowshift[0] = (6'd0 <= totp);
    assign rowshift[1] = (6'd1 <= totp);
    assign rowshift[2] = (6'd2 <= totp);
    assign rowshift[3] = (6'd3 <= totp);
    assign rowshift[4] = (6'd4 <= totp);
    assign rowshift[5] = (6'd5 <= totp);
    assign rowshift[6] = (6'd6 <= totp);
    assign rowshift[7] = (6'd7 <= totp);

    assign rowshift[8] = (6'd8 <= totp);
    assign rowshift[9] = (6'd9 <= totp);
    assign rowshift[10] = (6'd10 <= totp);
    assign rowshift[11] = (6'd11 <= totp);
    assign rowshift[12] = (6'd12 <= totp);
    assign rowshift[13] = (6'd13 <= totp);
    assign rowshift[14] = (6'd14 <= totp);
    assign rowshift[15] = (6'd15 <= totp);

    assign rowshift[16] = (6'd16 <= totp);
    assign rowshift[17] = (6'd17 <= totp);
    assign rowshift[18] = (6'd18 <= totp);
    assign rowshift[19] = (6'd19 <= totp);
    assign rowshift[20] = (6'd20 <= totp);
    assign rowshift[21] = (6'd21 <= totp);
    assign rowshift[22] = (6'd22 <= totp);
endmodule