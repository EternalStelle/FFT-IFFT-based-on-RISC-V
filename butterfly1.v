`include "define.v"
module butterfly1 (
    input wire clk,
    input wire fft_data_valid,
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
    output reg[`instWidth-1:0] fft_d8_imag_o,
    output reg butterfly1_ready
);
always @(posedge clk) begin
    if(fft_data_valid) begin
    fft_d1_real_o <= (fft_d1_real*256+fft_d5_real*256)/256;
    fft_d1_imag_o <= (fft_d1_imag*256+fft_d5_imag*256)/256;
    fft_d2_real_o <= (fft_d1_real*256-fft_d5_real*256)/256;
    fft_d2_imag_o <= (fft_d1_imag*256-fft_d5_imag*256)/256;
    fft_d3_real_o <= (fft_d3_real*256+fft_d7_real*256)/256;
    fft_d3_imag_o <= (fft_d3_imag*256+fft_d7_imag*256)/256;
    fft_d4_real_o <= (fft_d3_real*256-fft_d7_real*256)/256;
    fft_d4_imag_o <= (fft_d3_imag*256-fft_d7_imag*256)/256;
    fft_d5_real_o <= (fft_d2_real*256+fft_d6_real*256)/256;
    fft_d5_imag_o <= (fft_d2_imag*256+fft_d6_imag*256)/256;
    fft_d6_real_o <= (fft_d2_real*256-fft_d6_real*256)/256;
    fft_d6_imag_o <= (fft_d2_imag*256-fft_d6_imag*256)/256;
    fft_d7_real_o <= (fft_d4_real*256+fft_d8_real*256)/256;
    fft_d7_imag_o <= (fft_d4_imag*256+fft_d8_imag*256)/256;
    fft_d8_real_o <= (fft_d4_real*256-fft_d8_real*256)/256;
    fft_d8_imag_o <= (fft_d4_imag*256-fft_d8_imag*256)/256;
    butterfly1_ready <= `funEnable;
    end else begin
    butterfly1_ready <= `funDisable;
    end
end
endmodule