`include "define.v"
module mux_pc (
    input wire[1:0] jump,
    input wire zero,
    input wire branch,
    input wire[`instWidth-1:0] ex_curr_pc,
    input wire[`instWidth-1:0] reg1_data,
    input wire[`instWidth-1:0] curr_pc,
    input wire[`instWidth-1:0] imm,
    input wire[`instWidth-1:0] pcWithImm,
    output reg pipelineFlush,
    output reg[`instWidth-1:0] next_pc
);

always @(*) begin
    if (jump == `jumpJAL) begin
        next_pc <= ex_curr_pc + imm;
        pipelineFlush <= `funEnable;
    end else if (jump == `jumpJALR) begin
        next_pc <= reg1_data + imm;
        pipelineFlush <= `funEnable;
    end else if (zero && branch) begin
        next_pc <= pcWithImm;
        pipelineFlush <= `funEnable;
    end else begin
        next_pc <= curr_pc + 4;
        pipelineFlush <= `funDisable;
    end 
end    
endmodule