`include "define.v"
//MUX_PC模块
module mux_pc (
    input wire [1:0] jump, //跳转指令的类型
    input wire zero, //ALU计算结果为0
    input wire branch, //是否为分支指令
    input wire [`instWidth-1:0] ex_curr_pc, //EX阶段指令的PC值
    input wire [`instWidth-1:0] reg1_data,
    input wire [`instWidth-1:0] curr_pc,
    input wire [`instWidth-1:0] imm,
    input wire [`instWidth-1:0] pcWithImm, //PC值与立即数之和
    output reg pipelineFlush, //清空流水线
    output reg [`instWidth-1:0] next_pc
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
