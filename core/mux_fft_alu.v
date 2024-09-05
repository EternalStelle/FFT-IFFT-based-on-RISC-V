`include "define.v"
module mux_fft_alu (
    input wire butterfly3_ready,
    input wire[`instWidth-1:0] alu_result,
    input wire[`instWidth-1:0] fftData,
    output wire[`instWidth-1:0] mux_fft_alu
);
assign mux_fft_alu = (butterfly3_ready) ? fftData: alu_result;
endmodule