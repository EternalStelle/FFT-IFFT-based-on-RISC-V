`include "define.v"
module alu (
    input wire[`instWidth-1:0] alusrc1,
    input wire[`instWidth-1:0] alusrc2,
    input wire[`aluOP-1:0] aluop,
    output reg[`instWidth-1:0] alu_result,
    output reg zero
);
always @(*) begin
    case (aluop)
    `aluPlus: alu_result = alusrc1 + alusrc2;
    `aluSub: alu_result = alusrc1 - alusrc2;
    `aluMul: alu_result = alusrc1 * alusrc2;
    `aluXor: alu_result = alusrc1 ^ alusrc2;
    `aluOr: alu_result = alusrc1 | alusrc2;
    `aluAnd: alu_result = alusrc1 & alusrc2;
    `aluSLL: alu_result = alusrc1 << alusrc2;
    `aluSRL: alu_result = alusrc1 >> alusrc2;
    `aluSRA: alu_result = alusrc1 >>> alusrc2;
    `aluSLT: alu_result = ($signed(alusrc1) < $signed(alusrc2)) ? 1'b1 : 1'b0; 
    `aluSLTU: alu_result = (alusrc1 < alusrc2) ? 1'b1 : 1'b0;
    `aluBEQ: begin
        alu_result <= 32'hxxxxxxxx;
        zero = (alusrc1 == alusrc2) ? 1'b1 : 1'b0;
    end
    `aluBNE: begin
        alu_result <= 32'hxxxxxxxx;
        zero = (alusrc1 != alusrc2) ? 1'b1 : 1'b0;
    end 
    `aluBLT: begin
        alu_result <= 32'hxxxxxxxx;
        zero = (alusrc1 < alusrc2) ? 1'b1 : 1'b0;
    end 
    `aluBGE: begin
        alu_result <= 32'hxxxxxxxx;
        zero = (alusrc1 >= alusrc2) ? 1'b1 : 1'b0;
    end  
    endcase
end
endmodule