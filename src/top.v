`default_nettype none
`timescale 1ns/1ns

module top(
    input reset,
    input clk,
    input btn,

    output vga_h_sync,
    output vga_v_sync,
    output reg[3:0] vga_r,
    output reg[3:0] vga_g,
    output reg[3:0] vga_b,
);

    wire core_busy;
    wire clk_25_175;
    wire [9:0] h_readwire, v_readwire;
    reg [11:0] pixstream;
    reg write;
    wire [4:0] gpu_block_selector_v;
    wire [4:0] gpu_block_selector_h;
    wire [2:0] gpu_blocktype;

    vga_pll pll(
        .clock_in(clk),
        .clock_out(clk_25_175),
    );

    blkmemory memory(
        .clk(clk),
        .reset(reset),
        .vaddr(gpu_block_selector_v),
        .haddr(gpu_block_selector_h),
        .memval(gpu_blocktype),
    );

    gmanager game_manager(
        .clk_25_175(clk_25_175),
        .reset(reset),
        .hreadwire(h_readwire),
        .vreadwire(v_readwire),
        .pixstream(pixstream),
        .memselector_v(gpu_block_selector_v),
        .memselector_h(gpu_block_selector_h),
        .blocktype_mem(gpu_blocktype),
    );

    VGAcore core(
        .clk_25_175(clk_25_175),
        .reset(reset),
        .drawing_pixels(core_busy),
        .h_sync(vga_h_sync),
        .v_sync(vga_v_sync),
        .pixstream(pixstream),
        .hreadwire(h_readwire),
        .vreadwire(v_readwire),
        .r(vga_r),
        .g(vga_g),
        .b(vga_b)
    );
endmodule
