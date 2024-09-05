`include "define.v"
module alusrc (
    //ALU数据源选择器
    input wire alusel,
    input wire [`instWidth-1:0] reg2_data,
    input wire [`instWidth-1:0] imm,
    output wire [`instWidth-1:0] alu_src
);
    assign alu_src = (alusel) ? imm : reg2_data;
endmodule
