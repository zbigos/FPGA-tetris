`default_nettype none

module score_digit(
    input wire clk_25_175,
    input wire reset,
    input wire [6:0] mut_hreadwire,
    input wire [6:0] mut_vreadwire,
    output wire [11:0] pixstream,
    input wire [3:0] value
);

    wire top_bar;
    wire [11:0] pixstream_top;
    wire [11:0] on = 12'b000000001111;
    wire [11:0] off = 12'b000000000100;
    
    assign top_bar = (mut_hreadwire > 0 & mut_hreadwire < 5) & (mut_vreadwire > 2 & mut_vreadwire < 39);
    assign pixstream_top = top_bar ? ((value == 4'd0 | value == 4'd2 | value == 4'd3 | value == 4'd5 | value == 4'd6 | value == 4'd7 | value == 4'd8 | value == 4'd9) ? on : off) : 12'b000000000000;

    wire bot_bar;
    wire [11:0] pixstream_bot;
    assign bot_bar = (mut_hreadwire > 50 & mut_hreadwire < 55) & (mut_vreadwire > 2 & mut_vreadwire < 39);
    assign pixstream_bot = bot_bar ? ((value == 4'd0 | value == 4'd2 | value == 4'd3 | value == 4'd5 | value == 4'd6 | value == 4'd8 | value == 4'd8 | value == 4'd9) ? on : off) | pixstream_top : pixstream_top;

    wire mid_bar;
    wire [11:0] pixstream_mid;
    assign mid_bar = (mut_hreadwire > 25 & mut_hreadwire < 30) & (mut_vreadwire > 2 & mut_vreadwire < 39);
    assign pixstream_mid = mid_bar ? ((value == 4'd2 | value == 4'd3 |  value == 4'd4 | value == 4'd5 | value == 4'd6 | value == 4'd8 | value == 4'd9) ? on : off) | pixstream_bot : pixstream_bot;

    wire topr_bar;
    wire [11:0] pixstream_topr;
    assign topr_bar = (mut_hreadwire > 0 & mut_hreadwire < 30) & (mut_vreadwire > 2 & mut_vreadwire < 7);
    assign pixstream_topr = topr_bar ? ((value == 4'd0 | value == 4'd1 | value == 4'd2 | value == 4'd3 |  value == 4'd4 | value == 4'd7 | value == 4'd8 | value == 4'd9) ? on : off) | pixstream_mid : pixstream_mid;

    wire topl_bar;
    wire [11:0] pixstream_topl;
    assign topl_bar = (mut_hreadwire > 0 & mut_hreadwire < 30) & (mut_vreadwire > 34 & mut_vreadwire < 39);
    assign pixstream_topl = topl_bar ? ((value == 4'd0 | value == 4'd4 | value == 4'd5 |  value == 4'd6 | value == 4'd8 | value == 4'd9) ? on : off) | pixstream_topr : pixstream_topr;
    
    wire botl_bar;
    wire [11:0] pixstream_botl;
    assign botl_bar = (mut_hreadwire > 25 & mut_hreadwire < 55) & (mut_vreadwire > 34 & mut_vreadwire < 39);
    assign pixstream_botl = botl_bar ? ((value == 4'd0 | value == 4'd2 | value == 4'd6 |  value == 4'd8) ? on : off) | pixstream_topl : pixstream_topl;

    wire botr_bar;
    assign botr_bar = (mut_hreadwire > 25 & mut_hreadwire < 55) & (mut_vreadwire > 2 & mut_vreadwire < 7);
    assign pixstream = botr_bar ? ((value == 4'd0 | value == 4'd1 | value == 4'd3 | value == 4'd4 | value == 4'd5 | value == 4'd6 | value == 4'd7 | value == 4'd8 | value == 4'd9) ? on : off) | pixstream_botl : pixstream_botl;


endmodule