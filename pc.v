`include "define.v"
module pc (
    input wire clk,
    input wire rst,
    input wire pc_hazarded,
    input wire [`instWidth-1:0] next_pc,
    output reg [`instWidth-1:0] curr_pc
);

    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            if (!pc_hazarded) begin
                curr_pc <= next_pc;
            end
        end else begin
            curr_pc <= `zeroWord;
        end
    end
endmodule
