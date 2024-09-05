`include "define.v"
module if_id (
//IF_ID流水线寄存器
    input wire clk,
    input wire rst,
    input wire pipelineFlush, //流水线清空
    input wire ifid_hazarded, //IF_ID控制冒险信号
    input wire [`instWidth-1:0] curr_pc,
    input wire [`instWidth-1:0] inst,
    output reg [`instWidth-1:0] curr_pc_o,
    output reg [`instWidth-1:0] inst_o
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
