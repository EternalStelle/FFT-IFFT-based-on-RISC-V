`include "define.v"
module id_ex (
    input wire clk,
    input wire rst,
    input wire[`instWidth-1:0] curr_pc,
    input wire[`instWidth-1:0] reg1_data,
    input wire[`instWidth-1:0] reg2_data,
    input wire[`instWidth-1:0] imm,
    input wire[4:0] reg_waddr,
    input wire branch,
    input wire reg_wena,
    input wire mem2reg,
    input wire mem_rena,
    input wire mem_wena,
    input wire[1:0] aluop,
    input wire alusrc,
    input wire[1:0] jump,
    input wire[2:0] funct3,
    input wire funct7,
    input wire pipelineFlush,
    input wire[4:0] reg1_raddr,
    input wire[4:0] reg2_raddr,
    input wire idex_hazarded,
    output reg[`instWidth-1:0] curr_pc_o,
    output reg[`instWidth-1:0] reg1_data_o,
    output reg[`instWidth-1:0] reg2_data_o,
    output reg[`instWidth-1:0] imm_o,
    output reg[4:0] reg_waddr_o,
    output reg branch_o,
    output reg reg_wena_o,
    output reg mem2reg_o,
    output reg mem_rena_o,
    output reg mem_wena_o,
    output reg[1:0] aluop_o,
    output reg alusrc_o,
    output reg[1:0] jump_o,
    output reg[2:0] funct3_o,
    output reg funct7_o,
    output reg[4:0] reg1_raddr_o,
    output reg[4:0] reg2_raddr_o
);
always @(posedge clk or negedge rst) begin
    if (!rst) begin
        curr_pc_o <= curr_pc;
        reg1_data_o <= reg1_data;
        reg2_data_o <= reg2_data;
        imm_o <= imm;
        reg_waddr_o <= reg_waddr;
        branch_o <= branch;
        reg_wena_o <= reg_wena;
        mem2reg_o <= mem2reg;
        mem_rena_o <= mem_rena;
        mem_wena_o <= mem_wena;
        aluop_o <= aluop;
        alusrc_o <= alusrc;
        jump_o <= jump;
        funct3_o <= funct3;
        funct7_o <= funct7;
        reg1_raddr_o <= reg1_raddr;
        reg2_raddr_o <= reg2_raddr;
        if (pipelineFlush || idex_hazarded) begin
            branch_o <= `funDisable;
            reg_wena_o <= `funDisable;
            mem_rena_o <= `funDisable;
            mem_wena_o <= `funDisable;
            jump_o <= 2'b00;
        end
    end else begin
        curr_pc_o <= `zeroWord;
        reg1_data_o <= `zeroWord;
        reg2_data_o <= `zeroWord;
        imm_o <= `zeroWord;
        reg_waddr_o <= 5'bxxxxx;
        branch_o <= `funDisable;
        reg_wena_o <= `funDisable;
        mem2reg_o <= `funDisable;
        mem_rena_o <= `funDisable;
        mem_wena_o <= `funDisable;
        aluop_o <= 2'bxx;
        alusrc_o <= 1'bx;
        jump_o <= 2'bxx;
        funct3_o <= 3'bxx;
        funct7_o <= 1'bx;
        reg1_raddr_o <= 5'bxxxxx;
        reg2_raddr_o <= 5'bxxxxx;
    end
end
endmodule