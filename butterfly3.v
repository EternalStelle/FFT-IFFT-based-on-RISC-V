`include "define.v"
module butterfly3 (
    input wire clk,
    input wire butterfly2_ready,
    input signed[`instWidth-1:0] fft_d1_real,
    input signed[`instWidth-1:0] fft_d1_imag,
    input signed[`instWidth-1:0] fft_d2_real,
    input signed[`instWidth-1:0] fft_d2_imag,
    input signed[`instWidth-1:0] fft_d3_real,
    input signed[`instWidth-1:0] fft_d3_imag,
    input signed[`instWidth-1:0] fft_d4_real,
    input signed[`instWidth-1:0] fft_d4_imag,
    input signed[`instWidth-1:0] fft_d5_real,
    input signed[`instWidth-1:0] fft_d5_imag,
    input signed[`instWidth-1:0] fft_d6_real,
    input signed[`instWidth-1:0] fft_d6_imag,
    input signed[`instWidth-1:0] fft_d7_real,
    input signed[`instWidth-1:0] fft_d7_imag,
    input signed[`instWidth-1:0] fft_d8_real,
    input signed[`instWidth-1:0] fft_d8_imag,
    output reg[`instWidth-1:0] fft_d1_real_o,
    output reg[`instWidth-1:0] fft_d1_imag_o,
    output reg[`instWidth-1:0] fft_d2_real_o,
    output reg[`instWidth-1:0] fft_d2_imag_o,
    output reg[`instWidth-1:0] fft_d3_real_o,
    output reg[`instWidth-1:0] fft_d3_imag_o,
    output reg[`instWidth-1:0] fft_d4_real_o,
    output reg[`instWidth-1:0] fft_d4_imag_o,
    output reg[`instWidth-1:0] fft_d5_real_o,
    output reg[`instWidth-1:0] fft_d5_imag_o,
    output reg[`instWidth-1:0] fft_d6_real_o,
    output reg[`instWidth-1:0] fft_d6_imag_o,
    output reg[`instWidth-1:0] fft_d7_real_o,
    output reg[`instWidth-1:0] fft_d7_imag_o,
    output reg[`instWidth-1:0] fft_d8_real_o,
    output reg[`instWidth-1:0] fft_d8_imag_o
);
always @(posedge clk) begin
    if(butterfly2_ready) begin
    fft_d1_real_o <= (fft_d1_real*256+fft_d5_real*256)/256;
    fft_d1_imag_o <= (fft_d1_imag*256+fft_d5_imag*256)/256;
    fft_d2_real_o <= (fft_d2_real*256+fft_d6_real*181+fft_d6_imag*181)/256;
    fft_d2_imag_o <= (fft_d2_imag*256+fft_d6_imag*181-fft_d6_real*181)/256;
    fft_d3_real_o <= (fft_d3_real*256-fft_d7_real*256)/256;
    fft_d3_imag_o <= (fft_d3_imag*256-fft_d7_imag*256)/256;
    fft_d4_real_o <= (fft_d4_real*256-fft_d8_real*181+fft_d8_imag*181)/256;
    fft_d4_imag_o <= (fft_d4_imag*256-fft_d8_imag*181-fft_d8_real*181)/256;
    fft_d5_real_o <= (fft_d1_real*256-fft_d5_real*256)/256;
    fft_d5_imag_o <= (fft_d1_imag*256-fft_d5_imag*256)/256;
    fft_d6_real_o <= (fft_d2_real*256-fft_d6_real*181-fft_d6_imag*181)/256;
    fft_d6_imag_o <= (fft_d2_imag*256-fft_d6_imag*181+fft_d6_real*181)/256;
    fft_d7_real_o <= (fft_d3_real*256-fft_d7_imag*256)/256;
    fft_d7_imag_o <= (fft_d3_imag*256+fft_d7_real*256)/256;
    fft_d8_real_o <= (fft_d4_real*256+fft_d8_real*181-fft_d8_imag*181)/256;
    fft_d8_imag_o <= (fft_d4_imag*256+fft_d8_imag*181+fft_d8_real*181)/256;
    end
end
endmodule