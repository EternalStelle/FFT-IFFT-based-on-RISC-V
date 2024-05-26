`include "define.v"
module alusrc (
    input wire[1:0] alusel,
    input wire[`instWidth-1:0] reg2_data,
    input wire[`instWidth-1:0] imm,
    output reg[`instWidth-1:0] alu_src
);
always @(*) begin
    case (alusel)
    2'b00: alu_src = reg2_data;
    2'b01: alu_src = imm;
    2'b10: alu_src = imm;
    endcase
end
endmodule