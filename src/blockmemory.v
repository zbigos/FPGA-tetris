module blkmemory # (
    parameter BLOCKS_VERTICAL = 10, //20
    parameter BLOCKS_HORIZONTAL = 20, //10    
) (
    input wire clk,
    input wire reset,
    input wire[4:0] vaddr,
    input wire[4:0] haddr,
    output reg[2:0] memval,
);

    reg [2:0] gamemem [0:20][0:20];

    assign memval = gamemem[vaddr][haddr];
    integer i;
    integer j;
    always @(posedge clk) begin
        if(!reset) begin
            for(i = 0; i < 20; i = i + 1) begin
                for(j = 0; j < 20; j = j + 1) begin
                    gamemem[i][j] <= 3'b000;
                end
            end
            gamemem[1][1] = 3'b000;
            gamemem[1][2] = 3'b001;
            gamemem[1][3] = 3'b010;
            gamemem[1][4] = 3'b011;
            gamemem[1][5] = 3'b100;
            gamemem[1][6] = 3'b101;
            gamemem[1][7] = 3'b110;
            gamemem[1][8] = 3'b111;
        end
    end

endmodule
