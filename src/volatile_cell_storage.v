`default_nettype none
`timescale 1ns/1ns

module cellstorage(
    output wire led,
    input wire clk,
    input wire reset,
    input wire gametick,
    input wire buttL,
    input wire buttT,
    input wire buttR,
    
    output reg movement_request,
    output reg movement_intent,
    input wire movement_declined,
    input wire movement_commit,
    input wire movement_steal,

    output reg[4:0] P1blk_v,
    output reg[4:0] P1blk_h,
    output reg[4:0] P2blk_v,
    output reg[4:0] P2blk_h,
    output reg[4:0] P3blk_v,
    output reg[4:0] P3blk_h,
    output reg[4:0] P4blk_v,
    output reg[4:0] P4blk_h,

    output reg[2:0] volatile_blk_color,
);

    reg [4:0] tetron_v;
    reg [4:0] tetron_h;
    reg [2:0] tetron_rotation;

    reg [4:0] keep_tetron_v;
    reg [4:0] keep_tetron_h;
    reg [2:0] keep_tetron_rotation;

    reg [3:0] tetron_type;


    wire [4:0] itetron_blk_h [4:0];
    wire [4:0] itetron_blk_v [4:0];

    assign P1blk_v = tetron_v + (itetron_blk_v[0]);
    assign P2blk_v = tetron_v + (itetron_blk_v[1]);
    assign P3blk_v = tetron_v + (itetron_blk_v[2]);
    assign P4blk_v = tetron_v + (itetron_blk_v[3]);
    
    assign P1blk_h = tetron_h + (itetron_blk_h[0]);
    assign P2blk_h = tetron_h + (itetron_blk_h[1]);
    assign P3blk_h = tetron_h + (itetron_blk_h[2]);
    assign P4blk_h = tetron_h + (itetron_blk_h[3]);

    tetron_I_shaper ishaper(
        .clk(clk),
        .active(tetron_type == 3'd0),
        .tetron_rotation(tetron_rotation),
        .blk1_voffset(itetron_blk_v[0]), .blk1_hoffset(itetron_blk_h[0]),
        .blk2_voffset(itetron_blk_v[1]), .blk2_hoffset(itetron_blk_h[1]),
        .blk3_voffset(itetron_blk_v[2]), .blk3_hoffset(itetron_blk_h[2]),
        .blk4_voffset(itetron_blk_v[3]), .blk4_hoffset(itetron_blk_h[3])
    );

    reg movement_available;
    reg cooldown;
    reg postdecline_cool;
    reg process_steal;
    reg [7:0] state;
    reg [5:0] buttdebounceL;
    reg [5:0] buttdebounceR;
    reg [5:0] buttdebounceT;
    reg process_decline;

    assign led = 1'b0;
    always @(posedge clk) begin
        if (!reset) begin
            process_decline <= 1'b0;
            cooldown <= 1'b0;
            tetron_type <= 3'd0;
            tetron_v <= 4'd5;
            tetron_h <= 4'd5;
            keep_tetron_v <= 4'd5;
            keep_tetron_h <= 4'd5;
            movement_request <= 1'b0;
            movement_available <= 1'b1;
            volatile_blk_color <= 3'b100;
            tetron_rotation <= 3'b000;
            movement_intent <= 1'b0;
            process_steal <= 1'b0;
            state <= 8'b11110000;
            buttdebounceL <= 6'b0;
            process_decline <= 1'b0;
            buttdebounceT <= 6'b0;
            buttdebounceR <= 6'b0;
            postdecline_cool <= 1'b0;
            keep_tetron_rotation <= 3'b0;
        end else begin
            buttdebounceL <= {buttL, buttdebounceL[5:1]};
            buttdebounceT <= {buttT, buttdebounceT[5:1]};
            buttdebounceR <= {buttR, buttdebounceR[5:1]};
            
            state <= {state[6:0], state[7] ^ state[5] ^ state[4] ^ state[3]};
            if (movement_available) begin
                if (gametick) begin
                    movement_intent <= 1'b0; // intent 0 = natural movement
                    tetron_h <= tetron_h + 1'b1;
                    movement_available <= 1'b0;
                    movement_request <= 1'b1;
                end else begin
                    if (&buttdebounceL & !cooldown & movement_available) begin
                        movement_intent <= 1'b1;
                        tetron_v <= tetron_v + 1'b1;
                        movement_available <= 1'b0;
                        movement_request <= 1'b1;
                        cooldown <= 1'b1;
                    end else if (&buttdebounceR & !cooldown & movement_available) begin
                        movement_intent <= 1'b1;
                        tetron_v <= tetron_v - 1'b1;
                        movement_available <= 1'b0;
                        movement_request <= 1'b1;
                        cooldown <= 1'b1;
                    end else if (&buttdebounceT & !cooldown & movement_available) begin
                        movement_intent <= 1'b1;
                        tetron_rotation <= (tetron_rotation == 3'd3) ? 3'b0 : tetron_rotation + 1'b1;
                        movement_available <= 1'b0;
                        movement_request <= 1'b1;
                        cooldown <= 1'b1;
                    end

                    if (!(&buttdebounceL) & !(&buttdebounceR) & !(buttdebounceT)) begin
                        cooldown <= 1'b0;
                    end
                end
            end else begin
                if (movement_commit) begin
                    movement_request <= 1'b0;
                    movement_available <= 1'b1;
                    keep_tetron_h <= tetron_h;
                    keep_tetron_v <= tetron_v;
                    keep_tetron_rotation <= tetron_rotation;
                end

                if (movement_declined && !process_decline) begin
                    process_decline <= 1'b1;
                    movement_request <= 1'b0;
                end

                if (!movement_declined & process_decline) begin
                    process_decline <= 1'b0;
                    movement_available <= 1'b1;
                    tetron_h <= keep_tetron_h;
                    tetron_v <= keep_tetron_v;
                    tetron_rotation <= keep_tetron_rotation;
                end

                if (movement_steal & !process_steal) begin
                    movement_request <= 1'b0;
                    process_steal <= 1'b1;
                end

                if (!movement_steal & process_steal) begin
                    tetron_h <= 4'd5;
                    tetron_v <= 4'd5;
                    volatile_blk_color <= (state[2:0] == 3'b0) ? 3'b101 : state[2:0];
                    movement_available <= 1'b1;
                    process_steal <= 1'b0;
                end
            end
        end
    end


endmodule