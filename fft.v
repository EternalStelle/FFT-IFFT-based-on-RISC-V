`include "define.v"
module fft (
    input wire clk,
    input wire[`aluOP-1:0] aluop,
    input wire[`instWidth-1:0] dataSrc,
    output reg[`instWidth-1:0] fftData,
    output wire butterfly3_ready
);

//FFT
/*
fft_state=0;load 1 real;fft_state=1;load 1 imag;......fft_state=15;load 8 imag
fft_state=16;FFT cal 1 butterfly
fft_state=17;FFT cal 2 butterfly
fft_state=18;FFT cal 3 butterfly
fft_state=19;export 1 real;fft_state=20;export 1 imag;......fft_state=34;export 8 imag
*/
reg [31:0] fft_state = 'd0;
reg signed [`instWidth-1:0] fft_din;
reg signed [`instWidth-1:0] fft_d1_real;
reg signed [`instWidth-1:0] fft_d1_imag;
reg signed [`instWidth-1:0] fft_d2_real;
reg signed [`instWidth-1:0] fft_d2_imag;
reg signed [`instWidth-1:0] fft_d3_real;
reg signed [`instWidth-1:0] fft_d3_imag;
reg signed [`instWidth-1:0] fft_d4_real;
reg signed [`instWidth-1:0] fft_d4_imag;
reg signed [`instWidth-1:0] fft_d5_real;
reg signed [`instWidth-1:0] fft_d5_imag;
reg signed [`instWidth-1:0] fft_d6_real;
reg signed [`instWidth-1:0] fft_d6_imag;
reg signed [`instWidth-1:0] fft_d7_real;
reg signed [`instWidth-1:0] fft_d7_imag;
reg signed [`instWidth-1:0] fft_d8_real;
reg signed [`instWidth-1:0] fft_d8_imag;
//一次蝶形运算后的输出
wire signed [`instWidth-1:0] fft1_d1_real;
wire signed [`instWidth-1:0] fft1_d1_imag;
wire signed [`instWidth-1:0] fft1_d2_real;
wire signed [`instWidth-1:0] fft1_d2_imag;
wire signed [`instWidth-1:0] fft1_d3_real;
wire signed [`instWidth-1:0] fft1_d3_imag;
wire signed [`instWidth-1:0] fft1_d4_real;
wire signed [`instWidth-1:0] fft1_d4_imag;
wire signed [`instWidth-1:0] fft1_d5_real;
wire signed [`instWidth-1:0] fft1_d5_imag;
wire signed [`instWidth-1:0] fft1_d6_real;
wire signed [`instWidth-1:0] fft1_d6_imag;
wire signed [`instWidth-1:0] fft1_d7_real;
wire signed [`instWidth-1:0] fft1_d7_imag;
wire signed [`instWidth-1:0] fft1_d8_real;
wire signed [`instWidth-1:0] fft1_d8_imag;
//二次蝶形运算后的输出
wire signed [`instWidth-1:0] fft2_d1_real;
wire signed [`instWidth-1:0] fft2_d1_imag;
wire signed [`instWidth-1:0] fft2_d2_real;
wire signed [`instWidth-1:0] fft2_d2_imag;
wire signed [`instWidth-1:0] fft2_d3_real;
wire signed [`instWidth-1:0] fft2_d3_imag;
wire signed [`instWidth-1:0] fft2_d4_real;
wire signed [`instWidth-1:0] fft2_d4_imag;
wire signed [`instWidth-1:0] fft2_d5_real;
wire signed [`instWidth-1:0] fft2_d5_imag;
wire signed [`instWidth-1:0] fft2_d6_real;
wire signed [`instWidth-1:0] fft2_d6_imag;
wire signed [`instWidth-1:0] fft2_d7_real;
wire signed [`instWidth-1:0] fft2_d7_imag;
wire signed [`instWidth-1:0] fft2_d8_real;
wire signed [`instWidth-1:0] fft2_d8_imag;
wire butterfly1_ready;
wire butterfly2_ready;
//wire butterfly3_ready;
reg fft_data_valid;
reg signed [`instWidth-1:0] fft_dout;
wire signed [`instWidth-1:0] fft_d1_real_o;
wire signed [`instWidth-1:0] fft_d1_imag_o;
wire signed [`instWidth-1:0] fft_d2_real_o;
wire signed [`instWidth-1:0] fft_d2_imag_o;
wire signed [`instWidth-1:0] fft_d3_real_o;
wire signed [`instWidth-1:0] fft_d3_imag_o;
wire signed [`instWidth-1:0] fft_d4_real_o;
wire signed [`instWidth-1:0] fft_d4_imag_o;
wire signed [`instWidth-1:0] fft_d5_real_o;
wire signed [`instWidth-1:0] fft_d5_imag_o;
wire signed [`instWidth-1:0] fft_d6_real_o;
wire signed [`instWidth-1:0] fft_d6_imag_o;
wire signed [`instWidth-1:0] fft_d7_real_o;
wire signed [`instWidth-1:0] fft_d7_imag_o;
wire signed [`instWidth-1:0] fft_d8_real_o;
wire signed [`instWidth-1:0] fft_d8_imag_o;

