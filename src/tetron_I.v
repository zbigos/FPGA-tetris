`default_nettype none
`timescale 1ns/1ns

module tetron_I_shaper(
    input wire clk,
    input wire active,
    input wire [2:0] tetron_rotation,
    output reg [4:0] blk1_voffset,
    output reg [4:0] blk1_hoffset,
    output reg [4:0] blk2_voffset,
    output reg [4:0] blk2_hoffset,
    output reg [4:0] blk3_voffset,
    output reg [4:0] blk3_hoffset,
    output reg [4:0] blk4_voffset,
    output reg [4:0] blk4_hoffset
);

    always @(posedge clk) begin
        if (!active) begin
            blk1_voffset <= 0;
            blk1_hoffset <= 0;
            blk2_voffset <= 0;
            blk2_hoffset <= 0;
            blk3_voffset <= 0;
            blk3_hoffset <= 0;
            blk4_voffset <= 0;
            blk4_hoffset <= 0;
        end else begin
            if (tetron_rotation == 3'd0) begin
                blk1_voffset <= 0;
                blk1_hoffset <= 0;
                blk2_voffset <= 0;
                blk2_hoffset <= -1;
                blk3_voffset <= 0;
                blk3_hoffset <= 1;
                blk4_voffset <= 0;
                blk4_hoffset <= 2;
            end

            if (tetron_rotation == 3'd1) begin
                blk1_voffset <= 0;
                blk1_hoffset <= 0;
                blk2_voffset <= -1;
                blk2_hoffset <= 0;
                blk3_voffset <= 1;
                blk3_hoffset <= 0;
                blk4_voffset <= 2;
                blk4_hoffset <= 0;
            end

            if (tetron_rotation == 3'd2) begin
                blk1_voffset <= 1;
                blk1_hoffset <= 0;
                blk2_voffset <= 1;
                blk2_hoffset <= -1;
                blk3_voffset <= 1;
                blk3_hoffset <= 1;
                blk4_voffset <= 1;
                blk4_hoffset <= 2;
            end

            if (tetron_rotation == 3'd3) begin
                blk1_voffset <= 0;
                blk1_hoffset <= 1;
                blk2_voffset <= -1;
                blk2_hoffset <= 1;
                blk3_voffset <= 1;
                blk3_hoffset <= 1;
                blk4_voffset <= 2;
                blk4_hoffset <= 1;
            end
        end
    end
endmodule