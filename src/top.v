`default_nettype none
`timescale 1ns/1ns

module top(
    input clk,
    input btn,
    output led1,
    output led2,
    output led3,
    input butt1,
    input butt2,
    input butt3,
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
	
    reg [3:0] resetn_gen = 0;
	reg reset;
    wire pll_locked;

	always @(posedge clk_25_175) begin
		reset <= &resetn_gen;
		resetn_gen <= {resetn_gen, pll_locked};
	end

    wire[4:0] P1blk_v;
    wire[4:0] P1blk_h;
    wire[4:0] P2blk_v;
    wire[4:0] P2blk_h;
    wire[4:0] P3blk_v;
    wire[4:0] P3blk_h;
    wire[4:0] P4blk_v;
    wire[4:0] P4blk_h;
    wire[2:0] volatile_blk_color;

    wire gametick;
    timer t(
        .clk(clk_25_175),
        .reset(reset),
        .top(24'b111111111111111111111111),
        .led(),
        .trigger(gametick)
    );

    vga_pll pll(
        .clock_in(clk),
        .pll_locked(pll_locked),
        .clock_out(clk_25_175),
    );

    wire movement_commit, movement_steal, movement_decline, movement_request, movement_intent;
    assign led3 = movement_request;

    blkmemory memory(
        .led1(led1),
        .led2(led2),
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
    );

    cellstorage vcell(
        .led(),
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
        .P1blk_v(P1blk_v),
        .P1blk_h(P1blk_h),
        .P2blk_v(P2blk_v),
        .P2blk_h(P2blk_h),
        .P3blk_v(P3blk_v),
        .P3blk_h(P3blk_h),
        .P4blk_v(P4blk_v),
        .P4blk_h(P4blk_h),
        .volatile_blk_color(volatile_blk_color),
        .gametick(gametick),
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
