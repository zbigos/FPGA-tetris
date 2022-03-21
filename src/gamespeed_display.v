`default_nettype none

module topbar_display(
    input wire clk_25_175,
    input wire reset,
    input wire [9:0] hreadwire,
    input wire [9:0] vreadwire,
    input wire bump,
    output wire [11:0] pixstream,
    output reg[23:0] gamespeed
);

    wire inside;
    assign inside = (vreadwire >= 42 & vreadwire < 422) & (hreadwire >= 7 & hreadwire < 33); 
    assign pixstream = inside ? ipixstream : 12'b111111111111;
    wire [11:0] ipixstream;
    assign ipixstream = ((10'd422 - vreadwire) < fillstate) ? 12'b000000001111 : (((10'd392 - vreadwire) < fillstate) ? {4'b0000, 4'b0000, (fillstate - (10'd392 - vreadwire)) >> 1} : 12'b000000000000);
    wire [9:0] fillstate = 10'd38 * state;
    reg [3:0] state;

    always @(posedge clk_25_175) begin
        if (!reset) begin
            state <= 4'd1;
            gamespeed <= 24'b111111111111111111111111;
        end else begin
            if (bump) begin
                if (state < 4'd10) begin
                    state <= state + 1'b1;
                end else begin
                    state <= 1'b0;
                    gamespeed <= gamespeed - (gamespeed >> 3);
                end
            end
        end
    end
    // step by 38

endmodule