butterfly1 u_butterfly1(
.clk(clk), .fft_data_valid(fft_data_valid),
.fft_d1_real(fft_d1_real), .fft_d1_imag(fft_d1_imag),
.fft_d2_real(fft_d2_real), .fft_d2_imag(fft_d2_imag),
.fft_d3_real(fft_d3_real), .fft_d3_imag(fft_d3_imag),
.fft_d4_real(fft_d4_real), .fft_d4_imag(fft_d4_imag),
.fft_d5_real(fft_d5_real), .fft_d5_imag(fft_d5_imag),
.fft_d6_real(fft_d6_real), .fft_d6_imag(fft_d6_imag),
.fft_d7_real(fft_d7_real), .fft_d7_imag(fft_d7_imag),
.fft_d8_real(fft_d8_real), .fft_d8_imag(fft_d8_imag),
.fft_d1_real_o(fft1_d1_real), .fft_d1_imag_o(fft1_d1_imag),
.fft_d2_real_o(fft1_d2_real), .fft_d2_imag_o(fft1_d2_imag),
.fft_d3_real_o(fft1_d3_real), .fft_d3_imag_o(fft1_d3_imag),
.fft_d4_real_o(fft1_d4_real), .fft_d4_imag_o(fft1_d4_imag),
.fft_d5_real_o(fft1_d5_real), .fft_d5_imag_o(fft1_d5_imag),
.fft_d6_real_o(fft1_d6_real), .fft_d6_imag_o(fft1_d6_imag),
.fft_d7_real_o(fft1_d7_real), .fft_d7_imag_o(fft1_d7_imag),
.fft_d8_real_o(fft1_d8_real), .fft_d8_imag_o(fft1_d8_imag),
.butterfly1_ready(butterfly1_ready));

butterfly2 u_butterfly2(
.clk(clk), .butterfly1_ready(butterfly1_ready),
.fft_d1_real(fft1_d1_real), .fft_d1_imag(fft1_d1_imag),
.fft_d2_real(fft1_d2_real), .fft_d2_imag(fft1_d2_imag),
.fft_d3_real(fft1_d3_real), .fft_d3_imag(fft1_d3_imag),
.fft_d4_real(fft1_d4_real), .fft_d4_imag(fft1_d4_imag),
.fft_d5_real(fft1_d5_real), .fft_d5_imag(fft1_d5_imag),
.fft_d6_real(fft1_d6_real), .fft_d6_imag(fft1_d6_imag),
.fft_d7_real(fft1_d7_real), .fft_d7_imag(fft1_d7_imag),
.fft_d8_real(fft1_d8_real), .fft_d8_imag(fft1_d8_imag),
.fft_d1_real_o(fft2_d1_real), .fft_d1_imag_o(fft2_d1_imag),
.fft_d2_real_o(fft2_d2_real), .fft_d2_imag_o(fft2_d2_imag),
.fft_d3_real_o(fft2_d3_real), .fft_d3_imag_o(fft2_d3_imag),
.fft_d4_real_o(fft2_d4_real), .fft_d4_imag_o(fft2_d4_imag),
.fft_d5_real_o(fft2_d5_real), .fft_d5_imag_o(fft2_d5_imag),
.fft_d6_real_o(fft2_d6_real), .fft_d6_imag_o(fft2_d6_imag),
.fft_d7_real_o(fft2_d7_real), .fft_d7_imag_o(fft2_d7_imag),
.fft_d8_real_o(fft2_d8_real), .fft_d8_imag_o(fft2_d8_imag),
.butterfly2_ready(butterfly2_ready));

