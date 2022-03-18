
`default_nettype none
module memcell_row (
    input wire clk,
    input wire reset,
    input wire advance_row,
    // generate swap wires (inbound)
    input wire[2:0] rowswap_read_cell_0,
    input wire[2:0] rowswap_read_cell_1,
    input wire[2:0] rowswap_read_cell_2,
    input wire[2:0] rowswap_read_cell_3,
    input wire[2:0] rowswap_read_cell_4,
    input wire[2:0] rowswap_read_cell_5,
    input wire[2:0] rowswap_read_cell_6,
    input wire[2:0] rowswap_read_cell_7,
    input wire[2:0] rowswap_read_cell_8,
    input wire[2:0] rowswap_read_cell_9,
    input wire[2:0] rowswap_read_cell_10,
    input wire[2:0] rowswap_read_cell_11,
    input wire[2:0] rowswap_read_cell_12, 
    // generate swap wires (outbound)
    output wire[2:0] rowswap_write_cell_0,
    output wire[2:0] rowswap_write_cell_1,
    output wire[2:0] rowswap_write_cell_2,
    output wire[2:0] rowswap_write_cell_3,
    output wire[2:0] rowswap_write_cell_4,
    output wire[2:0] rowswap_write_cell_5,
    output wire[2:0] rowswap_write_cell_6,
    output wire[2:0] rowswap_write_cell_7,
    output wire[2:0] rowswap_write_cell_8,
    output wire[2:0] rowswap_write_cell_9,
    output wire[2:0] rowswap_write_cell_10,
    output wire[2:0] rowswap_write_cell_11,
    output wire[2:0] rowswap_write_cell_12,

    // what color to write
    input wire[2:0] color_setter,
    // what row to write to
    input wire[5:0] write_row_selector,
    // commit to writing
    input wire write_commiter,

    // is the row full
    output wire row_full,

    // hitbox thing
    input wire[5:0] hitbox_checker_0,
    input wire[5:0] hitbox_checker_1,
    input wire[5:0] hitbox_checker_2,
    input wire[5:0] hitbox_checker_3,
    output wire[3:0] hitbox_status,

    // color io
    output wire[2:0] gpu_color,
    output wire[5:0] color_requestor
);

    wire [12:0] hitscan;
    assign row_full = &(hitscan);
    assign hitbox_status = {hitscan[hitbox_checker_0], hitscan[hitbox_checker_1], hitscan[hitbox_checker_2], hitscan[hitbox_checker_3]};
    assign gpu_color = (((color_requestor == 6'd0) ? cell_0_color : 3'd0)|((color_requestor == 6'd1) ? cell_1_color : 3'd0)|((color_requestor == 6'd2) ? cell_2_color : 3'd0)|((color_requestor == 6'd3) ? cell_3_color : 3'd0)|((color_requestor == 6'd4) ? cell_4_color : 3'd0)|((color_requestor == 6'd5) ? cell_5_color : 3'd0)|((color_requestor == 6'd6) ? cell_6_color : 3'd0)|((color_requestor == 6'd7) ? cell_7_color : 3'd0)|((color_requestor == 6'd8) ? cell_8_color : 3'd0)|((color_requestor == 6'd9) ? cell_9_color : 3'd0)|((color_requestor == 6'd10) ? cell_10_color : 3'd0)|((color_requestor == 6'd11) ? cell_11_color : 3'd0)|((color_requestor == 6'd12) ? cell_12_color : 3'd0));


    wire [2:0] cell_0_color;
    memcell cell_0(
        .clk(clk),
        .reset(reset),
        .advance(advance_row),
        .prev_cell(rowswap_read_cell_0),
        .myself(rowswap_write_cell_0),
        .write(write_commiter & (write_row_selector == 5'd0)),
        .set_my_color(color_setter),
        .my_color(cell_0_color),
        .cell_occ(hitscan[0])
    );

    wire [2:0] cell_1_color;
    memcell cell_1(
        .clk(clk),
        .reset(reset),
        .advance(advance_row),
        .prev_cell(rowswap_read_cell_1),
        .myself(rowswap_write_cell_1),
        .write(write_commiter & (write_row_selector == 5'd1)),
        .set_my_color(color_setter),
        .my_color(cell_1_color),
        .cell_occ(hitscan[1])
    );

    wire [2:0] cell_2_color;
    memcell cell_2(
        .clk(clk),
        .reset(reset),
        .advance(advance_row),
        .prev_cell(rowswap_read_cell_2),
        .myself(rowswap_write_cell_2),
        .write(write_commiter & (write_row_selector == 5'd2)),
        .set_my_color(color_setter),
        .my_color(cell_2_color),
        .cell_occ(hitscan[2])
    );

    wire [2:0] cell_3_color;
    memcell cell_3(
        .clk(clk),
        .reset(reset),
        .advance(advance_row),
        .prev_cell(rowswap_read_cell_3),
        .myself(rowswap_write_cell_3),
        .write(write_commiter & (write_row_selector == 5'd3)),
        .set_my_color(color_setter),
        .my_color(cell_3_color),
        .cell_occ(hitscan[3])
    );

    wire [2:0] cell_4_color;
    memcell cell_4(
        .clk(clk),
        .reset(reset),
        .advance(advance_row),
        .prev_cell(rowswap_read_cell_4),
        .myself(rowswap_write_cell_4),
        .write(write_commiter & (write_row_selector == 5'd4)),
        .set_my_color(color_setter),
        .my_color(cell_4_color),
        .cell_occ(hitscan[4])
    );

    wire [2:0] cell_5_color;
    memcell cell_5(
        .clk(clk),
        .reset(reset),
        .advance(advance_row),
        .prev_cell(rowswap_read_cell_5),
        .myself(rowswap_write_cell_5),
        .write(write_commiter & (write_row_selector == 5'd5)),
        .set_my_color(color_setter),
        .my_color(cell_5_color),
        .cell_occ(hitscan[5])
    );

    wire [2:0] cell_6_color;
    memcell cell_6(
        .clk(clk),
        .reset(reset),
        .advance(advance_row),
        .prev_cell(rowswap_read_cell_6),
        .myself(rowswap_write_cell_6),
        .write(write_commiter & (write_row_selector == 5'd6)),
        .set_my_color(color_setter),
        .my_color(cell_6_color),
        .cell_occ(hitscan[6])
    );

    wire [2:0] cell_7_color;
    memcell cell_7(
        .clk(clk),
        .reset(reset),
        .advance(advance_row),
        .prev_cell(rowswap_read_cell_7),
        .myself(rowswap_write_cell_7),
        .write(write_commiter & (write_row_selector == 5'd7)),
        .set_my_color(color_setter),
        .my_color(cell_7_color),
        .cell_occ(hitscan[7])
    );

    wire [2:0] cell_8_color;
    memcell cell_8(
        .clk(clk),
        .reset(reset),
        .advance(advance_row),
        .prev_cell(rowswap_read_cell_8),
        .myself(rowswap_write_cell_8),
        .write(write_commiter & (write_row_selector == 5'd8)),
        .set_my_color(color_setter),
        .my_color(cell_8_color),
        .cell_occ(hitscan[8])
    );

    wire [2:0] cell_9_color;
    memcell cell_9(
        .clk(clk),
        .reset(reset),
        .advance(advance_row),
        .prev_cell(rowswap_read_cell_9),
        .myself(rowswap_write_cell_9),
        .write(write_commiter & (write_row_selector == 5'd9)),
        .set_my_color(color_setter),
        .my_color(cell_9_color),
        .cell_occ(hitscan[9])
    );

    wire [2:0] cell_10_color;
    memcell cell_10(
        .clk(clk),
        .reset(reset),
        .advance(advance_row),
        .prev_cell(rowswap_read_cell_10),
        .myself(rowswap_write_cell_10),
        .write(write_commiter & (write_row_selector == 5'd10)),
        .set_my_color(color_setter),
        .my_color(cell_10_color),
        .cell_occ(hitscan[10])
    );

    wire [2:0] cell_11_color;
    memcell cell_11(
        .clk(clk),
        .reset(reset),
        .advance(advance_row),
        .prev_cell(rowswap_read_cell_11),
        .myself(rowswap_write_cell_11),
        .write(write_commiter & (write_row_selector == 5'd11)),
        .set_my_color(color_setter),
        .my_color(cell_11_color),
        .cell_occ(hitscan[11])
    );

    wire [2:0] cell_12_color;
    memcell cell_12(
        .clk(clk),
        .reset(reset),
        .advance(advance_row),
        .prev_cell(rowswap_read_cell_12),
        .myself(rowswap_write_cell_12),
        .write(write_commiter & (write_row_selector == 5'd12)),
        .set_my_color(color_setter),
        .my_color(cell_12_color),
        .cell_occ(hitscan[12])
    );


endmodule
