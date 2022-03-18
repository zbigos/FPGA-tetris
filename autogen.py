import itertools

MEMORY_SIZE_DIM1 = 13
MEMORY_SIZE_DIM2 = 22
MEMORY_DEPTH = 3

memory_cell = f"""
`default_nettype none
module memcell (
    input wire clk,
    input wire reset,

    input wire advance,
    input wire[{MEMORY_DEPTH-1}:0] prev_cell, // wires to cell above me
    output wire[{MEMORY_DEPTH-1}:0] myself, // my wires, give to cell below me

    input wire write,
    input wire[{MEMORY_DEPTH-1}:0] set_my_color,
    output wire[{MEMORY_DEPTH-1}:0] my_color, // my wires, lend to gpu
    output wire cell_occ, // is there anything inside of me
);

    reg [{MEMORY_DEPTH-1}: 0] priv_mem;
    assign my_color = priv_mem;
    assign myself = priv_mem;
    assign cell_occ = |priv_mem;

    always @(posedge clk) begin
        if(!reset) begin
            priv_mem <= {MEMORY_DEPTH}'b0;
        end else begin
            if (write) begin
                priv_mem <= set_my_color;
            end else if (advance) begin
                priv_mem <= prev_cell;
            end
        end
    end
endmodule
"""

with open("src/meta_memcell.v", "w") as metamem:
    metamem.write(memory_cell)

input_string = ",\n".join(f"    input wire[{MEMORY_DEPTH-1}:0] rowswap_read_cell_{i}" for i in range(MEMORY_SIZE_DIM1))
output_string = ",\n".join(f"    output wire[{MEMORY_DEPTH-1}:0] rowswap_write_cell_{i}" for i in range(MEMORY_SIZE_DIM1))
color_muxer = "|".join(f"((color_requestor == 6'd{i}) ? cell_{i}_color : {MEMORY_DEPTH}'d0)" for i in range(MEMORY_SIZE_DIM1))

memcell_initializer = "\n".join(f"""
    wire [{MEMORY_DEPTH-1}:0] cell_{i}_color;
    memcell cell_{i}(
        .clk(clk),
        .reset(reset),
        .advance(advance_row),
        .prev_cell(rowswap_read_cell_{i}),
        .myself(rowswap_write_cell_{i}),
        .write(write_commiter & (write_row_selector == 5'd{i})),
        .set_my_color(color_setter),
        .my_color(cell_{i}_color),
        .cell_occ(hitscan[{i}])
    );""" for i in range(MEMORY_SIZE_DIM1))

memory_row = f"""
`default_nettype none
module memcell_row (
    input wire clk,
    input wire reset,
    input wire advance_row,
    // generate swap wires (inbound)
{input_string}, 
    // generate swap wires (outbound)
{output_string},

    // what color to write
    input wire[{MEMORY_DEPTH-1}:0] color_setter,
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
    output wire[{MEMORY_DEPTH-1}:0] gpu_color,
    output wire[5:0] color_requestor
);

    wire [{MEMORY_SIZE_DIM1-1}:0] hitscan;
    assign row_full = |hitscan;
    assign hitbox_status = {{hitscan[hitbox_checker_0], hitscan[hitbox_checker_1], hitscan[hitbox_checker_2], hitscan[hitbox_checker_3]}};
    assign gpu_color = ({color_muxer});

{memcell_initializer}


endmodule
"""

with open("src/meta_memrow.v", "w") as metamem:
    metamem.write(memory_row)

cell_exchange = "\n".join(f"    wire [{MEMORY_DEPTH-1}:0] cellswap_layers_{i}_{i+1}_cell_{j};" for (i, j) in itertools.product(range(MEMORY_SIZE_DIM2), range(MEMORY_SIZE_DIM1)))