butterfly3 u_butterfly3(
.clk(clk), .butterfly2_ready(butterfly2_ready),
.fft_d1_real(fft2_d1_real), .fft_d1_imag(fft2_d1_imag),
.fft_d2_real(fft2_d2_real), .fft_d2_imag(fft2_d2_imag),
.fft_d3_real(fft2_d3_real), .fft_d3_imag(fft2_d3_imag),
.fft_d4_real(fft2_d4_real), .fft_d4_imag(fft2_d4_imag),
.fft_d5_real(fft2_d5_real), .fft_d5_imag(fft2_d5_imag),
.fft_d6_real(fft2_d6_real), .fft_d6_imag(fft2_d6_imag),
.fft_d7_real(fft2_d7_real), .fft_d7_imag(fft2_d7_imag),
.fft_d8_real(fft2_d8_real), .fft_d8_imag(fft2_d8_imag),
.fft_d1_real_o(fft_d1_real_o), .fft_d1_imag_o(fft_d1_imag_o),
.fft_d2_real_o(fft_d2_real_o), .fft_d2_imag_o(fft_d2_imag_o),
.fft_d3_real_o(fft_d3_real_o), .fft_d3_imag_o(fft_d3_imag_o),
.fft_d4_real_o(fft_d4_real_o), .fft_d4_imag_o(fft_d4_imag_o),
.fft_d5_real_o(fft_d5_real_o), .fft_d5_imag_o(fft_d5_imag_o),
.fft_d6_real_o(fft_d6_real_o), .fft_d6_imag_o(fft_d6_imag_o),
.fft_d7_real_o(fft_d7_real_o), .fft_d7_imag_o(fft_d7_imag_o),
.fft_d8_real_o(fft_d8_real_o), .fft_d8_imag_o(fft_d8_imag_o),
.butterfly3_ready(butterfly3_ready));

