`include "define.v"
module alu (
    //input wire clk,
    input signed [`instWidth-1:0] alusrc1,
    input signed [`instWidth-1:0] alusrc2,
    input wire [`instWidth-1:0] curr_pc,
    input wire [`aluOP-1:0] aluop,
    output reg [`instWidth-1:0] alu_result,
    output reg zero
);
    //初始化FFT/IFFT计算所需数据
    reg signed [  `instWidth-1:0] fft_d0_real;
    reg signed [  `instWidth-1:0] fft_d0_imag;
    reg signed [  `instWidth-1:0] fft_d1_real;
    reg signed [  `instWidth-1:0] fft_d1_imag;
    reg signed [  `instWidth-1:0] fft_d2_real;
    reg signed [  `instWidth-1:0] fft_d2_imag;
    reg signed [  `instWidth-1:0] fft_d3_real;
    reg signed [  `instWidth-1:0] fft_d3_imag;
    reg signed [  `instWidth-1:0] fft_d4_real;
    reg signed [  `instWidth-1:0] fft_d4_imag;
    reg signed [  `instWidth-1:0] fft_d5_real;
    reg signed [  `instWidth-1:0] fft_d5_imag;
    reg signed [  `instWidth-1:0] fft_d6_real;
    reg signed [  `instWidth-1:0] fft_d6_imag;
    reg signed [  `instWidth-1:0] fft_d7_real;
    reg signed [  `instWidth-1:0] fft_d7_imag;
    //第一轮FFT蝶形运算后的数据
    reg signed [  `instWidth-1:0] fft1_d0_real;
    reg signed [  `instWidth-1:0] fft1_d0_imag;
    reg signed [  `instWidth-1:0] fft1_d1_real;
    reg signed [  `instWidth-1:0] fft1_d1_imag;
    reg signed [  `instWidth-1:0] fft1_d2_real;
    reg signed [  `instWidth-1:0] fft1_d2_imag;
    reg signed [  `instWidth-1:0] fft1_d3_real;
    reg signed [  `instWidth-1:0] fft1_d3_imag;
    reg signed [  `instWidth-1:0] fft1_d4_real;
    reg signed [  `instWidth-1:0] fft1_d4_imag;
    reg signed [  `instWidth-1:0] fft1_d5_real;
    reg signed [  `instWidth-1:0] fft1_d5_imag;
    reg signed [  `instWidth-1:0] fft1_d6_real;
    reg signed [  `instWidth-1:0] fft1_d6_imag;
    reg signed [  `instWidth-1:0] fft1_d7_real;
    reg signed [  `instWidth-1:0] fft1_d7_imag;
    //第二轮FFT蝶形运算后的数据
    reg signed [  `instWidth-1:0] fft2_d0_real;
    reg signed [  `instWidth-1:0] fft2_d0_imag;
    reg signed [  `instWidth-1:0] fft2_d1_real;
    reg signed [  `instWidth-1:0] fft2_d1_imag;
    reg signed [  `instWidth-1:0] fft2_d2_real;
    reg signed [  `instWidth-1:0] fft2_d2_imag;
    reg signed [  `instWidth-1:0] fft2_d3_real;
    reg signed [  `instWidth-1:0] fft2_d3_imag;
    reg signed [  `instWidth-1:0] fft2_d4_real;
    reg signed [  `instWidth-1:0] fft2_d4_imag;
    reg signed [  `instWidth-1:0] fft2_d5_real;
    reg signed [  `instWidth-1:0] fft2_d5_imag;
    reg signed [  `instWidth-1:0] fft2_d6_real;
    reg signed [  `instWidth-1:0] fft2_d6_imag;
    reg signed [  `instWidth-1:0] fft2_d7_real;
    reg signed [  `instWidth-1:0] fft2_d7_imag;
    //第三轮FFT蝶形运算后的数据
    reg signed [  `instWidth-1:0] fft3_d0_real;
    reg signed [  `instWidth-1:0] fft3_d0_imag;
    reg signed [  `instWidth-1:0] fft3_d1_real;
    reg signed [  `instWidth-1:0] fft3_d1_imag;
    reg signed [  `instWidth-1:0] fft3_d2_real;
    reg signed [  `instWidth-1:0] fft3_d2_imag;
    reg signed [  `instWidth-1:0] fft3_d3_real;
    reg signed [  `instWidth-1:0] fft3_d3_imag;
    reg signed [  `instWidth-1:0] fft3_d4_real;
    reg signed [  `instWidth-1:0] fft3_d4_imag;
    reg signed [  `instWidth-1:0] fft3_d5_real;
    reg signed [  `instWidth-1:0] fft3_d5_imag;
    reg signed [  `instWidth-1:0] fft3_d6_real;
    reg signed [  `instWidth-1:0] fft3_d6_imag;
    reg signed [  `instWidth-1:0] fft3_d7_real;
    reg signed [  `instWidth-1:0] fft3_d7_imag;
    //第一轮IFFT蝶形运算后的数据
    reg signed [  `instWidth-1:0] ifft1_d0_real;
    reg signed [  `instWidth-1:0] ifft1_d0_imag;
    reg signed [  `instWidth-1:0] ifft1_d1_real;
    reg signed [  `instWidth-1:0] ifft1_d1_imag;
    reg signed [  `instWidth-1:0] ifft1_d2_real;
    reg signed [  `instWidth-1:0] ifft1_d2_imag;
    reg signed [  `instWidth-1:0] ifft1_d3_real;
    reg signed [  `instWidth-1:0] ifft1_d3_imag;
    reg signed [  `instWidth-1:0] ifft1_d4_real;
    reg signed [  `instWidth-1:0] ifft1_d4_imag;
    reg signed [  `instWidth-1:0] ifft1_d5_real;
    reg signed [  `instWidth-1:0] ifft1_d5_imag;
    reg signed [  `instWidth-1:0] ifft1_d6_real;
    reg signed [  `instWidth-1:0] ifft1_d6_imag;
    reg signed [  `instWidth-1:0] ifft1_d7_real;
    reg signed [  `instWidth-1:0] ifft1_d7_imag;
    //第二轮IFFT蝶形运算后的数据
    reg signed [  `instWidth-1:0] ifft2_d0_real;
    reg signed [  `instWidth-1:0] ifft2_d0_imag;
    reg signed [  `instWidth-1:0] ifft2_d1_real;
    reg signed [  `instWidth-1:0] ifft2_d1_imag;
    reg signed [  `instWidth-1:0] ifft2_d2_real;
    reg signed [  `instWidth-1:0] ifft2_d2_imag;
    reg signed [  `instWidth-1:0] ifft2_d3_real;
    reg signed [  `instWidth-1:0] ifft2_d3_imag;
    reg signed [  `instWidth-1:0] ifft2_d4_real;
    reg signed [  `instWidth-1:0] ifft2_d4_imag;
    reg signed [  `instWidth-1:0] ifft2_d5_real;
    reg signed [  `instWidth-1:0] ifft2_d5_imag;
    reg signed [  `instWidth-1:0] ifft2_d6_real;
    reg signed [  `instWidth-1:0] ifft2_d6_imag;
    reg signed [  `instWidth-1:0] ifft2_d7_real;
    reg signed [  `instWidth-1:0] ifft2_d7_imag;
    //第三轮IFFT蝶形运算后的数据送至第三轮FFT蝶形运算的寄存器
    //FFT/IFFT运算过程中的临时寄存器
    reg signed [`instWidth*2-1:0] fft_temp1;
    reg signed [`instWidth*2-1:0] fft_temp2;
    reg signed [`instWidth*2-1:0] fft_temp3;
    reg signed [`instWidth*2-1:0] fft_temp4;
    reg signed [`instWidth*2-1:0] fft_temp5;
    reg signed [`instWidth*2-1:0] fft_temp6;
    reg signed [`instWidth*2-1:0] fft_temp7;
    reg signed [`instWidth*2-1:0] fft_temp8;
    reg signed [`instWidth*2-1:0] ifft_temp1;
    reg signed [`instWidth*2-1:0] ifft_temp2;
    reg signed [`instWidth*2-1:0] ifft_temp3;
    reg signed [`instWidth*2-1:0] ifft_temp4;
    reg signed [`instWidth*2-1:0] ifft_temp5;
    reg signed [`instWidth*2-1:0] ifft_temp6;
    reg signed [`instWidth*2-1:0] ifft_temp7;
    reg signed [`instWidth*2-1:0] ifft_temp8;

    always @(*) begin
        zero <= 1'b0;
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
            `aluFFTLoadData0: begin
                fft_d0_real <= alusrc1;
                fft_d0_imag <= alusrc2;
            end
            `aluFFTLoadData1: begin
                fft_d1_real <= alusrc1;
                fft_d1_imag <= alusrc2;
            end
            `aluFFTLoadData2: begin
                fft_d2_real <= alusrc1;
                fft_d2_imag <= alusrc2;
            end
            `aluFFTLoadData3: begin
                fft_d3_real <= alusrc1;
                fft_d3_imag <= alusrc2;
            end
            `aluFFTLoadData4: begin
                fft_d4_real <= alusrc1;
                fft_d4_imag <= alusrc2;
            end
            `aluFFTLoadData5: begin
                fft_d5_real <= alusrc1;
                fft_d5_imag <= alusrc2;
            end
            `aluFFTLoadData6: begin
                fft_d6_real <= alusrc1;
                fft_d6_imag <= alusrc2;
            end
            `aluFFTLoadData7: begin
                fft_d7_real <= alusrc1;
                fft_d7_imag <= alusrc2;
            end
            `aluFFTCAL1: begin
                // 一级蝶形电路计算，定点数运算，后6位比特位为小数部分，下同
                fft1_d0_real <= fft_d0_real + fft_d4_real;
                fft1_d0_imag <= fft_d0_imag + fft_d4_imag;
                fft1_d1_real <= fft_d0_real - fft_d4_real;
                fft1_d1_imag <= fft_d0_imag - fft_d4_imag;
                fft1_d2_real <= fft_d2_real + fft_d6_real;
                fft1_d2_imag <= fft_d2_imag + fft_d6_imag;
                fft1_d3_real <= fft_d2_real - fft_d6_real;
                fft1_d3_imag <= fft_d2_imag - fft_d6_imag;
                fft1_d4_real <= fft_d1_real + fft_d5_real;
                fft1_d4_imag <= fft_d1_imag + fft_d5_imag;
                fft1_d5_real <= fft_d1_real - fft_d5_real;
                fft1_d5_imag <= fft_d1_imag - fft_d5_imag;
                fft1_d6_real <= fft_d3_real + fft_d7_real;
                fft1_d6_imag <= fft_d3_imag + fft_d7_imag;
                fft1_d7_real <= fft_d3_real - fft_d7_real;
                fft1_d7_imag <= fft_d3_imag - fft_d7_imag;
            end
            `aluFFTCAL2: begin
                // 二级蝶形电路计算
                fft2_d0_real <= fft1_d0_real + fft1_d2_real;
                fft2_d0_imag <= fft1_d0_imag + fft1_d2_imag;
                fft2_d1_real <= fft1_d1_real + fft1_d3_imag;
                fft2_d1_imag <= fft1_d1_imag - fft1_d3_real;
                fft2_d2_real <= fft1_d0_real - fft1_d2_real;
                fft2_d2_imag <= fft1_d0_imag - fft1_d2_imag;
                fft2_d3_real <= fft1_d1_real - fft1_d3_imag;
                fft2_d3_imag <= fft1_d1_imag + fft1_d3_real;
                fft2_d4_real <= fft1_d4_real + fft1_d6_real;
                fft2_d4_imag <= fft1_d4_imag + fft1_d6_imag;
                fft2_d5_real <= fft1_d5_real + fft1_d7_imag;
                fft2_d5_imag <= fft1_d5_imag - fft1_d7_real;
                fft2_d6_real <= fft1_d4_real - fft1_d6_real;
                fft2_d6_imag <= fft1_d4_imag - fft1_d6_imag;
                fft2_d7_real <= fft1_d5_real - fft1_d7_imag;
                fft2_d7_imag <= fft1_d5_imag + fft1_d7_real;
            end
            `aluFFTCAL3: begin
                // 三级蝶形电路计算
                fft_temp1 = ({{32{fft2_d5_real[31]}},fft2_d5_real} + {{32{fft2_d5_imag[31]}},fft2_d5_imag}) * `wn;
                fft_temp2 = ({{32{fft2_d5_imag[31]}},fft2_d5_imag} - {{32{fft2_d5_real[31]}},fft2_d5_real}) * `wn;
                fft_temp3 = ({{32{fft2_d7_imag[31]}},fft2_d7_imag} - {{32{fft2_d7_real[31]}},fft2_d7_real}) * `wn;
                fft_temp4 = ({{32{fft2_d7_real[31]}},fft2_d7_real} + {{32{fft2_d7_imag[31]}},fft2_d7_imag}) * `wn;
                fft_temp5 = ({{32{fft2_d5_real[31]}},fft2_d5_real} + {{32{fft2_d5_imag[31]}},fft2_d5_imag}) * `wn;
                fft_temp6 = ({{32{fft2_d5_real[31]}},fft2_d5_real} - {{32{fft2_d5_imag[31]}},fft2_d5_imag}) * `wn;
                fft_temp7 = ({{32{fft2_d7_real[31]}},fft2_d7_real} - {{32{fft2_d7_imag[31]}},fft2_d7_imag}) * `wn;
                fft_temp8 = ({{32{fft2_d7_real[31]}},fft2_d7_real} + {{32{fft2_d7_imag[31]}},fft2_d7_imag}) * `wn;
                fft3_d0_real = fft2_d0_real + fft2_d4_real;
                fft3_d0_imag = fft2_d0_imag + fft2_d4_imag;
                fft3_d1_real = fft2_d1_real + {fft_temp1[63], fft_temp1[36:6]};
                fft3_d1_imag = fft2_d1_imag + {fft_temp2[63], fft_temp2[36:6]};
                fft3_d2_real = fft2_d2_real + fft2_d6_real;
                fft3_d2_imag = fft2_d2_imag + fft2_d6_imag;
                fft3_d3_real = fft2_d3_real + {fft_temp3[63], fft_temp3[36:6]};
                fft3_d3_imag = fft2_d3_imag - {fft_temp4[63], fft_temp4[36:6]};
                fft3_d4_real = fft2_d0_real - fft2_d4_real;
                fft3_d4_imag = fft2_d0_imag - fft2_d4_imag;
                fft3_d5_real = fft2_d1_real - {fft_temp5[63], fft_temp5[36:6]};
                fft3_d5_imag = fft2_d1_imag + {fft_temp6[63], fft_temp6[36:6]};
                fft3_d6_real = fft2_d2_real - fft2_d6_real;
                fft3_d6_imag = fft2_d2_imag + fft2_d6_imag;
                fft3_d7_real = fft2_d3_real + {fft_temp7[63], fft_temp7[36:6]};
                fft3_d7_imag = fft2_d3_imag + {fft_temp8[63], fft_temp8[36:6]};
            end
            `aluIFFTCAL1: begin
                // 一级蝶形电路计算
                ifft_temp1 = ({{32{fft_d1_real[31]}},fft_d1_real}-{{32{fft_d5_real[31]}},fft_d5_real}-{{32{fft_d1_imag[31]}},fft_d1_imag}+{{32{fft_d5_imag[31]}},fft_d5_imag})*`wn;
                ifft_temp2 = ({{32{fft_d1_real[31]}},fft_d1_real}-{{32{fft_d5_real[31]}},fft_d5_real}+{{32{fft_d1_imag[31]}},fft_d1_imag}-{{32{fft_d5_imag[31]}},fft_d5_imag})*`wn;
                ifft_temp3 = ({{32{fft_d7_real[31]}},fft_d7_real}-{{32{fft_d3_real[31]}},fft_d3_real}+{{32{fft_d7_imag[31]}},fft_d7_imag}-{{32{fft_d3_imag[31]}},fft_d3_imag})*`wn;
                ifft_temp4 = ({{32{fft_d3_real[31]}},fft_d3_real}-{{32{fft_d7_real[31]}},fft_d7_real}+{{32{fft_d7_imag[31]}},fft_d7_imag}-{{32{fft_d3_imag[31]}},fft_d3_imag})*`wn;
                ifft1_d0_real = fft_d0_real + fft_d4_real;
                ifft1_d0_imag = fft_d0_imag + fft_d4_imag;
                ifft1_d1_real = fft_d1_real + fft_d5_real;
                ifft1_d1_imag = fft_d1_imag + fft_d5_imag;
                ifft1_d2_real = fft_d2_real + fft_d6_real;
                ifft1_d2_imag = fft_d2_imag + fft_d6_imag;
                ifft1_d3_real = fft_d3_real + fft_d7_real;
                ifft1_d3_imag = fft_d3_imag + fft_d7_imag;
                ifft1_d4_real = fft_d0_real - fft_d4_real;
                ifft1_d4_imag = fft_d0_imag - fft_d4_imag;
                ifft1_d5_real = {ifft_temp1[63], ifft_temp1[36:6]};
                ifft1_d5_imag = {ifft_temp2[63], ifft_temp2[36:6]};
                ifft1_d6_real = fft_d6_imag - fft_d2_imag;
                ifft1_d6_imag = fft_d2_real - fft_d6_real;
                ifft1_d7_real = {ifft_temp3[63], ifft_temp3[36:6]};
                ifft1_d7_imag = {ifft_temp4[63], ifft_temp4[36:6]};
            end
            `aluIFFTCAL2: begin
                // 二级蝶形电路计算
                ifft2_d0_real <= ifft1_d0_real + ifft1_d2_real;
                ifft2_d0_imag <= ifft1_d0_imag + ifft1_d2_imag;
                ifft2_d1_real <= ifft1_d1_real + ifft1_d3_real;
                ifft2_d1_imag <= ifft1_d1_imag + ifft1_d3_imag;
                ifft2_d2_real <= ifft1_d0_real - ifft1_d2_real;
                ifft2_d2_imag <= ifft1_d0_imag - ifft1_d2_imag;
                ifft2_d3_real <= ifft1_d3_imag - ifft1_d1_imag;
                ifft2_d3_imag <= ifft1_d1_real - ifft1_d3_real;
                ifft2_d4_real <= ifft1_d4_real + ifft1_d6_real;
                ifft2_d4_imag <= ifft1_d4_imag + ifft1_d6_imag;
                ifft2_d5_real <= ifft1_d5_real + ifft1_d7_real;
                ifft2_d5_imag <= ifft1_d5_imag + ifft1_d7_imag;
                ifft2_d6_real <= ifft1_d4_real - ifft1_d6_real;
                ifft2_d6_imag <= ifft1_d4_imag - ifft1_d6_imag;
                ifft2_d7_real <= ifft1_d7_imag - ifft1_d5_imag;
                ifft2_d7_imag <= ifft1_d5_real - ifft1_d7_real;
            end
            `aluIFFTCAL3: begin
                // 三级蝶形电路计算
                fft3_d0_real <= (ifft2_d0_real + ifft2_d1_real) >>> 3;
                fft3_d0_imag <= (ifft2_d0_imag + ifft2_d1_imag) >>> 3;
                fft3_d1_real <= (ifft2_d4_real + ifft2_d5_real) >>> 3;
                fft3_d1_imag <= (ifft2_d4_imag + ifft2_d5_imag) >>> 3;
                fft3_d2_real <= (ifft2_d2_real + ifft2_d3_real) >>> 3;
                fft3_d2_imag <= (ifft2_d2_imag + ifft2_d3_imag) >>> 3;
                fft3_d3_real <= (ifft2_d6_real + ifft2_d7_real) >>> 3;
                fft3_d3_imag <= (ifft2_d6_imag + ifft2_d7_imag) >>> 3;
                fft3_d4_real <= (ifft2_d0_real - ifft2_d1_real) >>> 3;
                fft3_d4_imag <= (ifft2_d0_imag - ifft2_d1_imag) >>> 3;
                fft3_d5_real <= (ifft2_d4_real - ifft2_d5_real) >>> 3;
                fft3_d5_imag <= (ifft2_d4_imag - ifft2_d5_imag) >>> 3;
                fft3_d6_real <= (ifft2_d2_real - ifft2_d3_real) >>> 3;
                fft3_d6_imag <= (ifft2_d2_imag - ifft2_d3_imag) >>> 3;
                fft3_d7_real <= (ifft2_d6_real - ifft2_d7_real) >>> 3;
                fft3_d7_imag <= (ifft2_d6_imag - ifft2_d7_imag) >>> 3;
            end
            `aluFFTExportData0Real: begin
                alu_result <= fft3_d0_real;
            end
            `aluFFTExportData0Imag: begin
                alu_result <= fft3_d0_imag;
            end
            `aluFFTExportData1Real: begin
                alu_result <= fft3_d1_real;
            end
            `aluFFTExportData1Imag: begin
                alu_result <= fft3_d1_imag;
            end
            `aluFFTExportData2Real: begin
                alu_result <= fft3_d2_real;
            end
            `aluFFTExportData2Imag: begin
                alu_result <= fft3_d2_imag;
            end
            `aluFFTExportData3Real: begin
                alu_result <= fft3_d3_real;
            end
            `aluFFTExportData3Imag: begin
                alu_result <= fft3_d3_imag;
            end
            `aluFFTExportData4Real: begin
                alu_result <= fft3_d4_real;
            end
            `aluFFTExportData4Imag: begin
                alu_result <= fft3_d4_imag;
            end
            `aluFFTExportData5Real: begin
                alu_result <= fft3_d5_real;
            end
            `aluFFTExportData5Imag: begin
                alu_result <= fft3_d5_imag;
            end
            `aluFFTExportData6Real: begin
                alu_result <= fft3_d6_real;
            end
            `aluFFTExportData6Imag: begin
                alu_result <= fft3_d6_imag;
            end
            `aluFFTExportData7Real: begin
                alu_result <= fft3_d7_real;
            end
            `aluFFTExportData7Imag: begin
                alu_result <= fft3_d7_imag;
            end
            default: alu_result <= alusrc1 + alusrc2;
        endcase
    end
endmodule
