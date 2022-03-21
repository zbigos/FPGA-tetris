`default_nettype none

module screen_manager(
    input wire[9:0] h_readwire,
    input wire[9:0] v_readwire,
    output wire board_stream_priori,
    output wire top_view_priori,
    output wire scorecounter_priority,
);

    assign board_stream_priori = (v_readwire >= 40 & v_readwire < 424) & (h_readwire >= 41 & h_readwire < 547);
    assign top_view_priori = (v_readwire >= 40 & v_readwire < 424) & (h_readwire >= 5 & h_readwire < 35);
    assign scorecounter_priority = (v_readwire >= 40 & v_readwire < 424) & (h_readwire >= 10'd560 & h_readwire < 10'd630);
endmodule