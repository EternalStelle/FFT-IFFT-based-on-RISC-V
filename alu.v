`include "define.v"
module alu (
    //input wire clk,
    input signed [`instWidth-1:0] alusrc1,
    input signed [`instWidth-1:0] alusrc2,
    input wire[`instWidth-1:0] curr_pc,
    input wire [`aluOP-1:0] aluop,
    output reg[`instWidth-1:0] alu_result,
    output reg zero
);

always @(*) begin
    zero  <= 1'b0;
    case (aluop)
    `aluPlus: alu_result <= alusrc1 + alusrc2;
    `aluSub: alu_result <= alusrc1 - alusrc2;
    `aluMul: alu_result <= alusrc1 * alusrc2;
    `aluXor: alu_result <= $unsigned(alusrc1) ^ $unsigned(alusrc2);
    `aluOr: alu_result <= $unsigned(alusrc1) | $unsigned(alusrc2);
    `aluAnd: alu_result <= $unsigned(alusrc1) & $unsigned(alusrc2);
    `aluSLL: alu_result <= $unsigned(alusrc1) << $unsigned(alusrc2);
    `aluSRL: alu_result <= $unsigned(alusrc1) >> $unsigned(alusrc2);
    `aluSRA: alu_result <= $unsigned(alusrc1) >>> $unsigned(alusrc2);
    `aluSLT: alu_result <= (alusrc1 < alusrc2) ? 1'b1 : 1'b0; 
    `aluSLTU: alu_result <= ($unsigned(alusrc1) < $unsigned(alusrc2)) ? 1'b1 : 1'b0;
    `aluBEQ: begin
        alu_result <= 32'hxxxxxxxx;
        zero <= (alusrc1 == alusrc2) ? 1'b1 : 1'b0;
    end
    `aluBNE: begin
        alu_result <= 32'hxxxxxxxx;
        zero <= (alusrc1 != alusrc2) ? 1'b1 : 1'b0;
    end 
    `aluBLT: begin
        alu_result <= 32'hxxxxxxxx;
        zero <= (alusrc1 < alusrc2) ? 1'b1 : 1'b0;
    end 
    `aluBGE: begin
        alu_result <= 32'hxxxxxxxx;
        zero <= (alusrc1 >= alusrc2) ? 1'b1 : 1'b0;
    end
    `aluLUI: alu_result <= alusrc2;
    `aluAUIPC: alu_result <= curr_pc + alusrc2;
    default: alu_result <= alusrc1 + alusrc2;
    endcase
end
endmodule