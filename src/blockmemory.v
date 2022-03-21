`default_nettype none
`timescale 1ns/1ns

module blkmemory # (
    parameter BLOCKS_VERTICAL = 12, //20
    parameter BLOCKS_HORIZONTAL = 21, //10    
) (
    output wire led1,
    output wire led2,
    output wire[7:0] debugled,
    input wire clk,
    input wire reset,
    input wire core_busy,
    input wire[4:0] vaddr,
    input wire[4:0] haddr,
    output wire [2:0] memval,
    output reg collision,

    output reg movement_commit,
    output reg movement_steal,
    output reg movement_declined,
    input wire movement_request,
    input wire movement_intent,
    output wire bumpwire,
    input wire[4:0] P1blk_v,
    input wire[4:0] P1blk_h,
    input wire[4:0] P2blk_v,
    input wire[4:0] P2blk_h,
    input wire[4:0] P3blk_v,
    input wire[4:0] P3blk_h,
    input wire[4:0] P4blk_v,
    input wire[4:0] P4blk_h,
    input wire[2:0] volatile_blk_color,
    output reg [15:0] scorewire
);

    wire lookup_collision;
    assign lookup_collision = (P1blk_v == vaddr & P1blk_h == haddr) \
    | (P2blk_v == vaddr & P2blk_h == haddr) \
    | (P3blk_v == vaddr & P3blk_h == haddr) \
    | (P4blk_v == vaddr & P4blk_h == haddr);

    reg [2:0] proposed_memval;

    wire [2:0] memvalwire;
    assign memval = lookup_collision ? volatile_blk_color : proposed_memval;
    
    reg [5:0] mm_colosetter_x;
    reg [5:0] mm_colosetter_y;
    reg mm_colorsetter_commit;
    reg [2:0] mm_colorsetter_value;
    
    reg [3:0] stealstatus;

    wire [3:0] hitwire;
    wire [22:0] rowfull;
    wire [22:0] rowshift;
    wire [22:0] acc_rowshift;
    reg [3:0] cooldown;
    assign debugled = cooldown;

    reg [16:0] streak_cooldown;
    reg [2:0] streak_iterator;

    assign led1 = mm_colorsetter_commit;
    assign acc_rowshift = (cooldown == 4'b0) ? rowshift : 23'b0;
    assign bumpwire = (cooldown == 4'b0) & rowshift[1];

    shifter sh(
        .debugled(),        
        .clk(clk),
        .rowfull(rowfull),
        .rowshift(rowshift)
    );

    memory mem(
        .clk(clk),
        .reset(reset),
        .memory_busy(core_busy),
        .color_requestor_x(vaddr),
        .color_requestor_y(haddr),
        .color_getter(memvalwire),
        .color_set_requestor_x(mm_colosetter_x),
        .color_set_requestor_y(mm_colosetter_y),
        .color_commit(mm_colorsetter_commit),
        .color_setter(mm_colorsetter_value),
        .hitbox_checker_0_x(P1blk_v),
        .hitbox_checker_0_y(P1blk_h),
        .hitbox_checker_1_x(P2blk_v),
        .hitbox_checker_1_y(P2blk_h),
        .hitbox_checker_2_x(P3blk_v),
        .hitbox_checker_2_y(P3blk_h),
        .hitbox_checker_3_x(P4blk_v),
        .hitbox_checker_3_y(P4blk_h),
        .hitbox_status(hitwire),
        .rowfull_stat(rowfull),
        .rowshift_cmd(acc_rowshift)
    );

    reg resetperiod;
    reg [20:0] resetperiod_state;
    reg [3:0] perq;
    reg [4:0] keep_concurrent_blks;

    always @(posedge clk) begin
        if(!reset) begin
            resetperiod <= 1'b1;
            resetperiod_state <= 21'b0;
            proposed_memval <= 3'b111;
            mm_colosetter_x <= 5'b0;
            mm_colosetter_y <= 5'b0;
            mm_colorsetter_commit <= 1'b1;
            mm_colorsetter_value <= 3'b110; 
            movement_steal <= 1'b0;
            movement_declined <= 1'b0;
            movement_commit <= 1'b0;
            stealstatus <= 4'b0;
            perq <= 4'b0;
            cooldown <= 4'b0;
            keep_concurrent_blks <= 5'b0;
            streak_iterator <= 3'b0;
            streak_cooldown <= 16'b0;
        end else begin
            if (resetperiod) begin  // what I'm indexing over y, has values 0-21
                if (resetperiod_state < BLOCKS_HORIZONTAL) begin
                    mm_colosetter_y <= resetperiod_state[5:0];
                    mm_colosetter_x <= 5'd0;
                    resetperiod_state <= resetperiod_state + 1'b1;
                end
                if (resetperiod_state >= BLOCKS_HORIZONTAL & resetperiod_state < (BLOCKS_HORIZONTAL + BLOCKS_VERTICAL)) begin
                    mm_colosetter_y <= 5'd20;
                    mm_colosetter_x <= resetperiod_state[5:0] - BLOCKS_HORIZONTAL;
                    resetperiod_state <= resetperiod_state + 1'b1;
                end
                if (resetperiod_state >= (BLOCKS_HORIZONTAL + BLOCKS_VERTICAL) & resetperiod_state < (2*BLOCKS_HORIZONTAL + BLOCKS_VERTICAL)) begin
                    mm_colosetter_y <= resetperiod_state[5:0] - (BLOCKS_HORIZONTAL + BLOCKS_VERTICAL);
                    mm_colosetter_x <= 5'd11;
                    resetperiod_state <= resetperiod_state + 1'b1;
                end
                if (resetperiod_state >= (2*BLOCKS_HORIZONTAL + BLOCKS_VERTICAL)) begin
                    resetperiod <= 1'b0;
                    mm_colorsetter_commit <= 1'b0;
                end
            end else begin
                proposed_memval <= memvalwire;
                if (acc_rowshift[0] & cooldown == 4'b0) begin
                    cooldown <= 4'b1111;
                    if (streak_cooldown == 0) begin
                        scorewire <= 16'd40;
                        streak_cooldown <= 16'd1024;
                    end else begin
                        streak_cooldown <= 16'd1024;

                        if (streak_iterator == 3'd0) begin
                            scorewire <= 16'd60;
                            streak_iterator <= 3'd1;
                        end

                        if (streak_iterator == 3'd1) begin
                            scorewire <= 16'd200; // sum for 2 is 100, but we get 40 in streak_iterator = 0
                            streak_iterator <= 3'd2;
                        end

                        if (streak_iterator == 3'd2) begin
                            scorewire <= 16'd900;
                            streak_iterator <= 3'd3;
                        end

                    end
                end else if (movement_request & (perq == 4'b0)) begin
                    perq <= 4'd12;
                    cooldown <= 4'b1111;
                end else if (perq == 0) begin
                    scorewire <= 16'b0;
                    movement_steal <= 1'b0;
                    movement_commit <= 1'b0;
                    movement_declined <= 1'b0;
                    stealstatus <= 4'd0;
                    if (cooldown > 0) begin
                        cooldown <= cooldown - 1'b1;
                    end
                    if (streak_cooldown > 0) begin
                        streak_cooldown <= streak_cooldown - 1'b1;
                    end else begin
                        streak_iterator <= 3'b0;
                    end
                end
                if (perq > 0) begin
                    if (perq == 4'd1) begin
                        perq <= 1'b0;
                        if (|hitwire) begin
                            if (movement_intent) begin
                                movement_declined <= 1'b1; // intent = 1 means user made the move
                            end else begin

                                if (stealstatus == 4'd0) begin
                                    mm_colorsetter_commit <= 1'b1;
                                    mm_colosetter_x <= P1blk_v;
                                    mm_colosetter_y <= P1blk_h - 1;
                                    mm_colorsetter_value <= volatile_blk_color;
                                    stealstatus <= 4'd1;
                                end

                                if (stealstatus == 4'd1) begin
                                    mm_colorsetter_commit <= 1'b1;
                                    mm_colosetter_x <= P2blk_v;
                                    mm_colosetter_y <= P2blk_h - 1;
                                    mm_colorsetter_value <= volatile_blk_color;
                                    stealstatus <= 4'd2;
                                end

                                if (stealstatus == 4'd2) begin
                                    mm_colorsetter_commit <= 1'b1;
                                    mm_colosetter_x <= P3blk_v;
                                    mm_colosetter_y <= P3blk_h - 1;
                                    mm_colorsetter_value <= volatile_blk_color;
                                    stealstatus <= 4'd3;
                                end

                                if (stealstatus == 4'd3) begin
                                    mm_colorsetter_commit <= 1'b1;
                                    mm_colosetter_x <= P4blk_v;
                                    mm_colosetter_y <= P4blk_h - 1;
                                    mm_colorsetter_value <= volatile_blk_color;
                                    stealstatus <= 4'd4;
                                end

                                if (stealstatus == 4'd4) begin
                                    stealstatus <= 4'd5;
                                    mm_colorsetter_commit <= 1'b0;
                                end

                                if (stealstatus == 4'd5) begin
                                    movement_steal <= 1'b1;
                                    stealstatus <= 4'd6;
                                end
                            end
                        end else begin
                            movement_commit <= 1'b1;
                        end
                    end else begin
                        perq <= perq - 1'b1;
                    end 
                end else begin
                end
            end
        end
    end

endmodule