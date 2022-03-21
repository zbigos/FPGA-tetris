`default_nettype none

module scoredisplay(
    input wire clk_25_175,
    input wire reset,
    input wire [9:0] hreadwire,
    input wire [9:0] vreadwire,
    output wire [11:0] pixstream,
    input wire [15:0] scorewire
);

    // dostępne mam 380 pikseli na szerokość
    // 120 pikseli na wysokość 
    // liczę border na 10 pikseli. Ratio pikseli to 32 wysokości na 24 szerokości.
    // przy wysokości 100 pikseli (z borderami) wychodzi mi 133 szerokości
    // L=5, R=11
    // middle @8,8
    reg [4:0] values [7:0];
    reg [7:0] valused;
    reg [20:0] dumpvar;

    always @(posedge clk_25_175) begin
        if (!reset) begin
            values[0] <= 4'b0;
            values[1] <= 4'b0;
            values[2] <= 4'b0;
            values[3] <= 4'b0;
            values[4] <= 4'b0;
            values[5] <= 4'b0;
            values[6] <= 4'b0;
            values[7] <= 4'b0;
            dumpvar <= 21'b0;
            valused <= 8'b00000000;
        end else begin
            if (scorewire > 0) begin
                dumpvar <= dumpvar + scorewire;
            end else if (dumpvar > 0) begin
                dumpvar <= dumpvar - 1'b1;
                if (values[7] < 4'd9) begin
                    values[7] <= values[7] + 1'b1;
                    valused[7] <= 1'b1;
                end else begin
                    values[7] <= 4'b0;
                    if (values[6] < 4'd9) begin
                        valused[6] <= 1'b1;
                        values[6] <= values[6] + 1'b1;
                    end else begin
                        values[6] <= 4'b0;
                        if (values[5] < 4'd9) begin
                            valused[5] <= 1'b1;
                            values[5] <= values[5] + 1'b1;
                        end else begin
                            values[5] <= 4'b0;
                            if (values[4] < 4'd9) begin
                                valused[4] <= 1'b1;
                                values[4] <= values[4] + 1'b1;
                            end else begin
                                values[4] <= 4'b0;
                                if (values[3] < 4'd9) begin
                                    valused[3] <= 1'b1;
                                    values[3] <= values[3] + 1'b1;
                                end else begin
                                    values[3] <= 4'b0;
                                    if (values[2] < 4'd9) begin
                                        values[2] <= values[2] + 1'b1;
                                        valused[2] <= 1'b1;
                                    end else begin
                                        values[2] <= 4'b0;
                                        if (values[1] < 4'd9) begin
                                            values[1] <= values[1] + 1'b1;
                                            valused[1] <= 1'b1;
                                        end else begin
                                            values[1] <= 4'b0;
                                            if (values[0] < 4'd9) begin
                                                values[0] <= values[0] + 1'b1;
                                                valused[0] <= 1'b1;
                                            end else begin
                                                values[0] <= 4'b0;
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end


    wire [11:0] __pixstream1;
    wire inside_cell1;
    assign inside_cell1 = (vreadwire >= 375-3 & vreadwire < 417-3) & (hreadwire >= 567 & hreadwire < 623); 
    wire [11:0] pixstream1;
    assign pixstream1 = inside_cell1 ? __pixstream1 : 12'b000000000000;
    score_digit s1(.clk_25_175(clk_25_175), .reset(reset), .mut_hreadwire(hreadwire - 567), .mut_vreadwire(vreadwire - 372), .pixstream(__pixstream1), .value(valused[0] ? values[0] : 4'b1111));


    wire [11:0] __pixstream2;
    wire inside_cell2;
    assign inside_cell2 = (vreadwire >= 329-3 & vreadwire < 370-3) & (hreadwire >= 567 & hreadwire < 623); 
    wire [11:0] pixstream2;
    assign pixstream2 = inside_cell2 ? __pixstream2 : pixstream1;
    score_digit s2(.clk_25_175(clk_25_175), .reset(reset), .mut_hreadwire(hreadwire - 567), .mut_vreadwire(vreadwire - 326), .pixstream(__pixstream2), .value(valused[1] ? values[1] : 4'b1111));

    wire [11:0] __pixstream3;
    wire inside_cell3;
    assign inside_cell3 = (vreadwire >= 283-3 & vreadwire < 324-3) & (hreadwire >= 567 & hreadwire < 623); 
    wire [11:0] pixstream3;
    score_digit s3(.clk_25_175(clk_25_175), .reset(reset), .mut_hreadwire(hreadwire - 567), .mut_vreadwire(vreadwire - 280), .pixstream(__pixstream3), .value(valused[2] ? values[2] : 4'b1111));
    assign pixstream3 = inside_cell3 ? __pixstream3 : pixstream2;

    wire [11:0] __pixstream4;
    wire inside_cell4;
    assign inside_cell4 = (vreadwire >= 237-3 & vreadwire < 278-3) & (hreadwire >= 567 & hreadwire < 623); 
    wire [11:0] pixstream4;
    score_digit s4(.clk_25_175(clk_25_175), .reset(reset), .mut_hreadwire(hreadwire - 567), .mut_vreadwire(vreadwire - 234), .pixstream(__pixstream4), .value(valused[3] ? values[3] : 4'b1111));
    assign pixstream4 = inside_cell4 ? __pixstream4 : pixstream3;

    wire [11:0] __pixstream5;
    wire inside_cell5;
    assign inside_cell5 = (vreadwire >= 191-3 & vreadwire < 232-3) & (hreadwire >= 567 & hreadwire < 623); 
    wire [11:0] pixstream5;
    score_digit s5(.clk_25_175(clk_25_175), .reset(reset), .mut_hreadwire(hreadwire - 567), .mut_vreadwire(vreadwire - 188), .pixstream(__pixstream5), .value(valused[4] ? values[4] : 4'b1111));
    assign pixstream5 = inside_cell5 ? __pixstream5 : pixstream4;

    wire [11:0] __pixstream6;
    wire inside_cell6;
    assign inside_cell6 = (vreadwire >= 145-3 & vreadwire < 186-3) & (hreadwire >= 567 & hreadwire < 623); 
    wire [11:0] pixstream6;
    score_digit s6(.clk_25_175(clk_25_175), .reset(reset), .mut_hreadwire(hreadwire - 567), .mut_vreadwire(vreadwire - 142), .pixstream(__pixstream6), .value(valused[5] ? values[5] : 4'b1111));
    assign pixstream6 = inside_cell6 ? __pixstream6 : pixstream5;

    wire [11:0] __pixstream7;
    wire inside_cell7;
    assign inside_cell7 = (vreadwire >= 99-3 & vreadwire < 140-3) & (hreadwire >= 567 & hreadwire < 623); 
    wire [11:0] pixstream7;
    score_digit s7(.clk_25_175(clk_25_175), .reset(reset), .mut_hreadwire(hreadwire - 567), .mut_vreadwire(vreadwire - 96), .pixstream(__pixstream7), .value(valused[6] ? values[6] : 4'b1111));
    assign pixstream7 = inside_cell7 ? __pixstream7 : pixstream6;

    wire ech_inside;
    assign ech_inside = (vreadwire >= 42 & vreadwire < 422) & (hreadwire >= 562 & hreadwire < 628); 
    wire [11:0] __pixstream8;
    wire inside_cell8;
    score_digit s8(.clk_25_175(clk_25_175), .reset(reset), .mut_hreadwire(hreadwire - 567), .mut_vreadwire(vreadwire - 50), .pixstream(__pixstream8), .value(valused[7] ? values[7] : 4'b1111));
    assign inside_cell8 = (vreadwire >= 53-3 & vreadwire < 94-3) & (hreadwire >= 567 & hreadwire < 623); 
    assign pixstream = inside_cell8 ? __pixstream8 : (ech_inside ? pixstream7 : 12'b111111111111);

endmodule
