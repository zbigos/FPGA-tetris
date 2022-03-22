`default_nettype none
`timescale 1ns/1ns

module tetron_O_shaper(
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
            blk1_voffset <= 0;
            blk1_hoffset <= 0;

            blk2_voffset <= 1;
            blk2_hoffset <= 1;
            blk3_voffset <= 0;
            blk3_hoffset <= 1;
            blk4_voffset <= 1;
            blk4_hoffset <= 0;
        end
    end
endmodule