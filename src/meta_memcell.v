
`default_nettype none
module memcell (
    input wire clk,
    input wire reset,

    input wire advance,
    input wire[2:0] prev_cell, // wires to cell above me
    output wire[2:0] myself, // my wires, give to cell below me

    input wire write,
    input wire[2:0] set_my_color,
    output wire[2:0] my_color, // my wires, lend to gpu
    output wire cell_occ, // is there anything inside of me
);

    reg [2: 0] priv_mem;
    assign my_color = priv_mem;
    assign myself = priv_mem;
    assign cell_occ = priv_mem != 3'b0;

    always @(posedge clk) begin
        if(!reset) begin
            priv_mem <= 3'b0;
        end else begin
            if (write) begin
                priv_mem <= set_my_color;
            end else if (advance) begin
                priv_mem <= prev_cell;
            end
        end
    end
endmodule
