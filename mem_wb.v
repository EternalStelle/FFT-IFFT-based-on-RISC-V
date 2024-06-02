`include "define.v"
module mem_wb (
    input wire clk,
    input wire rst,
    input wire [`instWidth-1:0] mem_data,
    input wire [`instWidth-1:0] alu_result,
    input wire mem2reg,
    input wire [4:0] reg_waddr,
    input wire reg_wena,
    output reg [`instWidth-1:0] mem_data_o,
    output reg [`instWidth-1:0] alu_result_o,
    output reg mem2reg_o,
    output reg [4:0] reg_waddr_o,
    output reg reg_wena_o
);
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            mem_data_o <= mem_data;
            alu_result_o <= alu_result;
            mem2reg_o <= mem2reg;
            reg_waddr_o <= reg_waddr;
            reg_wena_o <= reg_wena;
        end else begin
            mem_data_o <= `zeroWord;
            alu_result_o <= `zeroWord;
            mem2reg_o <= `funDisable;
            reg_waddr_o <= 5'bxxxxx;
            reg_wena_o <= `funDisable;
        end
    end
endmodule
