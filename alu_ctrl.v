`include "define.v"
module alu_ctrl (input wire[1:0] aluop,
                 input wire[2:0] funct3,
                 input wire funct7,
                 output reg[3:0] alufunc);
    always @(*) begin
        case (aluop)
            `aluR: begin
                case (funct3)
                    3'h0: alufunc = (funct7) ? `aluSub : `aluPlus;
                    3'h4: alufunc = `aluXor;
                    3'h6: alufunc = `aluOr;
                    3'h7: alufunc = `aluAnd;
                    3'h1: alufunc = `aluSLL;
                    3'h5: alufunc = (funct7) ? `aluSRA : `aluSRL;
                    3'h2: alufunc = `aluSLT;
                    3'h3: alufunc = `aluSLTU;
                endcase
            end
            `aluStore: alufunc = `aluPlus;
            `aluLoad: alufunc  = `aluPlus;
            `aluBranch:
            case (funct3)
                3'h0: alufunc = `aluBEQ;
                3'h1: alufunc = `aluBNE;
                3'h4: alufunc = `aluBLT;
                3'h5: alufunc = `aluBGE;
            endcase
        endcase
    end
endmodule