always @(posedge clk) begin
    case (aluop)
 `aluFFTLoad: begin
        case (fft_state)
        'd0:begin
            fft_din = dataSrc;
            fft_d1_real = fft_din;
            fft_state = 'd1;
            fft_data_valid = `funDisable;
        end
        'd1:begin
            fft_din = dataSrc;
            fft_d1_imag = fft_din;
            fft_state = 'd2;
            fft_data_valid = `funDisable;
        end
        'd2:begin
            fft_din = dataSrc;
            fft_d2_real = fft_din;
            fft_state = 'd3;
            fft_data_valid = `funDisable;
        end
        'd3:begin
            fft_din = dataSrc;
            fft_d2_imag = fft_din;
            fft_state = 'd4;
            fft_data_valid = `funDisable;
        end
        'd4:begin
            fft_din = dataSrc;
            fft_d3_real = fft_din;
            fft_state = 'd5;
            fft_data_valid = `funDisable;
        end
        'd5:begin
            fft_din = dataSrc;
            fft_d3_imag = fft_din;
            fft_state = 'd6;
            fft_data_valid = `funDisable;
        end
        'd6:begin
            fft_din = dataSrc;
            fft_d4_real = fft_din;
            fft_state = 'd7;
            fft_data_valid = `funDisable;
        end
        'd7:begin
            fft_din = dataSrc;
            fft_d4_imag = fft_din;
            fft_state = 'd8;
            fft_data_valid = `funDisable;
        end
        'd8:begin
            fft_din = dataSrc;
            fft_d5_real = fft_din;
            fft_state = 'd9;
            fft_data_valid = `funDisable;
        end
        'd9:begin
            fft_din = dataSrc;
            fft_d5_imag = fft_din;
            fft_state = 'd10;
            fft_data_valid = `funDisable;
        end
        'd10:begin
            fft_din = dataSrc;
            fft_d6_real = fft_din;
            fft_state = 'd11;
            fft_data_valid = `funDisable;
        end
        'd11:begin
            fft_din = dataSrc;
            fft_d6_imag = fft_din;
            fft_state = 'd12;
            fft_data_valid = `funDisable;
        end
        'd12:begin
            fft_din = dataSrc;
            fft_d7_real = fft_din;
            fft_state = 'd13;
            fft_data_valid = `funDisable;
        end
        'd13:begin
            fft_din = dataSrc;
            fft_d7_imag = fft_din;
            fft_state = 'd14;
            fft_data_valid = `funDisable;
        end
        'd14:begin
            fft_din = dataSrc;
            fft_d8_real = fft_din;
            fft_state = 'd15;
            fft_data_valid = `funDisable;
        end
        'd15:begin
            fft_din = dataSrc;
            fft_d8_imag = fft_din;
            fft_state = 'd16;
            fft_data_valid = `funDisable;
        end
        'd16:begin
            fft_state = 'd16;
            fft_data_valid = `funDisable;
        end
        endcase
    end
    `aluFFTCAL: begin
        case(fft_state)
        'd16:begin
            fft_state = 'd17;
            fft_data_valid = `funEnable;
        end
        'd17:begin
            fft_state = 'd18;
            fft_data_valid = `funEnable;
        end
        'd18:begin
            fft_state = 'd19;
            fft_data_valid = `funDisable;
        end
        'd19:begin
            fft_state = 'd20;
            fft_data_valid = `funEnable;
        end
        'd20:begin
            fft_state = 'd21;
            fft_data_valid = `funEnable;
        end
        'd21:begin
            fft_state = 'd22;
            fft_data_valid = `funDisable;
        end
        endcase
    end
    `aluFFTExport: begin
        case(fft_state)
        'd22:begin
            fft_dout = fft_d1_real_o;
            fftData = fft_dout;
            fft_state = 'd23;
            fft_data_valid = `funDisable;
        end
        'd23:begin
            fft_dout = fft_d1_imag_o;
            fftData = fft_dout;
            fft_state = 'd24;
            fft_data_valid = `funDisable;
        end
        'd24:begin
            fft_dout = fft_d2_real_o;
            fftData = fft_dout;
            fft_state = 'd25;
            fft_data_valid = `funDisable;
        end
        'd25:begin
            fft_dout = fft_d2_imag_o;
            fftData = fft_dout;
            fft_state = 'd26;
            fft_data_valid = `funDisable;
        end
        'd26:begin
            fft_dout = fft_d3_real_o;
            fftData = fft_dout;
            fft_state = 'd27;
            fft_data_valid = `funDisable;
        end
        'd27:begin
            fft_dout = fft_d3_imag_o;
            fftData = fft_dout;
            fft_state = 'd28;
            fft_data_valid = `funDisable;
        end
        'd28:begin
            fft_dout = fft_d4_real_o;
            fftData = fft_dout;
            fft_state = 'd29;
            fft_data_valid = `funDisable;
        end
        'd29:begin
            fft_dout = fft_d4_imag_o;
            fftData = fft_dout;
            fft_state = 'd30;
            fft_data_valid = `funDisable;
        end
        'd30:begin
            fft_dout = fft_d5_real_o;
            fftData = fft_dout;
            fft_state = 'd31;
            fft_data_valid = `funDisable;
        end
        'd31:begin
            fft_dout = fft_d5_imag_o;
            fftData = fft_dout;
            fft_state = 'd32;
            fft_data_valid = `funDisable;
        end
        'd32:begin
            fft_dout = fft_d6_real_o;
            fftData = fft_dout;
            fft_state = 'd33;
            fft_data_valid = `funDisable;
        end
        'd33:begin
            fft_dout = fft_d6_imag_o;
            fftData = fft_dout;
            fft_state = 'd34;
            fft_data_valid = `funDisable;
        end
        'd34:begin
            fft_dout = fft_d7_real_o;
            fftData = fft_dout;
            fft_state = 'd35;
            fft_data_valid = `funDisable;
        end
        'd35:begin
            fft_dout = fft_d7_imag_o;
            fftData = fft_dout;
            fft_state = 'd36;
            fft_data_valid = `funDisable;
        end
        'd36:begin
            fft_dout = fft_d8_real_o;
            fftData = fft_dout;
            fft_state = 'd37;
            fft_data_valid = `funDisable;
        end
        'd37:begin
            fft_dout = fft_d8_imag_o;
            fftData = fft_dout;
            fft_state = 'd0;
            fft_data_valid = `funDisable;
        end
        endcase
        end
    endcase
end
endmodule