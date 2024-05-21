`include "define.v"
module alusrc (
    input wire alusel,
    input wire[`instWidth-1:0] reg2_data,
    input wire[`instWidth-1:0] imm,
    output wire[`instWidth-1:0] alu_src
);
assign alu_src = (alusel) ? reg2_data : imm;
endmodule