def gen_rowio(cell_id):
    def gen_icell(cell_id):
        if cell_id == 0:
            return "\n".join(f'        .rowswap_read_cell_{i}(3\'b0),' for i in range(MEMORY_SIZE_DIM1))
        return "\n".join(f'        .rowswap_read_cell_{i}(cellswap_layers_{cell_id-1}_{cell_id}_cell_{i}),' for i in range(MEMORY_SIZE_DIM1))

    def gen_ocell(cell_id):
        return "\n".join(f'        .rowswap_write_cell_{i}(cellswap_layers_{cell_id}_{cell_id+1}_cell_{i}),' for i in range(MEMORY_SIZE_DIM1))
    
    celldef = f"""
    wire [{MEMORY_DEPTH-1}:0] row_color_{cell_id};
    memcell_row row_{cell_id}(
        .clk(clk),
        .reset(reset),
        .advance_row(rowshift_cmd[{cell_id}]),
        .color_setter(color_setter),
        .write_row_selector(color_set_requestor_x),
        .write_commiter(color_commit & (color_set_requestor_y == 6'd{cell_id})),
        .row_full(rowfull_stat[{cell_id}]),
        .hitbox_checker_0(hitbox_checker_0_x),
        .hitbox_checker_1(hitbox_checker_1_x),
        .hitbox_checker_2(hitbox_checker_2_x),
        .hitbox_checker_3(hitbox_checker_3_x),
        .hitbox_status({{hitscan0[{cell_id}], hitscan1[{cell_id}], hitscan2[{cell_id}], hitscan3[{cell_id}]}}),
        .gpu_color(row_color_{cell_id}),
        .color_requestor(color_requestor_x),
{gen_icell(cell_id)}
{gen_ocell(cell_id)}
    );
    """
    return celldef
        

memrow_input_string = ",\n".join(f"        .rowswap_read_cell_{i}()" for i in range(MEMORY_SIZE_DIM1))
memrow_output_string = ",\n".join(f"        .rowswap_write_cell_{i}()" for i in range(MEMORY_SIZE_DIM1))
color_selector = " | ".join(f"((color_requestor_y == 6'd{i}) ? row_color_{i} : 3'b0)" for i in range(MEMORY_SIZE_DIM2))

hitdump1 = " | ".join(f"((hitbox_checker_0_y == 6'd{i}) ? hitscan0[{i}] : 1'b0)" for i in range(MEMORY_SIZE_DIM2))
hitdump2 = " | ".join(f"((hitbox_checker_1_y == 6'd{i}) ? hitscan1[{i}] : 1'b0)" for i in range(MEMORY_SIZE_DIM2))
hitdump3 = " | ".join(f"((hitbox_checker_2_y == 6'd{i}) ? hitscan2[{i}] : 1'b0)" for i in range(MEMORY_SIZE_DIM2))
hitdump4 = " | ".join(f"((hitbox_checker_3_y == 6'd{i}) ? hitscan3[{i}] : 1'b0)" for i in range(MEMORY_SIZE_DIM2))


memrow_initializer = "\n".join(gen_rowio(i) for i in range(MEMORY_SIZE_DIM2))

memory_block = f"""
`default_nettype none

module memory (
    input wire clk,
    input wire reset,
    input wire memory_busy,

    // color reading
    input wire[5:0] color_requestor_x,
    input wire[5:0] color_requestor_y,
    output wire[{MEMORY_DEPTH-1}:0] color_getter,

    // color writing
    input wire[5:0] color_set_requestor_x,
    input wire[5:0] color_set_requestor_y,
    input wire color_commit,
    input wire[{MEMORY_DEPTH-1}:0] color_setter,

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

    input wire [22:0] rowfull_stat,
    input wire [22:0] rowshift_cmd,
    
);
    assign rowshift_cmd = 23'b0;


    wire [22:0] hitscan0;
    wire [22:0] hitscan1;
    wire [22:0] hitscan2;
    wire [22:0] hitscan3;


{cell_exchange}

{memrow_initializer}
    assign color_getter = ({color_selector});

    wire hitdump1, hitdump2, hitdump3, hitdump4;

    assign hitbox_status[0] = ({hitdump1});
    assign hitbox_status[1] = ({hitdump2});
    assign hitbox_status[2] = ({hitdump3});
    assign hitbox_status[3] = ({hitdump4});

endmodule
"""

with open("src/meta_mem.v", "w") as metamem:
    metamem.write(memory_block)
