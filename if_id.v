`include "define.v"
module if_id (
    input wire clk,
    input wire rst,
    input wire pipelineFlush,
    input wire ifid_hazarded,
    input wire[`instWidth-1:0] curr_pc,
    input wire[`instWidth-1:0] inst,
    output reg[`instWidth-1:0] curr_pc_o,
    output reg[`instWidth-1:0] inst_o
);
always @(posedge clk or negedge rst) begin
    if (!rst) begin
        if (!ifid_hazarded) begin
        curr_pc_o <= curr_pc;
        inst_o <= inst;
        if (pipelineFlush) begin
            inst_o <= `zeroWord;
        end
        end
    end else begin
        curr_pc_o <= `zeroWord;
        inst_o <= `zeroWord;
    end
end
endmodule