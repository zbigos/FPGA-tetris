module timer(
    input wire clk,
    input wire reset,
    input wire[24:0] top,
    output wire led,
    output reg trigger 
);
    reg[24:0] counter; 
    assign led = counter[21];
    always @(posedge clk) begin
        if (!reset) begin
            counter <= 24'b0;
        end else begin            
            if (counter == top) begin
                counter <= 24'b0;
                trigger <= 1'b1;
            end else begin 
                counter <= counter + 1'b1;
                trigger <= 1'b0;
            end
        end
    end
endmodule 