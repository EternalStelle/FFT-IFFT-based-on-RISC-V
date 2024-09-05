//~ `New testbench
`timescale  1ps / 1ps

module riscv_tb_fft;

// riscv Parameters
parameter PERIOD  = 10;
parameter instWidth = 32;
// riscv Inputs
reg clk = 0 ;
reg rst = 1 ;

// riscv Outputs

// Register
wire [instWidth-1:0] pc0      = riscv.u_pc.curr_pc;
wire [instWidth-1:0] zero_x0  = riscv. u_register. regs[0];
wire [instWidth-1:0] ra_x1    = riscv. u_register. regs[1];
wire [instWidth-1:0] sp_x2    = riscv. u_register. regs[2];
wire [instWidth-1:0] gp_x3    = riscv. u_register. regs[3];
wire [instWidth-1:0] tp_x4    = riscv. u_register. regs[4];
wire [instWidth-1:0] t0_x5    = riscv. u_register. regs[5];
wire [instWidth-1:0] t1_x6    = riscv. u_register. regs[6];
wire [instWidth-1:0] t2_x7    = riscv. u_register. regs[7];
wire [instWidth-1:0] s0_fp_x8 = riscv. u_register. regs[8];
wire [instWidth-1:0] s1_x9    = riscv. u_register. regs[9];
wire [instWidth-1:0] a0_x10   = riscv. u_register. regs[10];
wire [instWidth-1:0] a1_x11   = riscv. u_register. regs[11];
wire [instWidth-1:0] a2_x12   = riscv. u_register. regs[12];
wire [instWidth-1:0] a3_x13   = riscv. u_register. regs[13];
wire [instWidth-1:0] a4_x14   = riscv. u_register. regs[14];
wire [instWidth-1:0] a5_x15   = riscv. u_register. regs[15];
wire [instWidth-1:0] a6_x16   = riscv. u_register. regs[16];
wire [instWidth-1:0] a7_x17   = riscv. u_register. regs[17];
wire [instWidth-1:0] s2_x18   = riscv. u_register. regs[18];
wire [instWidth-1:0] s3_x19   = riscv. u_register. regs[19];
wire [instWidth-1:0] s4_x20   = riscv. u_register. regs[20];
wire [instWidth-1:0] s5_x21   = riscv. u_register. regs[21];
wire [instWidth-1:0] s6_x22   = riscv. u_register. regs[22];
wire [instWidth-1:0] s7_x23   = riscv. u_register. regs[23];
wire [instWidth-1:0] s8_x24   = riscv. u_register. regs[24];
wire [instWidth-1:0] s9_x25   = riscv. u_register. regs[25];
wire [instWidth-1:0] s10_x26  = riscv. u_register. regs[26];
wire [instWidth-1:0] s11_x27  = riscv. u_register. regs[27];
wire [instWidth-1:0] t3_x28   = riscv. u_register. regs[28];
wire [instWidth-1:0] t4_x29   = riscv. u_register. regs[29];
wire [instWidth-1:0] t5_x30   = riscv. u_register. regs[30];
wire [instWidth-1:0] t6_x31   = riscv. u_register. regs[31]; 

initial
begin
    forever #(PERIOD/2)  clk=~clk;
end

initial
begin
    #(PERIOD*2) rst  =  0;
end

riscv  riscv (
    .clk(clk),
    .rst(rst)
);

initial
begin
    $readmemh("fft", riscv.u_inst_mem.regs);
end
endmodule