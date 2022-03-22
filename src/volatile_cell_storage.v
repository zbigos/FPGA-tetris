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
    input wire buttD,

    output reg movement_request,
    output reg movement_intent,
    input wire movement_declined,
    input wire movement_commit,
    input wire movement_steal,

    output wire[4:0] P1blk_v,
    output wire[4:0] P1blk_h,
    output wire[4:0] P2blk_v,
    output wire[4:0] P2blk_h,
    output wire[4:0] P3blk_v,
    output wire[4:0] P3blk_h,
    output wire[4:0] P4blk_v,
    output wire[4:0] P4blk_h,

    output reg[2:0] volatile_blk_color
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
    wire [4:0] otetron_blk_h [4:0];
    wire [4:0] otetron_blk_v [4:0];
    wire [4:0] latetron_blk_h [4:0];
    wire [4:0] latetron_blk_v [4:0];
    wire [4:0] lbtetron_blk_h [4:0];
    wire [4:0] lbtetron_blk_v [4:0];
    wire [4:0] ttetron_blk_h [4:0];
    wire [4:0] ttetron_blk_v [4:0];
    wire [4:0] satetron_blk_h [4:0];
    wire [4:0] satetron_blk_v [4:0];
    wire [4:0] sbtetron_blk_h [4:0];
    wire [4:0] sbtetron_blk_v [4:0];


    assign P1blk_v = tetron_v + itetron_blk_v[0] + otetron_blk_v[0] + latetron_blk_v[0] + lbtetron_blk_v[0] + ttetron_blk_v[0] + satetron_blk_v[0] + sbtetron_blk_v[0];
    assign P2blk_v = tetron_v + itetron_blk_v[1] + otetron_blk_v[1] + latetron_blk_v[1] + lbtetron_blk_v[1] + ttetron_blk_v[1] + satetron_blk_v[1] + sbtetron_blk_v[1];
    assign P3blk_v = tetron_v + itetron_blk_v[2] + otetron_blk_v[2] + latetron_blk_v[2] + lbtetron_blk_v[2] + ttetron_blk_v[2] + satetron_blk_v[2] + sbtetron_blk_v[2];
    assign P4blk_v = tetron_v + itetron_blk_v[3] + otetron_blk_v[3] + latetron_blk_v[3] + lbtetron_blk_v[3] + ttetron_blk_v[3] + satetron_blk_v[3] + sbtetron_blk_v[3];
    assign P1blk_h = tetron_h + itetron_blk_h[0] + otetron_blk_h[0] + latetron_blk_h[0] + lbtetron_blk_h[0] + ttetron_blk_h[0] + satetron_blk_h[0] + sbtetron_blk_h[0];
    assign P2blk_h = tetron_h + itetron_blk_h[1] + otetron_blk_h[1] + latetron_blk_h[1] + lbtetron_blk_h[1] + ttetron_blk_h[1] + satetron_blk_h[1] + sbtetron_blk_h[1];
    assign P3blk_h = tetron_h + itetron_blk_h[2] + otetron_blk_h[2] + latetron_blk_h[2] + lbtetron_blk_h[2] + ttetron_blk_h[2] + satetron_blk_h[2] + sbtetron_blk_h[2];
    assign P4blk_h = tetron_h + itetron_blk_h[3] + otetron_blk_h[3] + latetron_blk_h[3] + lbtetron_blk_h[3] + ttetron_blk_h[3] + satetron_blk_h[3] + sbtetron_blk_h[3];
    
    tetron_I_shaper ishaper(
        .clk(clk),
        .active(tetron_type == 3'd0),
        .tetron_rotation(tetron_rotation),
        .blk1_voffset(itetron_blk_v[0]), .blk1_hoffset(itetron_blk_h[0]),
        .blk2_voffset(itetron_blk_v[1]), .blk2_hoffset(itetron_blk_h[1]),
        .blk3_voffset(itetron_blk_v[2]), .blk3_hoffset(itetron_blk_h[2]),
        .blk4_voffset(itetron_blk_v[3]), .blk4_hoffset(itetron_blk_h[3])
    );

    tetron_O_shaper oshaper(
        .clk(clk),
        .active(tetron_type == 3'd1),
        .tetron_rotation(tetron_rotation),
        .blk1_voffset(otetron_blk_v[0]), .blk1_hoffset(otetron_blk_h[0]),
        .blk2_voffset(otetron_blk_v[1]), .blk2_hoffset(otetron_blk_h[1]),
        .blk3_voffset(otetron_blk_v[2]), .blk3_hoffset(otetron_blk_h[2]),
        .blk4_voffset(otetron_blk_v[3]), .blk4_hoffset(otetron_blk_h[3])
    );

    tetron_La_shaper lashaper(
        .clk(clk),
        .active(tetron_type == 3'd2),
        .tetron_rotation(tetron_rotation),
        .blk1_voffset(latetron_blk_v[0]), .blk1_hoffset(latetron_blk_h[0]),
        .blk2_voffset(latetron_blk_v[1]), .blk2_hoffset(latetron_blk_h[1]),
        .blk3_voffset(latetron_blk_v[2]), .blk3_hoffset(latetron_blk_h[2]),
        .blk4_voffset(latetron_blk_v[3]), .blk4_hoffset(latetron_blk_h[3])
    );

    tetron_Lb_shaper lbshaper(
        .clk(clk),
        .active(tetron_type == 3'd3),
        .tetron_rotation(tetron_rotation),
        .blk1_voffset(lbtetron_blk_v[0]), .blk1_hoffset(lbtetron_blk_h[0]),
        .blk2_voffset(lbtetron_blk_v[1]), .blk2_hoffset(lbtetron_blk_h[1]),
        .blk3_voffset(lbtetron_blk_v[2]), .blk3_hoffset(lbtetron_blk_h[2]),
        .blk4_voffset(lbtetron_blk_v[3]), .blk4_hoffset(lbtetron_blk_h[3])
    );


    tetron_T_shaper tshaper(
        .clk(clk),
        .active(tetron_type == 3'd4),
        .tetron_rotation(tetron_rotation),
        .blk1_voffset(ttetron_blk_v[0]), .blk1_hoffset(ttetron_blk_h[0]),
        .blk2_voffset(ttetron_blk_v[1]), .blk2_hoffset(ttetron_blk_h[1]),
        .blk3_voffset(ttetron_blk_v[2]), .blk3_hoffset(ttetron_blk_h[2]),
        .blk4_voffset(ttetron_blk_v[3]), .blk4_hoffset(ttetron_blk_h[3])
    );

    tetron_Sa_shaper sashaper(
        .clk(clk),
        .active(tetron_type == 3'd5),
        .tetron_rotation(tetron_rotation),
        .blk1_voffset(satetron_blk_v[0]), .blk1_hoffset(satetron_blk_h[0]),
        .blk2_voffset(satetron_blk_v[1]), .blk2_hoffset(satetron_blk_h[1]),
        .blk3_voffset(satetron_blk_v[2]), .blk3_hoffset(satetron_blk_h[2]),
        .blk4_voffset(satetron_blk_v[3]), .blk4_hoffset(satetron_blk_h[3])
    );

    tetron_Sb_shaper sbshaper(
        .clk(clk),
        .active(tetron_type == 3'd6),
        .tetron_rotation(tetron_rotation),
        .blk1_voffset(sbtetron_blk_v[0]), .blk1_hoffset(sbtetron_blk_h[0]),
        .blk2_voffset(sbtetron_blk_v[1]), .blk2_hoffset(sbtetron_blk_h[1]),
        .blk3_voffset(sbtetron_blk_v[2]), .blk3_hoffset(sbtetron_blk_h[2]),
        .blk4_voffset(sbtetron_blk_v[3]), .blk4_hoffset(sbtetron_blk_h[3])
    );


    reg movement_available;
    reg [5:0] cooldown;
    reg postdecline_cool;
    reg process_steal;
    reg [7:0] state;
    reg [25:0] buttdebounceL;
    reg [25:0] buttdebounceR;
    reg [25:0] buttdebounceT;
    reg [25:0] buttdebounceD;
    reg process_decline;
    reg dropit;
    assign led = 1'b0;
    reg [5:0] dropcool;
    always @(posedge clk) begin
        if (!reset) begin
            process_decline <= 1'b0;
            cooldown <= 1'b0;
            tetron_type <= 3'd0;
            tetron_v <= 4'd5;
            tetron_h <= 4'd1;
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
            buttdebounceD <= 6'b0;
            buttdebounceR <= 6'b0;
            postdecline_cool <= 1'b0;
            keep_tetron_rotation <= 3'b0;
            dropit <= 1'b0;
            dropcool <= 6'd16;
        end else begin
            buttdebounceL <= {!buttL, buttdebounceL[25:1]};
            buttdebounceT <= {!buttT, buttdebounceT[25:1]};
            buttdebounceR <= {!buttR, buttdebounceR[25:1]};
            buttdebounceD <= {!buttD, buttdebounceD[25:1]};

            state <= {state[6:0], state[7] ^ state[5] ^ state[4] ^ state[3]};
            if (movement_available & !movement_request) begin
                if (gametick) begin
                    movement_intent <= 1'b0; // intent 0 = natural movement
                    tetron_h <= tetron_h + 1'b1;
                    movement_available <= 1'b0;
                    movement_request <= 1'b1;
                end else begin
                    if (dropit) begin
                        if (dropcool == 6'b0) begin
                            movement_intent <= 1'b0;
                            tetron_h <= tetron_h + 1'b1;
                            movement_available <= 1'b0;
                            movement_request <= 1'b1;
                            cooldown <= 1'b1;
                            dropcool <= 6'd16;
                        end else begin
                            dropcool <= dropcool - 1'b1;
                        end
                    end else if (!dropit & &buttdebounceD & (dropcool == 0) & movement_available) begin
                        dropit <= 1'b1;
                        dropcool <= 6'd16;
                    end else if (!dropit & &buttdebounceL & (dropcool == 0) & movement_available) begin
                        movement_intent <= 1'b1;
                        tetron_v <= tetron_v + 1'b1;
                        movement_available <= 1'b0;
                        movement_request <= 1'b1;
                        dropcool <= 6'd16;
                    end else if (!dropit & buttdebounceR & (dropcool == 0) & movement_available) begin
                        movement_intent <= 1'b1;
                        tetron_v <= tetron_v - 1'b1;
                        movement_available <= 1'b0;
                        movement_request <= 1'b1;
                        dropcool <= 6'd16;
                    end else if (!dropit & buttdebounceT & (dropcool == 0) & movement_available) begin
                        movement_intent <= 1'b1;
                        tetron_rotation <= (tetron_rotation == 3'd3) ? 3'b0 : tetron_rotation + 1'b1;
                        movement_available <= 1'b0;
                        movement_request <= 1'b1;
                        dropcool <= 6'd16;
                    end else if (dropcool > 0) begin
                        if (!(|buttdebounceD) & !(|buttdebounceL) & !(|buttdebounceR) & !(|buttdebounceT))
                            dropcool <= dropcool - 1'b1;
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
                    dropit <= 1'b0;
                end

                if (!movement_declined & process_decline) begin
                    process_decline <= 1'b0;
                    movement_available <= 1'b1;
                    tetron_h <= keep_tetron_h;
                    tetron_v <= keep_tetron_v;
                    tetron_rotation <= keep_tetron_rotation;
                    dropit <= 1'b0;
                end

                if (movement_steal & !process_steal) begin
                    movement_request <= 1'b0;
                    process_steal <= 1'b1;
                    dropit <= 1'b0;
                end

                if (!movement_steal & process_steal) begin
                    tetron_h <= 4'd1;
                    tetron_v <= 4'd5;
                    volatile_blk_color <= (state[2:0] == 3'b0) ? 3'b101 : state[2:0];
                    tetron_type <= (state % 16) % 7;
                    movement_available <= 1'b1;
                    process_steal <= 1'b0;
                    keep_tetron_rotation <= 3'b0;
                    tetron_rotation <= 2'b00;
                    dropit <= 1'b0;
                end
            end
        end
    end


endmodule