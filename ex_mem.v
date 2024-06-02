`include "define.v"
module ex_mem (
    input wire clk,
    input wire rst,
    input wire [`instWidth-1:0] pcWithImm,
    input wire zero,
    input wire [`instWidth-1:0] alu_result,
    input wire branch,
    input wire mem_rena,
    input wire mem_wena,
    input wire mem2reg,
    input wire [`instWidth-1:0] reg2_data,
    input wire [4:0] reg_waddr,
    input wire reg_wena,
    output reg [`instWidth-1:0] pcWithImm_o,
    output reg zero_o,
    output reg [`instWidth-1:0] alu_result_o,
    output reg branch_o,
    output reg mem_rena_o,
    output reg mem_wena_o,
    output reg mem2reg_o,
    output reg [`instWidth-1:0] reg2_data_o,
    output reg [4:0] reg_waddr_o,
    output reg reg_wena_o
);
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            pcWithImm_o <= pcWithImm;
            zero_o <= zero;
            alu_result_o <= alu_result;
            branch_o <= branch;
            mem_rena_o <= mem_rena;
            mem_wena_o <= mem_wena;
            mem2reg_o <= mem2reg;
            reg2_data_o <= reg2_data;
            reg_waddr_o <= reg_waddr;
            reg_wena_o <= reg_wena;
        end else begin
            pcWithImm_o <= `zeroWord;
            zero_o <= 1'bx;
            alu_result_o <= `zeroWord;
            branch_o <= `funDisable;
            mem_rena_o <= `funDisable;
            mem_wena_o <= `funDisable;
            mem2reg_o <= `funDisable;
            reg2_data_o <= `zeroWord;
            reg_waddr_o <= 5'bxxxxx;
            reg_wena_o <= `funDisable;
        end
    end
endmodule
