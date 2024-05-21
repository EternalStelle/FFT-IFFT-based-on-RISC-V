`include "define.v"
module pc (input wire clk,
           input wire rst,
           input wire pc_hazarded,
           input wire[1:0] jump,
           input wire zero,
           input wire branch,
           input wire[`instWidth-1:0] ex_curr_pc,
           input wire[`instWidth-1:0] reg1_data,
           input wire[`instWidth-1:0] imm,
           input wire[`instWidth-1:0] pcWithImm,
           output reg pipelineFlush,
           output reg[`instWidth-1:0] curr_pc);
    
    initial begin
        curr_pc <= `zeroWord;
    end
    
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            if (jump == `jumpJAL) begin
                curr_pc       <= ex_curr_pc + imm;
                pipelineFlush <= `funEnable;
                end else if (jump == `jumpJALR) begin
                curr_pc       <= reg1_data + imm;
                pipelineFlush <= `funEnable;
                end else if (zero && branch) begin
                curr_pc       <= pcWithImm;
                pipelineFlush <= `funEnable;
                end else begin
                if (!pc_hazarded) begin
                    curr_pc       <= curr_pc + `instWidth'h4;
                    pipelineFlush <= `funDisable;
                end
            end
        end
    end
endmodule
