`default_nettype none
`timescale 1ns/1ns

module color_lut(
    output reg [11:0] color,
    input wire [2:0] type, 
);
    always @* case(type) 
        3'b000 : color <= {4'b0110, 4'b0110, 4'b0110}; /* noblock */
        3'b001 : color <= {4'b0000, 4'b1111, 4'b1111}; /* cyan */
        3'b010 : color <= {4'b1111, 4'b1111, 4'b0000}; /* yellow */
        3'b011 : color <= {4'b1100, 4'b0000, 4'b1100}; /* purple */
        3'b100 : color <= {4'b0000, 4'b1111, 4'b0000}; /* green */
        3'b101 : color <= {4'b1111, 4'b0000, 4'b0000}; /* red */
        3'b110 : color <= {4'b0000, 4'b0000, 4'b1111}; /* blue */
        3'b111 : color <= {4'b1111, 4'b0111, 4'b0000}; /* orange */
    endcase
endmodule
