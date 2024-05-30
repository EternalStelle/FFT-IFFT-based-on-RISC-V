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
                        7'h10: alufunc = `aluFFTLoadData0;
                        7'h11: alufunc = `aluFFTLoadData1;
                        7'h12: alufunc = `aluFFTLoadData2;
                        7'h13: alufunc = `aluFFTLoadData3;
                        7'h14: alufunc = `aluFFTLoadData4;
                        7'h15: alufunc = `aluFFTLoadData5;
                        7'h16: alufunc = `aluFFTLoadData6;
                        7'h17: alufunc = `aluFFTLoadData7;
                        7'h18: alufunc = `aluFFTCAL1;
                        7'h19: alufunc = `aluFFTCAL2;
                        7'h1A: alufunc = `aluFFTCAL3;
                        7'h1B: alufunc = `aluFFTExportData0Real;
                        7'h1C: alufunc = `aluFFTExportData0Imag;
                        7'h1D: alufunc = `aluFFTExportData1Real;
                        7'h1E: alufunc = `aluFFTExportData1Imag;
                        7'h1F: alufunc = `aluFFTExportData2Real;
                        7'h21: alufunc = `aluFFTExportData2Imag;
                        7'h22: alufunc = `aluFFTExportData3Real;
                        7'h23: alufunc = `aluFFTExportData3Imag;
                        7'h24: alufunc = `aluFFTExportData4Real;
                        7'h25: alufunc = `aluFFTExportData4Imag;
                        7'h26: alufunc = `aluFFTExportData5Real;
                        7'h27: alufunc = `aluFFTExportData5Imag;
                        7'h28: alufunc = `aluFFTExportData6Real;
                        7'h29: alufunc = `aluFFTExportData6Imag;
                        7'h2A: alufunc = `aluFFTExportData7Real;
                        7'h2B: alufunc = `aluFFTExportData7Imag;
                        7'h2C: alufunc = `aluIFFTCAL1;
                        7'h2D: alufunc = `aluIFFTCAL2;
                        7'h2E: alufunc = `aluIFFTCAL3;
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
