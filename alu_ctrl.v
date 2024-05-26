`include "define.v"
module alu_ctrl (input wire[1:0] aluop,
                 input wire[2:0] funct3,
                 input wire[6:0] funct7,
                 output reg[`aluOP-1:0] alufunc);
    always @(*) begin
        case (aluop)
            `aluR: begin
                case (funct3)
                    3'h0: case (funct7)
                        7'h00: alufunc = `aluPlus;
                        7'h20: alufunc = `aluSub;
                        7'h01: alufunc = `aluMul;
                        /*
                        7'h10: alufunc = `aluFFTLoad;
                        7'h02: alufunc = `aluFFTCAL;
                        7'h03: alufunc = `aluFFTExport;
                        */
                    endcase
                    3'h4: alufunc = `aluXor;
                    3'h6: alufunc = `aluOr;
                    3'h7: alufunc = `aluAnd;
                    3'h1: alufunc = `aluSLL;
                    3'h5: alufunc = (funct7 == 7'h20) ? `aluSRA : `aluSRL;
                    3'h2: alufunc = `aluSLT;
                    3'h3: alufunc = `aluSLTU;
                endcase
            end
            `aluStore: alufunc = `aluPlus;
            `aluLoad: begin
                if (funct3 == 3'h2) begin
                    alufunc = `aluPlus;
                end else begin
                    alufunc = `aluLUI;
                end
            end
            `aluBranch:
            case (funct3)
                3'h0: alufunc = `aluBEQ;
                3'h1: alufunc = `aluBNE;
                3'h4: alufunc = `aluBLT;
                3'h5: alufunc = `aluBGE;
            endcase
            `aluSrcAUIPC: begin
                alufunc = `aluAUIPC;
            end
        endcase
    end
endmodule
