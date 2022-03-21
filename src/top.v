`default_nettype none
`timescale 1ns/1ns

module top(
    input clk,
    input reset,
    input butt1,
    input butt2,
    input butt3,
    input butt4,
    output vga_h_sync,
    output vga_v_sync,
    output reg[3:0] vga_r,
    output reg[3:0] vga_g,
    output reg[3:0] vga_b
);

    wire core_busy;
    wire clk_25_175;
    assign clk_25_175 = clk;

    reg write;
    wire [4:0] gpu_block_selector_v;
    wire [4:0] gpu_block_selector_h;
    wire [2:0] gpu_blocktype;
	
    reg [3:0] resetn_gen = 0;


    wire [15:0] scorewire;
    wire [23:0] gamespeed;
    wire[4:0] P1blk_v;
    wire[4:0] P1blk_h;
    wire[4:0] P2blk_v;
    wire[4:0] P2blk_h;
    wire[4:0] P3blk_v;
    wire[4:0] P3blk_h;
    wire[4:0] P4blk_v;
    wire[4:0] P4blk_h;
    wire[2:0] volatile_blk_color;
    wire bumpwire;

    wire gametick;
    timer t(
        .clk(clk_25_175),
        .reset(reset),
        .top(gamespeed),
        .led(),
        .trigger(gametick)
    );

    wire movement_commit, movement_steal, movement_decline, movement_request, movement_intent;
    blkmemory memory(
        .clk(clk_25_175),
        .reset(reset),
        .core_busy(core_busy),
        .vaddr(gpu_block_selector_v),
        .haddr(gpu_block_selector_h),
        .memval(gpu_blocktype),
        .movement_commit(movement_commit),
        .movement_steal(movement_steal),
        .movement_declined(movement_decline),
        .movement_request(movement_request),
        .movement_intent(movement_intent),
        .P1blk_v(P1blk_v),
        .P1blk_h(P1blk_h),
        .P2blk_v(P2blk_v),
        .P2blk_h(P2blk_h),
        .P3blk_v(P3blk_v),
        .P3blk_h(P3blk_h),
        .P4blk_v(P4blk_v),
        .P4blk_h(P4blk_h),
        .volatile_blk_color(volatile_blk_color),
        .bumpwire(bumpwire),
        .scorewire(scorewire)
    );

    cellstorage vcell(
        .clk(clk_25_175),
        .reset(reset),
        .movement_commit(movement_commit),
        .movement_steal(movement_steal),
        .movement_declined(movement_decline),
        .movement_request(movement_request),
        .movement_intent(movement_intent),
        .buttL(butt1),
        .buttT(butt2),
        .buttR(butt3),
        .buttD(butt4),
        .P1blk_v(P1blk_v),
        .P1blk_h(P1blk_h),
        .P2blk_v(P2blk_v),
        .P2blk_h(P2blk_h),
        .P3blk_v(P3blk_v),
        .P3blk_h(P3blk_h),
        .P4blk_v(P4blk_v),
        .P4blk_h(P4blk_h),
        .volatile_blk_color(volatile_blk_color),
        .gametick(gametick)
    );

    wire [9:0] h_readwire, v_readwire;
    wire [11:0] pixstream;
    wire [11:0] board_stream;
    wire [11:0] gamespeed_stream;
    wire [11:0] score_screen;

    wire board_stream_priority;
    wire speedmeter_priority;
    wire scorecounter_priority;
    assign pixstream = board_stream_priority ? board_stream : (speedmeter_priority ? gamespeed_stream : (scorecounter_priority ? score_screen : 12'b001100110011));

    screen_manager screen_mngr(
        .h_readwire(h_readwire),
        .v_readwire(v_readwire),
        .board_stream_priori(board_stream_priority),
        .top_view_priori(speedmeter_priority),
        .scorecounter_priority(scorecounter_priority)
    );

    topbar_display tdisplay(
        .clk_25_175(clk_25_175),
        .reset(reset),
        .hreadwire(h_readwire),
        .vreadwire(v_readwire),
        .pixstream(gamespeed_stream),
        .bump(bumpwire),
        .gamespeed(gamespeed)
    );

    scoredisplay sdisplay(
        .clk_25_175(clk_25_175),
        .reset(reset),
        .hreadwire(h_readwire),
        .vreadwire(v_readwire),
        .pixstream(score_screen),
        .scorewire(scorewire)
    );

    gmanager game_manager(
        .clk_25_175(clk_25_175),
        .reset(reset),
        .hreadwire(h_readwire),
        .vreadwire(v_readwire),
        .pixstream(board_stream),
        .memselector_v(gpu_block_selector_v),
        .memselector_h(gpu_block_selector_h),
        .blocktype_mem(gpu_blocktype)
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
