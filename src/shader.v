module shader (
    input wire[5:0] block_x,
    input wire[5:0] block_y,
    input wire[11:0] in_color,
    output wire[11:0] out_color
);

    //wire on_edge = ((block_x == 0) | (block_x == 23) | (block_y == 0) | (block_y == 32));
    wire on_edge = (block_x <= 1) | (block_y == 0) | (block_y == 31) | (block_x >= 25);
    wire in_center = (block_x > 3) & (block_x < 21) & (block_y > 3) & (block_y < 28);
    wire on_border = !(on_edge | in_center);
    wire border_top = block_x > block_y;
    
    wire[11:0] ocolor = in_color;
    wire[11:0] dull_color = in_color & {3{4'b1100}};
    wire[11:0] super_dull_color = in_color & {3{4'b1000}};
    
    assign out_color = on_edge ? 12'b111111111111 : 12'b0
    | in_center ? dull_color : 12'b0
    | (on_border & border_top) ? ocolor : 12'b0
    | (on_border & !border_top) ? super_dull_color : 12'b0;

endmodule// shader
