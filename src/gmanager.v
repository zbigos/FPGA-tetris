`default_nettype none
`timescale 1ns/1ns

module gmanager # (
    parameter NATIVE_HRES = 640,
    parameter NATIVE_VRES = 480,
    parameter RES_PRESCALER = 1,
    parameter BLOCKS_VERTICAL = 12, //20
    parameter BLOCKS_HORIZONTAL = 21, //10
    parameter VBLK_SIZE = 32,
    parameter HBLK_SIZE = 24
    
) (
    input reset,
    input clk_25_175,
    input wire[9:0] hreadwire,
    input wire[9:0] vreadwire,
    output reg[11:0] pixstream,
    output wire[4:0] memselector_v,
    output wire[4:0] memselector_h,
    input wire[2:0] blocktype_mem,
);

    wire in_game_area_v, in_game_area_h, in_game_area;
    assign in_game_area = in_game_area_v & in_game_area_h;

    
    assign in_game_area_v = (vreadwire >= 40 && vreadwire < (40 + BLOCKS_VERTICAL * VBLK_SIZE));
    assign in_game_area_h = (hreadwire >= 40 && hreadwire < (40 + BLOCKS_HORIZONTAL * HBLK_SIZE));

    wire [11:0] shaded;
    reg [11:0] ipixstream;

    wire [4:0] blknum_vertical = (vreadwire - 40) / VBLK_SIZE;
    wire [5:0] blkoffset_vertical = (vreadwire - 40) - (VBLK_SIZE * blknum_vertical);
    wire [4:0] blknum_horizontal;
    wire [5:0] blkoffset_horizontal;

    assign memselector_v = blknum_vertical;
    assign memselector_h = blknum_horizontal;
    

    wire [9:0] ohreadwire = hreadwire - 40;
    blknum_horizontal h(
        .pposition(ohreadwire),
        .blkid(blknum_horizontal)
    );

    blkoffset_horizontal hh(
        .pposition(ohreadwire),
        .blkid(blknum_horizontal),
        .offset(blkoffset_horizontal)
    );

    shader sh(
        .block_x(blkoffset_horizontal), // <------ to
        .block_y(blkoffset_vertical),
        .in_color(ipixstream),
        .out_color(shaded)
    );

    wire [11:0] texture_lookup;

    color_lut c(
        .color(texture_lookup),
        .type(blocktype_mem)
    );

    always @(posedge clk_25_175) begin
        if (!reset) begin
            pixstream = 12'b000000000000;
            ipixstream = 12'b000000000000;
        end else begin
            if (in_game_area) begin
                ipixstream = texture_lookup;
                pixstream = shaded;
            end

            if (!in_game_area) begin
               pixstream <= 12'b111111111111;
            end
        end
    end


endmodule
