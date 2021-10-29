`default_nettype none
`timescale 1ns/1ns


module blknum_horizontal (
    input wire[9:0] pposition, 
    output wire[4:0] blkid,
);

    wire locators [0: 24];
    wire [0:4] block1, block2, block3, block4, block5, block6;
    genvar i;
    generate
        for(i = 0; i < 24; i = i + 1) begin
            assign locators[i] = ((pposition >= 24 * i) & (pposition < 24 * (i + 1)));
        end

        assign block1 = (locators[0] ? 5'd0 : 5'b00000) | (locators[1] ? 5'd1 : 5'b00000) | (locators[2] ? 5'd2 : 5'b00000) | (locators[3] ? 5'd3 : 5'b00000);
        assign block2 = (locators[4] ? 5'd4 : 5'b00000) | (locators[5] ? 5'd5 : 5'b00000) | (locators[6] ? 5'd6 : 5'b00000) | (locators[7] ? 5'd7 : 5'b00000);
        assign block3 = (locators[8] ? 5'd8 : 5'b00000) | (locators[9] ? 5'd9 : 5'b00000) | (locators[10] ? 5'd10 : 5'b00000) | (locators[11] ? 5'd11 : 5'b00000);
        assign block4 = (locators[12] ? 5'd12 : 5'b00000) | (locators[13] ? 5'd13 : 5'b00000) | (locators[14] ? 5'd14 : 5'b00000) | (locators[15] ? 5'd15 : 5'b00000);
        assign block5 = (locators[16] ? 5'd16 : 5'b00000) | (locators[17] ? 5'd17 : 5'b00000) | (locators[18] ? 5'd18 : 5'b00000) | (locators[19] ? 5'd19 : 5'b00000);
        assign block6 = (locators[20] ? 5'd20 : 5'b00000) | (locators[21] ? 5'd21 : 5'b00000) | (locators[22] ? 5'd22 : 5'b00000) | (locators[23] ? 5'd23 : 5'b00000);

        assign blkid = block1 | block2 | block3 | block4 | block5 | block6;
    endgenerate
endmodule

module offsetmap(
    input wire[5:0] blkid,
    output wire[9:0] offset
);
    assign offset = (((blkid == 5'd0) ? 10'd0 : 10'd0 | (blkid == 5'd1) ? 10'd24 : 10'd0) 
        | ((blkid == 5'd2) ? 10'd48 : 10'd0 | (blkid == 5'd3) ? 10'd72 : 10'd0) 
        | ((blkid == 5'd4) ? 10'd96 : 10'd0 | (blkid == 5'd5) ? 10'd120: 10'd0)
        | ((blkid == 5'd6) ? 10'd144 : 10'd0 | (blkid == 5'd7) ? 10'd168 : 10'd0) 
        | ((blkid == 5'd8) ? 10'd192 : 10'd0 | (blkid == 5'd9) ? 10'd216 : 10'd0)
        | ((blkid == 5'd10) ? 10'd240 : 10'd0 | (blkid == 5'd11) ? 10'd264 : 10'd0) 
        | ((blkid == 5'd12) ? 10'd288 : 10'd0 | (blkid == 5'd13) ? 10'd312 : 10'd0) 
        | ((blkid == 5'd14) ? 10'd336 : 10'd0 | (blkid == 5'd15) ? 10'd360 : 10'd0) 
        | ((blkid == 5'd16) ? 10'd384 : 10'd0 | (blkid == 5'd17) ? 10'd408 : 10'd0)
        | ((blkid == 5'd18) ? 10'd432 : 10'd0 | (blkid == 5'd19) ? 10'd456 : 10'd0) 
        | ((blkid == 5'd20) ? 10'd480 : 10'd0 | (blkid == 5'd21) ? 10'd504 : 10'd0)); 

endmodule

module blkoffset_horizontal (
    input wire[9:0] pposition, 
    input wire[5:0] blkid,
    output wire[5:0] offset
);
    wire [9:0] base;
    offsetmap o(
        .blkid(blkid),
        .offset(base)
    );

    assign offset = pposition - base;
endmodule