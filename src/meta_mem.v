
`default_nettype none

module memory (
    input wire clk,
    input wire reset,
    input wire memory_busy,

    // color reading
    input wire[5:0] color_requestor_x,
    input wire[5:0] color_requestor_y,
    output wire[2:0] color_getter,

    // color writing
    input wire[5:0] color_set_requestor_x,
    input wire[5:0] color_set_requestor_y,
    input wire color_commit,
    input wire[2:0] color_setter,

    // hitboxes
    input wire [5:0] hitbox_checker_0_x,
    input wire [5:0] hitbox_checker_0_y,
    input wire [5:0] hitbox_checker_1_x,
    input wire [5:0] hitbox_checker_1_y,
    input wire [5:0] hitbox_checker_2_x,
    input wire [5:0] hitbox_checker_2_y,
    input wire [5:0] hitbox_checker_3_x,
    input wire [5:0] hitbox_checker_3_y,
    output wire[3:0] hitbox_status,

    output wire [22:0] rowfull_stat,
    input wire [22:0] rowshift_cmd,
    
);

    wire [22:0] hitscan0;
    wire [22:0] hitscan1;
    wire [22:0] hitscan2;
    wire [22:0] hitscan3;


    wire [2:0] cellswap_layers_0_1_cell_0;
    wire [2:0] cellswap_layers_0_1_cell_1;
    wire [2:0] cellswap_layers_0_1_cell_2;
    wire [2:0] cellswap_layers_0_1_cell_3;
    wire [2:0] cellswap_layers_0_1_cell_4;
    wire [2:0] cellswap_layers_0_1_cell_5;
    wire [2:0] cellswap_layers_0_1_cell_6;
    wire [2:0] cellswap_layers_0_1_cell_7;
    wire [2:0] cellswap_layers_0_1_cell_8;
    wire [2:0] cellswap_layers_0_1_cell_9;
    wire [2:0] cellswap_layers_0_1_cell_10;
    wire [2:0] cellswap_layers_0_1_cell_11;
    wire [2:0] cellswap_layers_1_2_cell_0;
    wire [2:0] cellswap_layers_1_2_cell_1;
    wire [2:0] cellswap_layers_1_2_cell_2;
    wire [2:0] cellswap_layers_1_2_cell_3;
    wire [2:0] cellswap_layers_1_2_cell_4;
    wire [2:0] cellswap_layers_1_2_cell_5;
    wire [2:0] cellswap_layers_1_2_cell_6;
    wire [2:0] cellswap_layers_1_2_cell_7;
    wire [2:0] cellswap_layers_1_2_cell_8;
    wire [2:0] cellswap_layers_1_2_cell_9;
    wire [2:0] cellswap_layers_1_2_cell_10;
    wire [2:0] cellswap_layers_1_2_cell_11;
    wire [2:0] cellswap_layers_2_3_cell_0;
    wire [2:0] cellswap_layers_2_3_cell_1;
    wire [2:0] cellswap_layers_2_3_cell_2;
    wire [2:0] cellswap_layers_2_3_cell_3;
    wire [2:0] cellswap_layers_2_3_cell_4;
    wire [2:0] cellswap_layers_2_3_cell_5;
    wire [2:0] cellswap_layers_2_3_cell_6;
    wire [2:0] cellswap_layers_2_3_cell_7;
    wire [2:0] cellswap_layers_2_3_cell_8;
    wire [2:0] cellswap_layers_2_3_cell_9;
    wire [2:0] cellswap_layers_2_3_cell_10;
    wire [2:0] cellswap_layers_2_3_cell_11;
    wire [2:0] cellswap_layers_3_4_cell_0;
    wire [2:0] cellswap_layers_3_4_cell_1;
    wire [2:0] cellswap_layers_3_4_cell_2;
    wire [2:0] cellswap_layers_3_4_cell_3;
    wire [2:0] cellswap_layers_3_4_cell_4;
    wire [2:0] cellswap_layers_3_4_cell_5;
    wire [2:0] cellswap_layers_3_4_cell_6;
    wire [2:0] cellswap_layers_3_4_cell_7;
    wire [2:0] cellswap_layers_3_4_cell_8;
    wire [2:0] cellswap_layers_3_4_cell_9;
    wire [2:0] cellswap_layers_3_4_cell_10;
    wire [2:0] cellswap_layers_3_4_cell_11;
    wire [2:0] cellswap_layers_4_5_cell_0;
    wire [2:0] cellswap_layers_4_5_cell_1;
    wire [2:0] cellswap_layers_4_5_cell_2;
    wire [2:0] cellswap_layers_4_5_cell_3;
    wire [2:0] cellswap_layers_4_5_cell_4;
    wire [2:0] cellswap_layers_4_5_cell_5;
    wire [2:0] cellswap_layers_4_5_cell_6;
    wire [2:0] cellswap_layers_4_5_cell_7;
    wire [2:0] cellswap_layers_4_5_cell_8;
    wire [2:0] cellswap_layers_4_5_cell_9;
    wire [2:0] cellswap_layers_4_5_cell_10;
    wire [2:0] cellswap_layers_4_5_cell_11;
    wire [2:0] cellswap_layers_5_6_cell_0;
    wire [2:0] cellswap_layers_5_6_cell_1;
    wire [2:0] cellswap_layers_5_6_cell_2;
    wire [2:0] cellswap_layers_5_6_cell_3;
    wire [2:0] cellswap_layers_5_6_cell_4;
    wire [2:0] cellswap_layers_5_6_cell_5;
    wire [2:0] cellswap_layers_5_6_cell_6;
    wire [2:0] cellswap_layers_5_6_cell_7;
    wire [2:0] cellswap_layers_5_6_cell_8;
    wire [2:0] cellswap_layers_5_6_cell_9;
    wire [2:0] cellswap_layers_5_6_cell_10;
    wire [2:0] cellswap_layers_5_6_cell_11;
    wire [2:0] cellswap_layers_6_7_cell_0;
    wire [2:0] cellswap_layers_6_7_cell_1;
    wire [2:0] cellswap_layers_6_7_cell_2;
    wire [2:0] cellswap_layers_6_7_cell_3;
    wire [2:0] cellswap_layers_6_7_cell_4;
    wire [2:0] cellswap_layers_6_7_cell_5;
    wire [2:0] cellswap_layers_6_7_cell_6;
    wire [2:0] cellswap_layers_6_7_cell_7;
    wire [2:0] cellswap_layers_6_7_cell_8;
    wire [2:0] cellswap_layers_6_7_cell_9;
    wire [2:0] cellswap_layers_6_7_cell_10;
    wire [2:0] cellswap_layers_6_7_cell_11;
    wire [2:0] cellswap_layers_7_8_cell_0;
    wire [2:0] cellswap_layers_7_8_cell_1;
    wire [2:0] cellswap_layers_7_8_cell_2;
    wire [2:0] cellswap_layers_7_8_cell_3;
    wire [2:0] cellswap_layers_7_8_cell_4;
    wire [2:0] cellswap_layers_7_8_cell_5;
    wire [2:0] cellswap_layers_7_8_cell_6;
    wire [2:0] cellswap_layers_7_8_cell_7;
    wire [2:0] cellswap_layers_7_8_cell_8;
    wire [2:0] cellswap_layers_7_8_cell_9;
    wire [2:0] cellswap_layers_7_8_cell_10;
    wire [2:0] cellswap_layers_7_8_cell_11;
    wire [2:0] cellswap_layers_8_9_cell_0;
    wire [2:0] cellswap_layers_8_9_cell_1;
    wire [2:0] cellswap_layers_8_9_cell_2;
    wire [2:0] cellswap_layers_8_9_cell_3;
    wire [2:0] cellswap_layers_8_9_cell_4;
    wire [2:0] cellswap_layers_8_9_cell_5;
    wire [2:0] cellswap_layers_8_9_cell_6;
    wire [2:0] cellswap_layers_8_9_cell_7;
    wire [2:0] cellswap_layers_8_9_cell_8;
    wire [2:0] cellswap_layers_8_9_cell_9;
    wire [2:0] cellswap_layers_8_9_cell_10;
    wire [2:0] cellswap_layers_8_9_cell_11;
    wire [2:0] cellswap_layers_9_10_cell_0;
    wire [2:0] cellswap_layers_9_10_cell_1;
    wire [2:0] cellswap_layers_9_10_cell_2;
    wire [2:0] cellswap_layers_9_10_cell_3;
    wire [2:0] cellswap_layers_9_10_cell_4;
    wire [2:0] cellswap_layers_9_10_cell_5;
    wire [2:0] cellswap_layers_9_10_cell_6;
    wire [2:0] cellswap_layers_9_10_cell_7;
    wire [2:0] cellswap_layers_9_10_cell_8;
    wire [2:0] cellswap_layers_9_10_cell_9;
    wire [2:0] cellswap_layers_9_10_cell_10;
    wire [2:0] cellswap_layers_9_10_cell_11;
    wire [2:0] cellswap_layers_10_11_cell_0;
    wire [2:0] cellswap_layers_10_11_cell_1;
    wire [2:0] cellswap_layers_10_11_cell_2;
    wire [2:0] cellswap_layers_10_11_cell_3;
    wire [2:0] cellswap_layers_10_11_cell_4;
    wire [2:0] cellswap_layers_10_11_cell_5;
    wire [2:0] cellswap_layers_10_11_cell_6;
    wire [2:0] cellswap_layers_10_11_cell_7;
    wire [2:0] cellswap_layers_10_11_cell_8;
    wire [2:0] cellswap_layers_10_11_cell_9;
    wire [2:0] cellswap_layers_10_11_cell_10;
    wire [2:0] cellswap_layers_10_11_cell_11;
    wire [2:0] cellswap_layers_11_12_cell_0;
    wire [2:0] cellswap_layers_11_12_cell_1;
    wire [2:0] cellswap_layers_11_12_cell_2;
    wire [2:0] cellswap_layers_11_12_cell_3;
    wire [2:0] cellswap_layers_11_12_cell_4;
    wire [2:0] cellswap_layers_11_12_cell_5;
    wire [2:0] cellswap_layers_11_12_cell_6;
    wire [2:0] cellswap_layers_11_12_cell_7;
    wire [2:0] cellswap_layers_11_12_cell_8;
    wire [2:0] cellswap_layers_11_12_cell_9;
    wire [2:0] cellswap_layers_11_12_cell_10;
    wire [2:0] cellswap_layers_11_12_cell_11;
    wire [2:0] cellswap_layers_12_13_cell_0;
    wire [2:0] cellswap_layers_12_13_cell_1;
    wire [2:0] cellswap_layers_12_13_cell_2;
    wire [2:0] cellswap_layers_12_13_cell_3;
    wire [2:0] cellswap_layers_12_13_cell_4;
    wire [2:0] cellswap_layers_12_13_cell_5;
    wire [2:0] cellswap_layers_12_13_cell_6;
    wire [2:0] cellswap_layers_12_13_cell_7;
    wire [2:0] cellswap_layers_12_13_cell_8;
    wire [2:0] cellswap_layers_12_13_cell_9;
    wire [2:0] cellswap_layers_12_13_cell_10;
    wire [2:0] cellswap_layers_12_13_cell_11;
    wire [2:0] cellswap_layers_13_14_cell_0;
    wire [2:0] cellswap_layers_13_14_cell_1;
    wire [2:0] cellswap_layers_13_14_cell_2;
    wire [2:0] cellswap_layers_13_14_cell_3;
    wire [2:0] cellswap_layers_13_14_cell_4;
    wire [2:0] cellswap_layers_13_14_cell_5;
    wire [2:0] cellswap_layers_13_14_cell_6;
    wire [2:0] cellswap_layers_13_14_cell_7;
    wire [2:0] cellswap_layers_13_14_cell_8;
    wire [2:0] cellswap_layers_13_14_cell_9;
    wire [2:0] cellswap_layers_13_14_cell_10;
    wire [2:0] cellswap_layers_13_14_cell_11;
    wire [2:0] cellswap_layers_14_15_cell_0;
    wire [2:0] cellswap_layers_14_15_cell_1;
    wire [2:0] cellswap_layers_14_15_cell_2;
    wire [2:0] cellswap_layers_14_15_cell_3;
    wire [2:0] cellswap_layers_14_15_cell_4;
    wire [2:0] cellswap_layers_14_15_cell_5;
    wire [2:0] cellswap_layers_14_15_cell_6;
    wire [2:0] cellswap_layers_14_15_cell_7;
    wire [2:0] cellswap_layers_14_15_cell_8;
    wire [2:0] cellswap_layers_14_15_cell_9;
    wire [2:0] cellswap_layers_14_15_cell_10;
    wire [2:0] cellswap_layers_14_15_cell_11;
    wire [2:0] cellswap_layers_15_16_cell_0;
    wire [2:0] cellswap_layers_15_16_cell_1;
    wire [2:0] cellswap_layers_15_16_cell_2;
    wire [2:0] cellswap_layers_15_16_cell_3;
    wire [2:0] cellswap_layers_15_16_cell_4;
    wire [2:0] cellswap_layers_15_16_cell_5;
    wire [2:0] cellswap_layers_15_16_cell_6;
    wire [2:0] cellswap_layers_15_16_cell_7;
    wire [2:0] cellswap_layers_15_16_cell_8;
    wire [2:0] cellswap_layers_15_16_cell_9;
    wire [2:0] cellswap_layers_15_16_cell_10;
    wire [2:0] cellswap_layers_15_16_cell_11;
    wire [2:0] cellswap_layers_16_17_cell_0;
    wire [2:0] cellswap_layers_16_17_cell_1;
    wire [2:0] cellswap_layers_16_17_cell_2;
    wire [2:0] cellswap_layers_16_17_cell_3;
    wire [2:0] cellswap_layers_16_17_cell_4;
    wire [2:0] cellswap_layers_16_17_cell_5;
    wire [2:0] cellswap_layers_16_17_cell_6;
    wire [2:0] cellswap_layers_16_17_cell_7;
    wire [2:0] cellswap_layers_16_17_cell_8;
    wire [2:0] cellswap_layers_16_17_cell_9;
    wire [2:0] cellswap_layers_16_17_cell_10;
    wire [2:0] cellswap_layers_16_17_cell_11;
    wire [2:0] cellswap_layers_17_18_cell_0;
    wire [2:0] cellswap_layers_17_18_cell_1;
    wire [2:0] cellswap_layers_17_18_cell_2;
    wire [2:0] cellswap_layers_17_18_cell_3;
    wire [2:0] cellswap_layers_17_18_cell_4;
    wire [2:0] cellswap_layers_17_18_cell_5;
    wire [2:0] cellswap_layers_17_18_cell_6;
    wire [2:0] cellswap_layers_17_18_cell_7;
    wire [2:0] cellswap_layers_17_18_cell_8;
    wire [2:0] cellswap_layers_17_18_cell_9;
    wire [2:0] cellswap_layers_17_18_cell_10;
    wire [2:0] cellswap_layers_17_18_cell_11;
    wire [2:0] cellswap_layers_18_19_cell_0;
    wire [2:0] cellswap_layers_18_19_cell_1;
    wire [2:0] cellswap_layers_18_19_cell_2;
    wire [2:0] cellswap_layers_18_19_cell_3;
    wire [2:0] cellswap_layers_18_19_cell_4;
    wire [2:0] cellswap_layers_18_19_cell_5;
    wire [2:0] cellswap_layers_18_19_cell_6;
    wire [2:0] cellswap_layers_18_19_cell_7;
    wire [2:0] cellswap_layers_18_19_cell_8;
    wire [2:0] cellswap_layers_18_19_cell_9;
    wire [2:0] cellswap_layers_18_19_cell_10;
    wire [2:0] cellswap_layers_18_19_cell_11;
    wire [2:0] cellswap_layers_19_20_cell_0;
    wire [2:0] cellswap_layers_19_20_cell_1;
    wire [2:0] cellswap_layers_19_20_cell_2;
    wire [2:0] cellswap_layers_19_20_cell_3;
    wire [2:0] cellswap_layers_19_20_cell_4;
    wire [2:0] cellswap_layers_19_20_cell_5;
    wire [2:0] cellswap_layers_19_20_cell_6;
    wire [2:0] cellswap_layers_19_20_cell_7;
    wire [2:0] cellswap_layers_19_20_cell_8;
    wire [2:0] cellswap_layers_19_20_cell_9;
    wire [2:0] cellswap_layers_19_20_cell_10;
    wire [2:0] cellswap_layers_19_20_cell_11;
    wire [2:0] cellswap_layers_20_21_cell_0;
    wire [2:0] cellswap_layers_20_21_cell_1;
    wire [2:0] cellswap_layers_20_21_cell_2;
    wire [2:0] cellswap_layers_20_21_cell_3;
    wire [2:0] cellswap_layers_20_21_cell_4;
    wire [2:0] cellswap_layers_20_21_cell_5;
    wire [2:0] cellswap_layers_20_21_cell_6;
    wire [2:0] cellswap_layers_20_21_cell_7;
    wire [2:0] cellswap_layers_20_21_cell_8;
    wire [2:0] cellswap_layers_20_21_cell_9;
    wire [2:0] cellswap_layers_20_21_cell_10;
    wire [2:0] cellswap_layers_20_21_cell_11;


    wire [2:0] row_color_0;
    wire rfull_0;
    assign rowfull_stat[0] = rfull_0 & 1'b1;
    memcell_row row_0(
        .clk(clk),
        .reset(reset),
        .advance_row((rowshift_cmd[0] & 1'b1)),
        .color_setter(color_setter),
        .write_row_selector(color_set_requestor_x),
        .write_commiter(color_commit & (color_set_requestor_y == 6'd0)),
        .row_full(rfull_0),
        .hitbox_checker_0(hitbox_checker_0_x),
        .hitbox_checker_1(hitbox_checker_1_x),
        .hitbox_checker_2(hitbox_checker_2_x),
        .hitbox_checker_3(hitbox_checker_3_x),
        .hitbox_status({hitscan0[0], hitscan1[0], hitscan2[0], hitscan3[0]}),
        .gpu_color(row_color_0),
        .color_requestor(color_requestor_x),
        .rowswap_read_cell_0(3'b0),
        .rowswap_read_cell_1(3'b0),
        .rowswap_read_cell_2(3'b0),
        .rowswap_read_cell_3(3'b0),
        .rowswap_read_cell_4(3'b0),
        .rowswap_read_cell_5(3'b0),
        .rowswap_read_cell_6(3'b0),
        .rowswap_read_cell_7(3'b0),
        .rowswap_read_cell_8(3'b0),
        .rowswap_read_cell_9(3'b0),
        .rowswap_read_cell_10(3'b0),
        .rowswap_read_cell_11(3'b0),
        .rowswap_write_cell_0(cellswap_layers_0_1_cell_0),
        .rowswap_write_cell_1(cellswap_layers_0_1_cell_1),
        .rowswap_write_cell_2(cellswap_layers_0_1_cell_2),
        .rowswap_write_cell_3(cellswap_layers_0_1_cell_3),
        .rowswap_write_cell_4(cellswap_layers_0_1_cell_4),
        .rowswap_write_cell_5(cellswap_layers_0_1_cell_5),
        .rowswap_write_cell_6(cellswap_layers_0_1_cell_6),
        .rowswap_write_cell_7(cellswap_layers_0_1_cell_7),
        .rowswap_write_cell_8(cellswap_layers_0_1_cell_8),
        .rowswap_write_cell_9(cellswap_layers_0_1_cell_9),
        .rowswap_write_cell_10(cellswap_layers_0_1_cell_10),
        .rowswap_write_cell_11(cellswap_layers_0_1_cell_11),
    );
    

    wire [2:0] row_color_1;
    wire rfull_1;
    assign rowfull_stat[1] = rfull_1 & 1'b1;
    memcell_row row_1(
        .clk(clk),
        .reset(reset),
        .advance_row((rowshift_cmd[1] & 1'b1)),
        .color_setter(color_setter),
        .write_row_selector(color_set_requestor_x),
        .write_commiter(color_commit & (color_set_requestor_y == 6'd1)),
        .row_full(rfull_1),
        .hitbox_checker_0(hitbox_checker_0_x),
        .hitbox_checker_1(hitbox_checker_1_x),
        .hitbox_checker_2(hitbox_checker_2_x),
        .hitbox_checker_3(hitbox_checker_3_x),
        .hitbox_status({hitscan0[1], hitscan1[1], hitscan2[1], hitscan3[1]}),
        .gpu_color(row_color_1),
        .color_requestor(color_requestor_x),
        .rowswap_read_cell_0(cellswap_layers_0_1_cell_0),
        .rowswap_read_cell_1(cellswap_layers_0_1_cell_1),
        .rowswap_read_cell_2(cellswap_layers_0_1_cell_2),
        .rowswap_read_cell_3(cellswap_layers_0_1_cell_3),
        .rowswap_read_cell_4(cellswap_layers_0_1_cell_4),
        .rowswap_read_cell_5(cellswap_layers_0_1_cell_5),
        .rowswap_read_cell_6(cellswap_layers_0_1_cell_6),
        .rowswap_read_cell_7(cellswap_layers_0_1_cell_7),
        .rowswap_read_cell_8(cellswap_layers_0_1_cell_8),
        .rowswap_read_cell_9(cellswap_layers_0_1_cell_9),
        .rowswap_read_cell_10(cellswap_layers_0_1_cell_10),
        .rowswap_read_cell_11(cellswap_layers_0_1_cell_11),
        .rowswap_write_cell_0(cellswap_layers_1_2_cell_0),
        .rowswap_write_cell_1(cellswap_layers_1_2_cell_1),
        .rowswap_write_cell_2(cellswap_layers_1_2_cell_2),
        .rowswap_write_cell_3(cellswap_layers_1_2_cell_3),
        .rowswap_write_cell_4(cellswap_layers_1_2_cell_4),
        .rowswap_write_cell_5(cellswap_layers_1_2_cell_5),
        .rowswap_write_cell_6(cellswap_layers_1_2_cell_6),
        .rowswap_write_cell_7(cellswap_layers_1_2_cell_7),
        .rowswap_write_cell_8(cellswap_layers_1_2_cell_8),
        .rowswap_write_cell_9(cellswap_layers_1_2_cell_9),
        .rowswap_write_cell_10(cellswap_layers_1_2_cell_10),
        .rowswap_write_cell_11(cellswap_layers_1_2_cell_11),
    );
    

    wire [2:0] row_color_2;
    wire rfull_2;
    assign rowfull_stat[2] = rfull_2 & 1'b1;
    memcell_row row_2(
        .clk(clk),
        .reset(reset),
        .advance_row((rowshift_cmd[2] & 1'b1)),
        .color_setter(color_setter),
        .write_row_selector(color_set_requestor_x),
        .write_commiter(color_commit & (color_set_requestor_y == 6'd2)),
        .row_full(rfull_2),
        .hitbox_checker_0(hitbox_checker_0_x),
        .hitbox_checker_1(hitbox_checker_1_x),
        .hitbox_checker_2(hitbox_checker_2_x),
        .hitbox_checker_3(hitbox_checker_3_x),
        .hitbox_status({hitscan0[2], hitscan1[2], hitscan2[2], hitscan3[2]}),
        .gpu_color(row_color_2),
        .color_requestor(color_requestor_x),
        .rowswap_read_cell_0(cellswap_layers_1_2_cell_0),
        .rowswap_read_cell_1(cellswap_layers_1_2_cell_1),
        .rowswap_read_cell_2(cellswap_layers_1_2_cell_2),
        .rowswap_read_cell_3(cellswap_layers_1_2_cell_3),
        .rowswap_read_cell_4(cellswap_layers_1_2_cell_4),
        .rowswap_read_cell_5(cellswap_layers_1_2_cell_5),
        .rowswap_read_cell_6(cellswap_layers_1_2_cell_6),
        .rowswap_read_cell_7(cellswap_layers_1_2_cell_7),
        .rowswap_read_cell_8(cellswap_layers_1_2_cell_8),
        .rowswap_read_cell_9(cellswap_layers_1_2_cell_9),
        .rowswap_read_cell_10(cellswap_layers_1_2_cell_10),
        .rowswap_read_cell_11(cellswap_layers_1_2_cell_11),
        .rowswap_write_cell_0(cellswap_layers_2_3_cell_0),
        .rowswap_write_cell_1(cellswap_layers_2_3_cell_1),
        .rowswap_write_cell_2(cellswap_layers_2_3_cell_2),
        .rowswap_write_cell_3(cellswap_layers_2_3_cell_3),
        .rowswap_write_cell_4(cellswap_layers_2_3_cell_4),
        .rowswap_write_cell_5(cellswap_layers_2_3_cell_5),
        .rowswap_write_cell_6(cellswap_layers_2_3_cell_6),
        .rowswap_write_cell_7(cellswap_layers_2_3_cell_7),
        .rowswap_write_cell_8(cellswap_layers_2_3_cell_8),
        .rowswap_write_cell_9(cellswap_layers_2_3_cell_9),
        .rowswap_write_cell_10(cellswap_layers_2_3_cell_10),
        .rowswap_write_cell_11(cellswap_layers_2_3_cell_11),
    );
    

    wire [2:0] row_color_3;
    wire rfull_3;
    assign rowfull_stat[3] = rfull_3 & 1'b1;
    memcell_row row_3(
        .clk(clk),
        .reset(reset),
        .advance_row((rowshift_cmd[3] & 1'b1)),
        .color_setter(color_setter),
        .write_row_selector(color_set_requestor_x),
        .write_commiter(color_commit & (color_set_requestor_y == 6'd3)),
        .row_full(rfull_3),
        .hitbox_checker_0(hitbox_checker_0_x),
        .hitbox_checker_1(hitbox_checker_1_x),
        .hitbox_checker_2(hitbox_checker_2_x),
        .hitbox_checker_3(hitbox_checker_3_x),
        .hitbox_status({hitscan0[3], hitscan1[3], hitscan2[3], hitscan3[3]}),
        .gpu_color(row_color_3),
        .color_requestor(color_requestor_x),
        .rowswap_read_cell_0(cellswap_layers_2_3_cell_0),
        .rowswap_read_cell_1(cellswap_layers_2_3_cell_1),
        .rowswap_read_cell_2(cellswap_layers_2_3_cell_2),
        .rowswap_read_cell_3(cellswap_layers_2_3_cell_3),
        .rowswap_read_cell_4(cellswap_layers_2_3_cell_4),
        .rowswap_read_cell_5(cellswap_layers_2_3_cell_5),
        .rowswap_read_cell_6(cellswap_layers_2_3_cell_6),
        .rowswap_read_cell_7(cellswap_layers_2_3_cell_7),
        .rowswap_read_cell_8(cellswap_layers_2_3_cell_8),
        .rowswap_read_cell_9(cellswap_layers_2_3_cell_9),
        .rowswap_read_cell_10(cellswap_layers_2_3_cell_10),
        .rowswap_read_cell_11(cellswap_layers_2_3_cell_11),
        .rowswap_write_cell_0(cellswap_layers_3_4_cell_0),
        .rowswap_write_cell_1(cellswap_layers_3_4_cell_1),
        .rowswap_write_cell_2(cellswap_layers_3_4_cell_2),
        .rowswap_write_cell_3(cellswap_layers_3_4_cell_3),
        .rowswap_write_cell_4(cellswap_layers_3_4_cell_4),
        .rowswap_write_cell_5(cellswap_layers_3_4_cell_5),
        .rowswap_write_cell_6(cellswap_layers_3_4_cell_6),
        .rowswap_write_cell_7(cellswap_layers_3_4_cell_7),
        .rowswap_write_cell_8(cellswap_layers_3_4_cell_8),
        .rowswap_write_cell_9(cellswap_layers_3_4_cell_9),
        .rowswap_write_cell_10(cellswap_layers_3_4_cell_10),
        .rowswap_write_cell_11(cellswap_layers_3_4_cell_11),
    );
    

    wire [2:0] row_color_4;
    wire rfull_4;
    assign rowfull_stat[4] = rfull_4 & 1'b1;
    memcell_row row_4(
        .clk(clk),
        .reset(reset),
        .advance_row((rowshift_cmd[4] & 1'b1)),
        .color_setter(color_setter),
        .write_row_selector(color_set_requestor_x),
        .write_commiter(color_commit & (color_set_requestor_y == 6'd4)),
        .row_full(rfull_4),
        .hitbox_checker_0(hitbox_checker_0_x),
        .hitbox_checker_1(hitbox_checker_1_x),
        .hitbox_checker_2(hitbox_checker_2_x),
        .hitbox_checker_3(hitbox_checker_3_x),
        .hitbox_status({hitscan0[4], hitscan1[4], hitscan2[4], hitscan3[4]}),
        .gpu_color(row_color_4),
        .color_requestor(color_requestor_x),
        .rowswap_read_cell_0(cellswap_layers_3_4_cell_0),
        .rowswap_read_cell_1(cellswap_layers_3_4_cell_1),
        .rowswap_read_cell_2(cellswap_layers_3_4_cell_2),
        .rowswap_read_cell_3(cellswap_layers_3_4_cell_3),
        .rowswap_read_cell_4(cellswap_layers_3_4_cell_4),
        .rowswap_read_cell_5(cellswap_layers_3_4_cell_5),
        .rowswap_read_cell_6(cellswap_layers_3_4_cell_6),
        .rowswap_read_cell_7(cellswap_layers_3_4_cell_7),
        .rowswap_read_cell_8(cellswap_layers_3_4_cell_8),
        .rowswap_read_cell_9(cellswap_layers_3_4_cell_9),
        .rowswap_read_cell_10(cellswap_layers_3_4_cell_10),
        .rowswap_read_cell_11(cellswap_layers_3_4_cell_11),
        .rowswap_write_cell_0(cellswap_layers_4_5_cell_0),
        .rowswap_write_cell_1(cellswap_layers_4_5_cell_1),
        .rowswap_write_cell_2(cellswap_layers_4_5_cell_2),
        .rowswap_write_cell_3(cellswap_layers_4_5_cell_3),
        .rowswap_write_cell_4(cellswap_layers_4_5_cell_4),
        .rowswap_write_cell_5(cellswap_layers_4_5_cell_5),
        .rowswap_write_cell_6(cellswap_layers_4_5_cell_6),
        .rowswap_write_cell_7(cellswap_layers_4_5_cell_7),
        .rowswap_write_cell_8(cellswap_layers_4_5_cell_8),
        .rowswap_write_cell_9(cellswap_layers_4_5_cell_9),
        .rowswap_write_cell_10(cellswap_layers_4_5_cell_10),
        .rowswap_write_cell_11(cellswap_layers_4_5_cell_11),
    );
    

    wire [2:0] row_color_5;
    wire rfull_5;
    assign rowfull_stat[5] = rfull_5 & 1'b1;
    memcell_row row_5(
        .clk(clk),
        .reset(reset),
        .advance_row((rowshift_cmd[5] & 1'b1)),
        .color_setter(color_setter),
        .write_row_selector(color_set_requestor_x),
        .write_commiter(color_commit & (color_set_requestor_y == 6'd5)),
        .row_full(rfull_5),
        .hitbox_checker_0(hitbox_checker_0_x),
        .hitbox_checker_1(hitbox_checker_1_x),
        .hitbox_checker_2(hitbox_checker_2_x),
        .hitbox_checker_3(hitbox_checker_3_x),
        .hitbox_status({hitscan0[5], hitscan1[5], hitscan2[5], hitscan3[5]}),
        .gpu_color(row_color_5),
        .color_requestor(color_requestor_x),
        .rowswap_read_cell_0(cellswap_layers_4_5_cell_0),
        .rowswap_read_cell_1(cellswap_layers_4_5_cell_1),
        .rowswap_read_cell_2(cellswap_layers_4_5_cell_2),
        .rowswap_read_cell_3(cellswap_layers_4_5_cell_3),
        .rowswap_read_cell_4(cellswap_layers_4_5_cell_4),
        .rowswap_read_cell_5(cellswap_layers_4_5_cell_5),
        .rowswap_read_cell_6(cellswap_layers_4_5_cell_6),
        .rowswap_read_cell_7(cellswap_layers_4_5_cell_7),
        .rowswap_read_cell_8(cellswap_layers_4_5_cell_8),
        .rowswap_read_cell_9(cellswap_layers_4_5_cell_9),
        .rowswap_read_cell_10(cellswap_layers_4_5_cell_10),
        .rowswap_read_cell_11(cellswap_layers_4_5_cell_11),
        .rowswap_write_cell_0(cellswap_layers_5_6_cell_0),
        .rowswap_write_cell_1(cellswap_layers_5_6_cell_1),
        .rowswap_write_cell_2(cellswap_layers_5_6_cell_2),
        .rowswap_write_cell_3(cellswap_layers_5_6_cell_3),
        .rowswap_write_cell_4(cellswap_layers_5_6_cell_4),
        .rowswap_write_cell_5(cellswap_layers_5_6_cell_5),
        .rowswap_write_cell_6(cellswap_layers_5_6_cell_6),
        .rowswap_write_cell_7(cellswap_layers_5_6_cell_7),
        .rowswap_write_cell_8(cellswap_layers_5_6_cell_8),
        .rowswap_write_cell_9(cellswap_layers_5_6_cell_9),
        .rowswap_write_cell_10(cellswap_layers_5_6_cell_10),
        .rowswap_write_cell_11(cellswap_layers_5_6_cell_11),
    );
    

    wire [2:0] row_color_6;
    wire rfull_6;
    assign rowfull_stat[6] = rfull_6 & 1'b1;
    memcell_row row_6(
        .clk(clk),
        .reset(reset),
        .advance_row((rowshift_cmd[6] & 1'b1)),
        .color_setter(color_setter),
        .write_row_selector(color_set_requestor_x),
        .write_commiter(color_commit & (color_set_requestor_y == 6'd6)),
        .row_full(rfull_6),
        .hitbox_checker_0(hitbox_checker_0_x),
        .hitbox_checker_1(hitbox_checker_1_x),
        .hitbox_checker_2(hitbox_checker_2_x),
        .hitbox_checker_3(hitbox_checker_3_x),
        .hitbox_status({hitscan0[6], hitscan1[6], hitscan2[6], hitscan3[6]}),
        .gpu_color(row_color_6),
        .color_requestor(color_requestor_x),
        .rowswap_read_cell_0(cellswap_layers_5_6_cell_0),
        .rowswap_read_cell_1(cellswap_layers_5_6_cell_1),
        .rowswap_read_cell_2(cellswap_layers_5_6_cell_2),
        .rowswap_read_cell_3(cellswap_layers_5_6_cell_3),
        .rowswap_read_cell_4(cellswap_layers_5_6_cell_4),
        .rowswap_read_cell_5(cellswap_layers_5_6_cell_5),
        .rowswap_read_cell_6(cellswap_layers_5_6_cell_6),
        .rowswap_read_cell_7(cellswap_layers_5_6_cell_7),
        .rowswap_read_cell_8(cellswap_layers_5_6_cell_8),
        .rowswap_read_cell_9(cellswap_layers_5_6_cell_9),
        .rowswap_read_cell_10(cellswap_layers_5_6_cell_10),
        .rowswap_read_cell_11(cellswap_layers_5_6_cell_11),
        .rowswap_write_cell_0(cellswap_layers_6_7_cell_0),
        .rowswap_write_cell_1(cellswap_layers_6_7_cell_1),
        .rowswap_write_cell_2(cellswap_layers_6_7_cell_2),
        .rowswap_write_cell_3(cellswap_layers_6_7_cell_3),
        .rowswap_write_cell_4(cellswap_layers_6_7_cell_4),
        .rowswap_write_cell_5(cellswap_layers_6_7_cell_5),
        .rowswap_write_cell_6(cellswap_layers_6_7_cell_6),
        .rowswap_write_cell_7(cellswap_layers_6_7_cell_7),
        .rowswap_write_cell_8(cellswap_layers_6_7_cell_8),
        .rowswap_write_cell_9(cellswap_layers_6_7_cell_9),
        .rowswap_write_cell_10(cellswap_layers_6_7_cell_10),
        .rowswap_write_cell_11(cellswap_layers_6_7_cell_11),
    );
    

    wire [2:0] row_color_7;
    wire rfull_7;
    assign rowfull_stat[7] = rfull_7 & 1'b1;
    memcell_row row_7(
        .clk(clk),
        .reset(reset),
        .advance_row((rowshift_cmd[7] & 1'b1)),
        .color_setter(color_setter),
        .write_row_selector(color_set_requestor_x),
        .write_commiter(color_commit & (color_set_requestor_y == 6'd7)),
        .row_full(rfull_7),
        .hitbox_checker_0(hitbox_checker_0_x),
        .hitbox_checker_1(hitbox_checker_1_x),
        .hitbox_checker_2(hitbox_checker_2_x),
        .hitbox_checker_3(hitbox_checker_3_x),
        .hitbox_status({hitscan0[7], hitscan1[7], hitscan2[7], hitscan3[7]}),
        .gpu_color(row_color_7),
        .color_requestor(color_requestor_x),
        .rowswap_read_cell_0(cellswap_layers_6_7_cell_0),
        .rowswap_read_cell_1(cellswap_layers_6_7_cell_1),
        .rowswap_read_cell_2(cellswap_layers_6_7_cell_2),
        .rowswap_read_cell_3(cellswap_layers_6_7_cell_3),
        .rowswap_read_cell_4(cellswap_layers_6_7_cell_4),
        .rowswap_read_cell_5(cellswap_layers_6_7_cell_5),
        .rowswap_read_cell_6(cellswap_layers_6_7_cell_6),
        .rowswap_read_cell_7(cellswap_layers_6_7_cell_7),
        .rowswap_read_cell_8(cellswap_layers_6_7_cell_8),
        .rowswap_read_cell_9(cellswap_layers_6_7_cell_9),
        .rowswap_read_cell_10(cellswap_layers_6_7_cell_10),
        .rowswap_read_cell_11(cellswap_layers_6_7_cell_11),
        .rowswap_write_cell_0(cellswap_layers_7_8_cell_0),
        .rowswap_write_cell_1(cellswap_layers_7_8_cell_1),
        .rowswap_write_cell_2(cellswap_layers_7_8_cell_2),
        .rowswap_write_cell_3(cellswap_layers_7_8_cell_3),
        .rowswap_write_cell_4(cellswap_layers_7_8_cell_4),
        .rowswap_write_cell_5(cellswap_layers_7_8_cell_5),
        .rowswap_write_cell_6(cellswap_layers_7_8_cell_6),
        .rowswap_write_cell_7(cellswap_layers_7_8_cell_7),
        .rowswap_write_cell_8(cellswap_layers_7_8_cell_8),
        .rowswap_write_cell_9(cellswap_layers_7_8_cell_9),
        .rowswap_write_cell_10(cellswap_layers_7_8_cell_10),
        .rowswap_write_cell_11(cellswap_layers_7_8_cell_11),
    );
    

    wire [2:0] row_color_8;
    wire rfull_8;
    assign rowfull_stat[8] = rfull_8 & 1'b1;
    memcell_row row_8(
        .clk(clk),
        .reset(reset),
        .advance_row((rowshift_cmd[8] & 1'b1)),
        .color_setter(color_setter),
        .write_row_selector(color_set_requestor_x),
        .write_commiter(color_commit & (color_set_requestor_y == 6'd8)),
        .row_full(rfull_8),
        .hitbox_checker_0(hitbox_checker_0_x),
        .hitbox_checker_1(hitbox_checker_1_x),
        .hitbox_checker_2(hitbox_checker_2_x),
        .hitbox_checker_3(hitbox_checker_3_x),
        .hitbox_status({hitscan0[8], hitscan1[8], hitscan2[8], hitscan3[8]}),
        .gpu_color(row_color_8),
        .color_requestor(color_requestor_x),
        .rowswap_read_cell_0(cellswap_layers_7_8_cell_0),
        .rowswap_read_cell_1(cellswap_layers_7_8_cell_1),
        .rowswap_read_cell_2(cellswap_layers_7_8_cell_2),
        .rowswap_read_cell_3(cellswap_layers_7_8_cell_3),
        .rowswap_read_cell_4(cellswap_layers_7_8_cell_4),
        .rowswap_read_cell_5(cellswap_layers_7_8_cell_5),
        .rowswap_read_cell_6(cellswap_layers_7_8_cell_6),
        .rowswap_read_cell_7(cellswap_layers_7_8_cell_7),
        .rowswap_read_cell_8(cellswap_layers_7_8_cell_8),
        .rowswap_read_cell_9(cellswap_layers_7_8_cell_9),
        .rowswap_read_cell_10(cellswap_layers_7_8_cell_10),
        .rowswap_read_cell_11(cellswap_layers_7_8_cell_11),
        .rowswap_write_cell_0(cellswap_layers_8_9_cell_0),
        .rowswap_write_cell_1(cellswap_layers_8_9_cell_1),
        .rowswap_write_cell_2(cellswap_layers_8_9_cell_2),
        .rowswap_write_cell_3(cellswap_layers_8_9_cell_3),
        .rowswap_write_cell_4(cellswap_layers_8_9_cell_4),
        .rowswap_write_cell_5(cellswap_layers_8_9_cell_5),
        .rowswap_write_cell_6(cellswap_layers_8_9_cell_6),
        .rowswap_write_cell_7(cellswap_layers_8_9_cell_7),
        .rowswap_write_cell_8(cellswap_layers_8_9_cell_8),
        .rowswap_write_cell_9(cellswap_layers_8_9_cell_9),
        .rowswap_write_cell_10(cellswap_layers_8_9_cell_10),
        .rowswap_write_cell_11(cellswap_layers_8_9_cell_11),
    );
    

    wire [2:0] row_color_9;
    wire rfull_9;
    assign rowfull_stat[9] = rfull_9 & 1'b1;
    memcell_row row_9(
        .clk(clk),
        .reset(reset),
        .advance_row((rowshift_cmd[9] & 1'b1)),
        .color_setter(color_setter),
        .write_row_selector(color_set_requestor_x),
        .write_commiter(color_commit & (color_set_requestor_y == 6'd9)),
        .row_full(rfull_9),
        .hitbox_checker_0(hitbox_checker_0_x),
        .hitbox_checker_1(hitbox_checker_1_x),
        .hitbox_checker_2(hitbox_checker_2_x),
        .hitbox_checker_3(hitbox_checker_3_x),
        .hitbox_status({hitscan0[9], hitscan1[9], hitscan2[9], hitscan3[9]}),
        .gpu_color(row_color_9),
        .color_requestor(color_requestor_x),
        .rowswap_read_cell_0(cellswap_layers_8_9_cell_0),
        .rowswap_read_cell_1(cellswap_layers_8_9_cell_1),
        .rowswap_read_cell_2(cellswap_layers_8_9_cell_2),
        .rowswap_read_cell_3(cellswap_layers_8_9_cell_3),
        .rowswap_read_cell_4(cellswap_layers_8_9_cell_4),
        .rowswap_read_cell_5(cellswap_layers_8_9_cell_5),
        .rowswap_read_cell_6(cellswap_layers_8_9_cell_6),
        .rowswap_read_cell_7(cellswap_layers_8_9_cell_7),
        .rowswap_read_cell_8(cellswap_layers_8_9_cell_8),
        .rowswap_read_cell_9(cellswap_layers_8_9_cell_9),
        .rowswap_read_cell_10(cellswap_layers_8_9_cell_10),
        .rowswap_read_cell_11(cellswap_layers_8_9_cell_11),
        .rowswap_write_cell_0(cellswap_layers_9_10_cell_0),
        .rowswap_write_cell_1(cellswap_layers_9_10_cell_1),
        .rowswap_write_cell_2(cellswap_layers_9_10_cell_2),
        .rowswap_write_cell_3(cellswap_layers_9_10_cell_3),
        .rowswap_write_cell_4(cellswap_layers_9_10_cell_4),
        .rowswap_write_cell_5(cellswap_layers_9_10_cell_5),
        .rowswap_write_cell_6(cellswap_layers_9_10_cell_6),
        .rowswap_write_cell_7(cellswap_layers_9_10_cell_7),
        .rowswap_write_cell_8(cellswap_layers_9_10_cell_8),
        .rowswap_write_cell_9(cellswap_layers_9_10_cell_9),
        .rowswap_write_cell_10(cellswap_layers_9_10_cell_10),
        .rowswap_write_cell_11(cellswap_layers_9_10_cell_11),
    );
    

    wire [2:0] row_color_10;
    wire rfull_10;
    assign rowfull_stat[10] = rfull_10 & 1'b1;
    memcell_row row_10(
        .clk(clk),
        .reset(reset),
        .advance_row((rowshift_cmd[10] & 1'b1)),
        .color_setter(color_setter),
        .write_row_selector(color_set_requestor_x),
        .write_commiter(color_commit & (color_set_requestor_y == 6'd10)),
        .row_full(rfull_10),
        .hitbox_checker_0(hitbox_checker_0_x),
        .hitbox_checker_1(hitbox_checker_1_x),
        .hitbox_checker_2(hitbox_checker_2_x),
        .hitbox_checker_3(hitbox_checker_3_x),
        .hitbox_status({hitscan0[10], hitscan1[10], hitscan2[10], hitscan3[10]}),
        .gpu_color(row_color_10),
        .color_requestor(color_requestor_x),
        .rowswap_read_cell_0(cellswap_layers_9_10_cell_0),
        .rowswap_read_cell_1(cellswap_layers_9_10_cell_1),
        .rowswap_read_cell_2(cellswap_layers_9_10_cell_2),
        .rowswap_read_cell_3(cellswap_layers_9_10_cell_3),
        .rowswap_read_cell_4(cellswap_layers_9_10_cell_4),
        .rowswap_read_cell_5(cellswap_layers_9_10_cell_5),
        .rowswap_read_cell_6(cellswap_layers_9_10_cell_6),
        .rowswap_read_cell_7(cellswap_layers_9_10_cell_7),
        .rowswap_read_cell_8(cellswap_layers_9_10_cell_8),
        .rowswap_read_cell_9(cellswap_layers_9_10_cell_9),
        .rowswap_read_cell_10(cellswap_layers_9_10_cell_10),
        .rowswap_read_cell_11(cellswap_layers_9_10_cell_11),
        .rowswap_write_cell_0(cellswap_layers_10_11_cell_0),
        .rowswap_write_cell_1(cellswap_layers_10_11_cell_1),
        .rowswap_write_cell_2(cellswap_layers_10_11_cell_2),
        .rowswap_write_cell_3(cellswap_layers_10_11_cell_3),
        .rowswap_write_cell_4(cellswap_layers_10_11_cell_4),
        .rowswap_write_cell_5(cellswap_layers_10_11_cell_5),
        .rowswap_write_cell_6(cellswap_layers_10_11_cell_6),
        .rowswap_write_cell_7(cellswap_layers_10_11_cell_7),
        .rowswap_write_cell_8(cellswap_layers_10_11_cell_8),
        .rowswap_write_cell_9(cellswap_layers_10_11_cell_9),
        .rowswap_write_cell_10(cellswap_layers_10_11_cell_10),
        .rowswap_write_cell_11(cellswap_layers_10_11_cell_11),
    );
    

    wire [2:0] row_color_11;
    wire rfull_11;
    assign rowfull_stat[11] = rfull_11 & 1'b1;
    memcell_row row_11(
        .clk(clk),
        .reset(reset),
        .advance_row((rowshift_cmd[11] & 1'b1)),
        .color_setter(color_setter),
        .write_row_selector(color_set_requestor_x),
        .write_commiter(color_commit & (color_set_requestor_y == 6'd11)),
        .row_full(rfull_11),
        .hitbox_checker_0(hitbox_checker_0_x),
        .hitbox_checker_1(hitbox_checker_1_x),
        .hitbox_checker_2(hitbox_checker_2_x),
        .hitbox_checker_3(hitbox_checker_3_x),
        .hitbox_status({hitscan0[11], hitscan1[11], hitscan2[11], hitscan3[11]}),
        .gpu_color(row_color_11),
        .color_requestor(color_requestor_x),
        .rowswap_read_cell_0(cellswap_layers_10_11_cell_0),
        .rowswap_read_cell_1(cellswap_layers_10_11_cell_1),
        .rowswap_read_cell_2(cellswap_layers_10_11_cell_2),
        .rowswap_read_cell_3(cellswap_layers_10_11_cell_3),
        .rowswap_read_cell_4(cellswap_layers_10_11_cell_4),
        .rowswap_read_cell_5(cellswap_layers_10_11_cell_5),
        .rowswap_read_cell_6(cellswap_layers_10_11_cell_6),
        .rowswap_read_cell_7(cellswap_layers_10_11_cell_7),
        .rowswap_read_cell_8(cellswap_layers_10_11_cell_8),
        .rowswap_read_cell_9(cellswap_layers_10_11_cell_9),
        .rowswap_read_cell_10(cellswap_layers_10_11_cell_10),
        .rowswap_read_cell_11(cellswap_layers_10_11_cell_11),
        .rowswap_write_cell_0(cellswap_layers_11_12_cell_0),
        .rowswap_write_cell_1(cellswap_layers_11_12_cell_1),
        .rowswap_write_cell_2(cellswap_layers_11_12_cell_2),
        .rowswap_write_cell_3(cellswap_layers_11_12_cell_3),
        .rowswap_write_cell_4(cellswap_layers_11_12_cell_4),
        .rowswap_write_cell_5(cellswap_layers_11_12_cell_5),
        .rowswap_write_cell_6(cellswap_layers_11_12_cell_6),
        .rowswap_write_cell_7(cellswap_layers_11_12_cell_7),
        .rowswap_write_cell_8(cellswap_layers_11_12_cell_8),
        .rowswap_write_cell_9(cellswap_layers_11_12_cell_9),
        .rowswap_write_cell_10(cellswap_layers_11_12_cell_10),
        .rowswap_write_cell_11(cellswap_layers_11_12_cell_11),
    );
    

    wire [2:0] row_color_12;
    wire rfull_12;
    assign rowfull_stat[12] = rfull_12 & 1'b1;
    memcell_row row_12(
        .clk(clk),
        .reset(reset),
        .advance_row((rowshift_cmd[12] & 1'b1)),
        .color_setter(color_setter),
        .write_row_selector(color_set_requestor_x),
        .write_commiter(color_commit & (color_set_requestor_y == 6'd12)),
        .row_full(rfull_12),
        .hitbox_checker_0(hitbox_checker_0_x),
        .hitbox_checker_1(hitbox_checker_1_x),
        .hitbox_checker_2(hitbox_checker_2_x),
        .hitbox_checker_3(hitbox_checker_3_x),
        .hitbox_status({hitscan0[12], hitscan1[12], hitscan2[12], hitscan3[12]}),
        .gpu_color(row_color_12),
        .color_requestor(color_requestor_x),
        .rowswap_read_cell_0(cellswap_layers_11_12_cell_0),
        .rowswap_read_cell_1(cellswap_layers_11_12_cell_1),
        .rowswap_read_cell_2(cellswap_layers_11_12_cell_2),
        .rowswap_read_cell_3(cellswap_layers_11_12_cell_3),
        .rowswap_read_cell_4(cellswap_layers_11_12_cell_4),
        .rowswap_read_cell_5(cellswap_layers_11_12_cell_5),
        .rowswap_read_cell_6(cellswap_layers_11_12_cell_6),
        .rowswap_read_cell_7(cellswap_layers_11_12_cell_7),
        .rowswap_read_cell_8(cellswap_layers_11_12_cell_8),
        .rowswap_read_cell_9(cellswap_layers_11_12_cell_9),
        .rowswap_read_cell_10(cellswap_layers_11_12_cell_10),
        .rowswap_read_cell_11(cellswap_layers_11_12_cell_11),
        .rowswap_write_cell_0(cellswap_layers_12_13_cell_0),
        .rowswap_write_cell_1(cellswap_layers_12_13_cell_1),
        .rowswap_write_cell_2(cellswap_layers_12_13_cell_2),
        .rowswap_write_cell_3(cellswap_layers_12_13_cell_3),
        .rowswap_write_cell_4(cellswap_layers_12_13_cell_4),
        .rowswap_write_cell_5(cellswap_layers_12_13_cell_5),
        .rowswap_write_cell_6(cellswap_layers_12_13_cell_6),
        .rowswap_write_cell_7(cellswap_layers_12_13_cell_7),
        .rowswap_write_cell_8(cellswap_layers_12_13_cell_8),
        .rowswap_write_cell_9(cellswap_layers_12_13_cell_9),
        .rowswap_write_cell_10(cellswap_layers_12_13_cell_10),
        .rowswap_write_cell_11(cellswap_layers_12_13_cell_11),
    );
    

    wire [2:0] row_color_13;
    wire rfull_13;
    assign rowfull_stat[13] = rfull_13 & 1'b1;
    memcell_row row_13(
        .clk(clk),
        .reset(reset),
        .advance_row((rowshift_cmd[13] & 1'b1)),
        .color_setter(color_setter),
        .write_row_selector(color_set_requestor_x),
        .write_commiter(color_commit & (color_set_requestor_y == 6'd13)),
        .row_full(rfull_13),
        .hitbox_checker_0(hitbox_checker_0_x),
        .hitbox_checker_1(hitbox_checker_1_x),
        .hitbox_checker_2(hitbox_checker_2_x),
        .hitbox_checker_3(hitbox_checker_3_x),
        .hitbox_status({hitscan0[13], hitscan1[13], hitscan2[13], hitscan3[13]}),
        .gpu_color(row_color_13),
        .color_requestor(color_requestor_x),
        .rowswap_read_cell_0(cellswap_layers_12_13_cell_0),
        .rowswap_read_cell_1(cellswap_layers_12_13_cell_1),
        .rowswap_read_cell_2(cellswap_layers_12_13_cell_2),
        .rowswap_read_cell_3(cellswap_layers_12_13_cell_3),
        .rowswap_read_cell_4(cellswap_layers_12_13_cell_4),
        .rowswap_read_cell_5(cellswap_layers_12_13_cell_5),
        .rowswap_read_cell_6(cellswap_layers_12_13_cell_6),
        .rowswap_read_cell_7(cellswap_layers_12_13_cell_7),
        .rowswap_read_cell_8(cellswap_layers_12_13_cell_8),
        .rowswap_read_cell_9(cellswap_layers_12_13_cell_9),
        .rowswap_read_cell_10(cellswap_layers_12_13_cell_10),
        .rowswap_read_cell_11(cellswap_layers_12_13_cell_11),
        .rowswap_write_cell_0(cellswap_layers_13_14_cell_0),
        .rowswap_write_cell_1(cellswap_layers_13_14_cell_1),
        .rowswap_write_cell_2(cellswap_layers_13_14_cell_2),
        .rowswap_write_cell_3(cellswap_layers_13_14_cell_3),
        .rowswap_write_cell_4(cellswap_layers_13_14_cell_4),
        .rowswap_write_cell_5(cellswap_layers_13_14_cell_5),
        .rowswap_write_cell_6(cellswap_layers_13_14_cell_6),
        .rowswap_write_cell_7(cellswap_layers_13_14_cell_7),
        .rowswap_write_cell_8(cellswap_layers_13_14_cell_8),
        .rowswap_write_cell_9(cellswap_layers_13_14_cell_9),
        .rowswap_write_cell_10(cellswap_layers_13_14_cell_10),
        .rowswap_write_cell_11(cellswap_layers_13_14_cell_11),
    );
    

    wire [2:0] row_color_14;
    wire rfull_14;
    assign rowfull_stat[14] = rfull_14 & 1'b1;
    memcell_row row_14(
        .clk(clk),
        .reset(reset),
        .advance_row((rowshift_cmd[14] & 1'b1)),
        .color_setter(color_setter),
        .write_row_selector(color_set_requestor_x),
        .write_commiter(color_commit & (color_set_requestor_y == 6'd14)),
        .row_full(rfull_14),
        .hitbox_checker_0(hitbox_checker_0_x),
        .hitbox_checker_1(hitbox_checker_1_x),
        .hitbox_checker_2(hitbox_checker_2_x),
        .hitbox_checker_3(hitbox_checker_3_x),
        .hitbox_status({hitscan0[14], hitscan1[14], hitscan2[14], hitscan3[14]}),
        .gpu_color(row_color_14),
        .color_requestor(color_requestor_x),
        .rowswap_read_cell_0(cellswap_layers_13_14_cell_0),
        .rowswap_read_cell_1(cellswap_layers_13_14_cell_1),
        .rowswap_read_cell_2(cellswap_layers_13_14_cell_2),
        .rowswap_read_cell_3(cellswap_layers_13_14_cell_3),
        .rowswap_read_cell_4(cellswap_layers_13_14_cell_4),
        .rowswap_read_cell_5(cellswap_layers_13_14_cell_5),
        .rowswap_read_cell_6(cellswap_layers_13_14_cell_6),
        .rowswap_read_cell_7(cellswap_layers_13_14_cell_7),
        .rowswap_read_cell_8(cellswap_layers_13_14_cell_8),
        .rowswap_read_cell_9(cellswap_layers_13_14_cell_9),
        .rowswap_read_cell_10(cellswap_layers_13_14_cell_10),
        .rowswap_read_cell_11(cellswap_layers_13_14_cell_11),
        .rowswap_write_cell_0(cellswap_layers_14_15_cell_0),
        .rowswap_write_cell_1(cellswap_layers_14_15_cell_1),
        .rowswap_write_cell_2(cellswap_layers_14_15_cell_2),
        .rowswap_write_cell_3(cellswap_layers_14_15_cell_3),
        .rowswap_write_cell_4(cellswap_layers_14_15_cell_4),
        .rowswap_write_cell_5(cellswap_layers_14_15_cell_5),
        .rowswap_write_cell_6(cellswap_layers_14_15_cell_6),
        .rowswap_write_cell_7(cellswap_layers_14_15_cell_7),
        .rowswap_write_cell_8(cellswap_layers_14_15_cell_8),
        .rowswap_write_cell_9(cellswap_layers_14_15_cell_9),
        .rowswap_write_cell_10(cellswap_layers_14_15_cell_10),
        .rowswap_write_cell_11(cellswap_layers_14_15_cell_11),
    );
    

    wire [2:0] row_color_15;
    wire rfull_15;
    assign rowfull_stat[15] = rfull_15 & 1'b1;
    memcell_row row_15(
        .clk(clk),
        .reset(reset),
        .advance_row((rowshift_cmd[15] & 1'b1)),
        .color_setter(color_setter),
        .write_row_selector(color_set_requestor_x),
        .write_commiter(color_commit & (color_set_requestor_y == 6'd15)),
        .row_full(rfull_15),
        .hitbox_checker_0(hitbox_checker_0_x),
        .hitbox_checker_1(hitbox_checker_1_x),
        .hitbox_checker_2(hitbox_checker_2_x),
        .hitbox_checker_3(hitbox_checker_3_x),
        .hitbox_status({hitscan0[15], hitscan1[15], hitscan2[15], hitscan3[15]}),
        .gpu_color(row_color_15),
        .color_requestor(color_requestor_x),
        .rowswap_read_cell_0(cellswap_layers_14_15_cell_0),
        .rowswap_read_cell_1(cellswap_layers_14_15_cell_1),
        .rowswap_read_cell_2(cellswap_layers_14_15_cell_2),
        .rowswap_read_cell_3(cellswap_layers_14_15_cell_3),
        .rowswap_read_cell_4(cellswap_layers_14_15_cell_4),
        .rowswap_read_cell_5(cellswap_layers_14_15_cell_5),
        .rowswap_read_cell_6(cellswap_layers_14_15_cell_6),
        .rowswap_read_cell_7(cellswap_layers_14_15_cell_7),
        .rowswap_read_cell_8(cellswap_layers_14_15_cell_8),
        .rowswap_read_cell_9(cellswap_layers_14_15_cell_9),
        .rowswap_read_cell_10(cellswap_layers_14_15_cell_10),
        .rowswap_read_cell_11(cellswap_layers_14_15_cell_11),
        .rowswap_write_cell_0(cellswap_layers_15_16_cell_0),
        .rowswap_write_cell_1(cellswap_layers_15_16_cell_1),
        .rowswap_write_cell_2(cellswap_layers_15_16_cell_2),
        .rowswap_write_cell_3(cellswap_layers_15_16_cell_3),
        .rowswap_write_cell_4(cellswap_layers_15_16_cell_4),
        .rowswap_write_cell_5(cellswap_layers_15_16_cell_5),
        .rowswap_write_cell_6(cellswap_layers_15_16_cell_6),
        .rowswap_write_cell_7(cellswap_layers_15_16_cell_7),
        .rowswap_write_cell_8(cellswap_layers_15_16_cell_8),
        .rowswap_write_cell_9(cellswap_layers_15_16_cell_9),
        .rowswap_write_cell_10(cellswap_layers_15_16_cell_10),
        .rowswap_write_cell_11(cellswap_layers_15_16_cell_11),
    );
    

    wire [2:0] row_color_16;
    wire rfull_16;
    assign rowfull_stat[16] = rfull_16 & 1'b1;
    memcell_row row_16(
        .clk(clk),
        .reset(reset),
        .advance_row((rowshift_cmd[16] & 1'b1)),
        .color_setter(color_setter),
        .write_row_selector(color_set_requestor_x),
        .write_commiter(color_commit & (color_set_requestor_y == 6'd16)),
        .row_full(rfull_16),
        .hitbox_checker_0(hitbox_checker_0_x),
        .hitbox_checker_1(hitbox_checker_1_x),
        .hitbox_checker_2(hitbox_checker_2_x),
        .hitbox_checker_3(hitbox_checker_3_x),
        .hitbox_status({hitscan0[16], hitscan1[16], hitscan2[16], hitscan3[16]}),
        .gpu_color(row_color_16),
        .color_requestor(color_requestor_x),
        .rowswap_read_cell_0(cellswap_layers_15_16_cell_0),
        .rowswap_read_cell_1(cellswap_layers_15_16_cell_1),
        .rowswap_read_cell_2(cellswap_layers_15_16_cell_2),
        .rowswap_read_cell_3(cellswap_layers_15_16_cell_3),
        .rowswap_read_cell_4(cellswap_layers_15_16_cell_4),
        .rowswap_read_cell_5(cellswap_layers_15_16_cell_5),
        .rowswap_read_cell_6(cellswap_layers_15_16_cell_6),
        .rowswap_read_cell_7(cellswap_layers_15_16_cell_7),
        .rowswap_read_cell_8(cellswap_layers_15_16_cell_8),
        .rowswap_read_cell_9(cellswap_layers_15_16_cell_9),
        .rowswap_read_cell_10(cellswap_layers_15_16_cell_10),
        .rowswap_read_cell_11(cellswap_layers_15_16_cell_11),
        .rowswap_write_cell_0(cellswap_layers_16_17_cell_0),
        .rowswap_write_cell_1(cellswap_layers_16_17_cell_1),
        .rowswap_write_cell_2(cellswap_layers_16_17_cell_2),
        .rowswap_write_cell_3(cellswap_layers_16_17_cell_3),
        .rowswap_write_cell_4(cellswap_layers_16_17_cell_4),
        .rowswap_write_cell_5(cellswap_layers_16_17_cell_5),
        .rowswap_write_cell_6(cellswap_layers_16_17_cell_6),
        .rowswap_write_cell_7(cellswap_layers_16_17_cell_7),
        .rowswap_write_cell_8(cellswap_layers_16_17_cell_8),
        .rowswap_write_cell_9(cellswap_layers_16_17_cell_9),
        .rowswap_write_cell_10(cellswap_layers_16_17_cell_10),
        .rowswap_write_cell_11(cellswap_layers_16_17_cell_11),
    );
    

    wire [2:0] row_color_17;
    wire rfull_17;
    assign rowfull_stat[17] = rfull_17 & 1'b1;
    memcell_row row_17(
        .clk(clk),
        .reset(reset),
        .advance_row((rowshift_cmd[17] & 1'b1)),
        .color_setter(color_setter),
        .write_row_selector(color_set_requestor_x),
        .write_commiter(color_commit & (color_set_requestor_y == 6'd17)),
        .row_full(rfull_17),
        .hitbox_checker_0(hitbox_checker_0_x),
        .hitbox_checker_1(hitbox_checker_1_x),
        .hitbox_checker_2(hitbox_checker_2_x),
        .hitbox_checker_3(hitbox_checker_3_x),
        .hitbox_status({hitscan0[17], hitscan1[17], hitscan2[17], hitscan3[17]}),
        .gpu_color(row_color_17),
        .color_requestor(color_requestor_x),
        .rowswap_read_cell_0(cellswap_layers_16_17_cell_0),
        .rowswap_read_cell_1(cellswap_layers_16_17_cell_1),
        .rowswap_read_cell_2(cellswap_layers_16_17_cell_2),
        .rowswap_read_cell_3(cellswap_layers_16_17_cell_3),
        .rowswap_read_cell_4(cellswap_layers_16_17_cell_4),
        .rowswap_read_cell_5(cellswap_layers_16_17_cell_5),
        .rowswap_read_cell_6(cellswap_layers_16_17_cell_6),
        .rowswap_read_cell_7(cellswap_layers_16_17_cell_7),
        .rowswap_read_cell_8(cellswap_layers_16_17_cell_8),
        .rowswap_read_cell_9(cellswap_layers_16_17_cell_9),
        .rowswap_read_cell_10(cellswap_layers_16_17_cell_10),
        .rowswap_read_cell_11(cellswap_layers_16_17_cell_11),
        .rowswap_write_cell_0(cellswap_layers_17_18_cell_0),
        .rowswap_write_cell_1(cellswap_layers_17_18_cell_1),
        .rowswap_write_cell_2(cellswap_layers_17_18_cell_2),
        .rowswap_write_cell_3(cellswap_layers_17_18_cell_3),
        .rowswap_write_cell_4(cellswap_layers_17_18_cell_4),
        .rowswap_write_cell_5(cellswap_layers_17_18_cell_5),
        .rowswap_write_cell_6(cellswap_layers_17_18_cell_6),
        .rowswap_write_cell_7(cellswap_layers_17_18_cell_7),
        .rowswap_write_cell_8(cellswap_layers_17_18_cell_8),
        .rowswap_write_cell_9(cellswap_layers_17_18_cell_9),
        .rowswap_write_cell_10(cellswap_layers_17_18_cell_10),
        .rowswap_write_cell_11(cellswap_layers_17_18_cell_11),
    );
    

    wire [2:0] row_color_18;
    wire rfull_18;
    assign rowfull_stat[18] = rfull_18 & 1'b1;
    memcell_row row_18(
        .clk(clk),
        .reset(reset),
        .advance_row((rowshift_cmd[18] & 1'b1)),
        .color_setter(color_setter),
        .write_row_selector(color_set_requestor_x),
        .write_commiter(color_commit & (color_set_requestor_y == 6'd18)),
        .row_full(rfull_18),
        .hitbox_checker_0(hitbox_checker_0_x),
        .hitbox_checker_1(hitbox_checker_1_x),
        .hitbox_checker_2(hitbox_checker_2_x),
        .hitbox_checker_3(hitbox_checker_3_x),
        .hitbox_status({hitscan0[18], hitscan1[18], hitscan2[18], hitscan3[18]}),
        .gpu_color(row_color_18),
        .color_requestor(color_requestor_x),
        .rowswap_read_cell_0(cellswap_layers_17_18_cell_0),
        .rowswap_read_cell_1(cellswap_layers_17_18_cell_1),
        .rowswap_read_cell_2(cellswap_layers_17_18_cell_2),
        .rowswap_read_cell_3(cellswap_layers_17_18_cell_3),
        .rowswap_read_cell_4(cellswap_layers_17_18_cell_4),
        .rowswap_read_cell_5(cellswap_layers_17_18_cell_5),
        .rowswap_read_cell_6(cellswap_layers_17_18_cell_6),
        .rowswap_read_cell_7(cellswap_layers_17_18_cell_7),
        .rowswap_read_cell_8(cellswap_layers_17_18_cell_8),
        .rowswap_read_cell_9(cellswap_layers_17_18_cell_9),
        .rowswap_read_cell_10(cellswap_layers_17_18_cell_10),
        .rowswap_read_cell_11(cellswap_layers_17_18_cell_11),
        .rowswap_write_cell_0(cellswap_layers_18_19_cell_0),
        .rowswap_write_cell_1(cellswap_layers_18_19_cell_1),
        .rowswap_write_cell_2(cellswap_layers_18_19_cell_2),
        .rowswap_write_cell_3(cellswap_layers_18_19_cell_3),
        .rowswap_write_cell_4(cellswap_layers_18_19_cell_4),
        .rowswap_write_cell_5(cellswap_layers_18_19_cell_5),
        .rowswap_write_cell_6(cellswap_layers_18_19_cell_6),
        .rowswap_write_cell_7(cellswap_layers_18_19_cell_7),
        .rowswap_write_cell_8(cellswap_layers_18_19_cell_8),
        .rowswap_write_cell_9(cellswap_layers_18_19_cell_9),
        .rowswap_write_cell_10(cellswap_layers_18_19_cell_10),
        .rowswap_write_cell_11(cellswap_layers_18_19_cell_11),
    );
    

    wire [2:0] row_color_19;
    wire rfull_19;
    assign rowfull_stat[19] = rfull_19 & 1'b1;
    memcell_row row_19(
        .clk(clk),
        .reset(reset),
        .advance_row((rowshift_cmd[19] & 1'b1)),
        .color_setter(color_setter),
        .write_row_selector(color_set_requestor_x),
        .write_commiter(color_commit & (color_set_requestor_y == 6'd19)),
        .row_full(rfull_19),
        .hitbox_checker_0(hitbox_checker_0_x),
        .hitbox_checker_1(hitbox_checker_1_x),
        .hitbox_checker_2(hitbox_checker_2_x),
        .hitbox_checker_3(hitbox_checker_3_x),
        .hitbox_status({hitscan0[19], hitscan1[19], hitscan2[19], hitscan3[19]}),
        .gpu_color(row_color_19),
        .color_requestor(color_requestor_x),
        .rowswap_read_cell_0(cellswap_layers_18_19_cell_0),
        .rowswap_read_cell_1(cellswap_layers_18_19_cell_1),
        .rowswap_read_cell_2(cellswap_layers_18_19_cell_2),
        .rowswap_read_cell_3(cellswap_layers_18_19_cell_3),
        .rowswap_read_cell_4(cellswap_layers_18_19_cell_4),
        .rowswap_read_cell_5(cellswap_layers_18_19_cell_5),
        .rowswap_read_cell_6(cellswap_layers_18_19_cell_6),
        .rowswap_read_cell_7(cellswap_layers_18_19_cell_7),
        .rowswap_read_cell_8(cellswap_layers_18_19_cell_8),
        .rowswap_read_cell_9(cellswap_layers_18_19_cell_9),
        .rowswap_read_cell_10(cellswap_layers_18_19_cell_10),
        .rowswap_read_cell_11(cellswap_layers_18_19_cell_11),
        .rowswap_write_cell_0(cellswap_layers_19_20_cell_0),
        .rowswap_write_cell_1(cellswap_layers_19_20_cell_1),
        .rowswap_write_cell_2(cellswap_layers_19_20_cell_2),
        .rowswap_write_cell_3(cellswap_layers_19_20_cell_3),
        .rowswap_write_cell_4(cellswap_layers_19_20_cell_4),
        .rowswap_write_cell_5(cellswap_layers_19_20_cell_5),
        .rowswap_write_cell_6(cellswap_layers_19_20_cell_6),
        .rowswap_write_cell_7(cellswap_layers_19_20_cell_7),
        .rowswap_write_cell_8(cellswap_layers_19_20_cell_8),
        .rowswap_write_cell_9(cellswap_layers_19_20_cell_9),
        .rowswap_write_cell_10(cellswap_layers_19_20_cell_10),
        .rowswap_write_cell_11(cellswap_layers_19_20_cell_11),
    );
    

    wire [2:0] row_color_20;
    wire rfull_20;
    assign rowfull_stat[20] = rfull_20 & 1'b0;
    memcell_row row_20(
        .clk(clk),
        .reset(reset),
        .advance_row((rowshift_cmd[20] & 1'b0)),
        .color_setter(color_setter),
        .write_row_selector(color_set_requestor_x),
        .write_commiter(color_commit & (color_set_requestor_y == 6'd20)),
        .row_full(rfull_20),
        .hitbox_checker_0(hitbox_checker_0_x),
        .hitbox_checker_1(hitbox_checker_1_x),
        .hitbox_checker_2(hitbox_checker_2_x),
        .hitbox_checker_3(hitbox_checker_3_x),
        .hitbox_status({hitscan0[20], hitscan1[20], hitscan2[20], hitscan3[20]}),
        .gpu_color(row_color_20),
        .color_requestor(color_requestor_x),
        .rowswap_read_cell_0(cellswap_layers_19_20_cell_0),
        .rowswap_read_cell_1(cellswap_layers_19_20_cell_1),
        .rowswap_read_cell_2(cellswap_layers_19_20_cell_2),
        .rowswap_read_cell_3(cellswap_layers_19_20_cell_3),
        .rowswap_read_cell_4(cellswap_layers_19_20_cell_4),
        .rowswap_read_cell_5(cellswap_layers_19_20_cell_5),
        .rowswap_read_cell_6(cellswap_layers_19_20_cell_6),
        .rowswap_read_cell_7(cellswap_layers_19_20_cell_7),
        .rowswap_read_cell_8(cellswap_layers_19_20_cell_8),
        .rowswap_read_cell_9(cellswap_layers_19_20_cell_9),
        .rowswap_read_cell_10(cellswap_layers_19_20_cell_10),
        .rowswap_read_cell_11(cellswap_layers_19_20_cell_11),
        .rowswap_write_cell_0(cellswap_layers_20_21_cell_0),
        .rowswap_write_cell_1(cellswap_layers_20_21_cell_1),
        .rowswap_write_cell_2(cellswap_layers_20_21_cell_2),
        .rowswap_write_cell_3(cellswap_layers_20_21_cell_3),
        .rowswap_write_cell_4(cellswap_layers_20_21_cell_4),
        .rowswap_write_cell_5(cellswap_layers_20_21_cell_5),
        .rowswap_write_cell_6(cellswap_layers_20_21_cell_6),
        .rowswap_write_cell_7(cellswap_layers_20_21_cell_7),
        .rowswap_write_cell_8(cellswap_layers_20_21_cell_8),
        .rowswap_write_cell_9(cellswap_layers_20_21_cell_9),
        .rowswap_write_cell_10(cellswap_layers_20_21_cell_10),
        .rowswap_write_cell_11(cellswap_layers_20_21_cell_11),
    );
    
    assign color_getter = (((color_requestor_y == 6'd0) ? row_color_0 : 3'b0) | ((color_requestor_y == 6'd1) ? row_color_1 : 3'b0) | ((color_requestor_y == 6'd2) ? row_color_2 : 3'b0) | ((color_requestor_y == 6'd3) ? row_color_3 : 3'b0) | ((color_requestor_y == 6'd4) ? row_color_4 : 3'b0) | ((color_requestor_y == 6'd5) ? row_color_5 : 3'b0) | ((color_requestor_y == 6'd6) ? row_color_6 : 3'b0) | ((color_requestor_y == 6'd7) ? row_color_7 : 3'b0) | ((color_requestor_y == 6'd8) ? row_color_8 : 3'b0) | ((color_requestor_y == 6'd9) ? row_color_9 : 3'b0) | ((color_requestor_y == 6'd10) ? row_color_10 : 3'b0) | ((color_requestor_y == 6'd11) ? row_color_11 : 3'b0) | ((color_requestor_y == 6'd12) ? row_color_12 : 3'b0) | ((color_requestor_y == 6'd13) ? row_color_13 : 3'b0) | ((color_requestor_y == 6'd14) ? row_color_14 : 3'b0) | ((color_requestor_y == 6'd15) ? row_color_15 : 3'b0) | ((color_requestor_y == 6'd16) ? row_color_16 : 3'b0) | ((color_requestor_y == 6'd17) ? row_color_17 : 3'b0) | ((color_requestor_y == 6'd18) ? row_color_18 : 3'b0) | ((color_requestor_y == 6'd19) ? row_color_19 : 3'b0) | ((color_requestor_y == 6'd20) ? row_color_20 : 3'b0));

    wire hitdump1, hitdump2, hitdump3, hitdump4;

    assign hitbox_status[0] = (((hitbox_checker_0_y == 6'd0) ? hitscan0[0] : 1'b0) | ((hitbox_checker_0_y == 6'd1) ? hitscan0[1] : 1'b0) | ((hitbox_checker_0_y == 6'd2) ? hitscan0[2] : 1'b0) | ((hitbox_checker_0_y == 6'd3) ? hitscan0[3] : 1'b0) | ((hitbox_checker_0_y == 6'd4) ? hitscan0[4] : 1'b0) | ((hitbox_checker_0_y == 6'd5) ? hitscan0[5] : 1'b0) | ((hitbox_checker_0_y == 6'd6) ? hitscan0[6] : 1'b0) | ((hitbox_checker_0_y == 6'd7) ? hitscan0[7] : 1'b0) | ((hitbox_checker_0_y == 6'd8) ? hitscan0[8] : 1'b0) | ((hitbox_checker_0_y == 6'd9) ? hitscan0[9] : 1'b0) | ((hitbox_checker_0_y == 6'd10) ? hitscan0[10] : 1'b0) | ((hitbox_checker_0_y == 6'd11) ? hitscan0[11] : 1'b0) | ((hitbox_checker_0_y == 6'd12) ? hitscan0[12] : 1'b0) | ((hitbox_checker_0_y == 6'd13) ? hitscan0[13] : 1'b0) | ((hitbox_checker_0_y == 6'd14) ? hitscan0[14] : 1'b0) | ((hitbox_checker_0_y == 6'd15) ? hitscan0[15] : 1'b0) | ((hitbox_checker_0_y == 6'd16) ? hitscan0[16] : 1'b0) | ((hitbox_checker_0_y == 6'd17) ? hitscan0[17] : 1'b0) | ((hitbox_checker_0_y == 6'd18) ? hitscan0[18] : 1'b0) | ((hitbox_checker_0_y == 6'd19) ? hitscan0[19] : 1'b0) | ((hitbox_checker_0_y == 6'd20) ? hitscan0[20] : 1'b0));
    assign hitbox_status[1] = (((hitbox_checker_1_y == 6'd0) ? hitscan1[0] : 1'b0) | ((hitbox_checker_1_y == 6'd1) ? hitscan1[1] : 1'b0) | ((hitbox_checker_1_y == 6'd2) ? hitscan1[2] : 1'b0) | ((hitbox_checker_1_y == 6'd3) ? hitscan1[3] : 1'b0) | ((hitbox_checker_1_y == 6'd4) ? hitscan1[4] : 1'b0) | ((hitbox_checker_1_y == 6'd5) ? hitscan1[5] : 1'b0) | ((hitbox_checker_1_y == 6'd6) ? hitscan1[6] : 1'b0) | ((hitbox_checker_1_y == 6'd7) ? hitscan1[7] : 1'b0) | ((hitbox_checker_1_y == 6'd8) ? hitscan1[8] : 1'b0) | ((hitbox_checker_1_y == 6'd9) ? hitscan1[9] : 1'b0) | ((hitbox_checker_1_y == 6'd10) ? hitscan1[10] : 1'b0) | ((hitbox_checker_1_y == 6'd11) ? hitscan1[11] : 1'b0) | ((hitbox_checker_1_y == 6'd12) ? hitscan1[12] : 1'b0) | ((hitbox_checker_1_y == 6'd13) ? hitscan1[13] : 1'b0) | ((hitbox_checker_1_y == 6'd14) ? hitscan1[14] : 1'b0) | ((hitbox_checker_1_y == 6'd15) ? hitscan1[15] : 1'b0) | ((hitbox_checker_1_y == 6'd16) ? hitscan1[16] : 1'b0) | ((hitbox_checker_1_y == 6'd17) ? hitscan1[17] : 1'b0) | ((hitbox_checker_1_y == 6'd18) ? hitscan1[18] : 1'b0) | ((hitbox_checker_1_y == 6'd19) ? hitscan1[19] : 1'b0) | ((hitbox_checker_1_y == 6'd20) ? hitscan1[20] : 1'b0));
    assign hitbox_status[2] = (((hitbox_checker_2_y == 6'd0) ? hitscan2[0] : 1'b0) | ((hitbox_checker_2_y == 6'd1) ? hitscan2[1] : 1'b0) | ((hitbox_checker_2_y == 6'd2) ? hitscan2[2] : 1'b0) | ((hitbox_checker_2_y == 6'd3) ? hitscan2[3] : 1'b0) | ((hitbox_checker_2_y == 6'd4) ? hitscan2[4] : 1'b0) | ((hitbox_checker_2_y == 6'd5) ? hitscan2[5] : 1'b0) | ((hitbox_checker_2_y == 6'd6) ? hitscan2[6] : 1'b0) | ((hitbox_checker_2_y == 6'd7) ? hitscan2[7] : 1'b0) | ((hitbox_checker_2_y == 6'd8) ? hitscan2[8] : 1'b0) | ((hitbox_checker_2_y == 6'd9) ? hitscan2[9] : 1'b0) | ((hitbox_checker_2_y == 6'd10) ? hitscan2[10] : 1'b0) | ((hitbox_checker_2_y == 6'd11) ? hitscan2[11] : 1'b0) | ((hitbox_checker_2_y == 6'd12) ? hitscan2[12] : 1'b0) | ((hitbox_checker_2_y == 6'd13) ? hitscan2[13] : 1'b0) | ((hitbox_checker_2_y == 6'd14) ? hitscan2[14] : 1'b0) | ((hitbox_checker_2_y == 6'd15) ? hitscan2[15] : 1'b0) | ((hitbox_checker_2_y == 6'd16) ? hitscan2[16] : 1'b0) | ((hitbox_checker_2_y == 6'd17) ? hitscan2[17] : 1'b0) | ((hitbox_checker_2_y == 6'd18) ? hitscan2[18] : 1'b0) | ((hitbox_checker_2_y == 6'd19) ? hitscan2[19] : 1'b0) | ((hitbox_checker_2_y == 6'd20) ? hitscan2[20] : 1'b0));
    assign hitbox_status[3] = (((hitbox_checker_3_y == 6'd0) ? hitscan3[0] : 1'b0) | ((hitbox_checker_3_y == 6'd1) ? hitscan3[1] : 1'b0) | ((hitbox_checker_3_y == 6'd2) ? hitscan3[2] : 1'b0) | ((hitbox_checker_3_y == 6'd3) ? hitscan3[3] : 1'b0) | ((hitbox_checker_3_y == 6'd4) ? hitscan3[4] : 1'b0) | ((hitbox_checker_3_y == 6'd5) ? hitscan3[5] : 1'b0) | ((hitbox_checker_3_y == 6'd6) ? hitscan3[6] : 1'b0) | ((hitbox_checker_3_y == 6'd7) ? hitscan3[7] : 1'b0) | ((hitbox_checker_3_y == 6'd8) ? hitscan3[8] : 1'b0) | ((hitbox_checker_3_y == 6'd9) ? hitscan3[9] : 1'b0) | ((hitbox_checker_3_y == 6'd10) ? hitscan3[10] : 1'b0) | ((hitbox_checker_3_y == 6'd11) ? hitscan3[11] : 1'b0) | ((hitbox_checker_3_y == 6'd12) ? hitscan3[12] : 1'b0) | ((hitbox_checker_3_y == 6'd13) ? hitscan3[13] : 1'b0) | ((hitbox_checker_3_y == 6'd14) ? hitscan3[14] : 1'b0) | ((hitbox_checker_3_y == 6'd15) ? hitscan3[15] : 1'b0) | ((hitbox_checker_3_y == 6'd16) ? hitscan3[16] : 1'b0) | ((hitbox_checker_3_y == 6'd17) ? hitscan3[17] : 1'b0) | ((hitbox_checker_3_y == 6'd18) ? hitscan3[18] : 1'b0) | ((hitbox_checker_3_y == 6'd19) ? hitscan3[19] : 1'b0) | ((hitbox_checker_3_y == 6'd20) ? hitscan3[20] : 1'b0));

endmodule
