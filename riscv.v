`include "define.v"
module riscv (
    input wire clk,
    input wire rst
);
//PC output
wire[`instWidth-1:0] pc_curr_pc;
//MUX_PC output
wire[`instWidth-1:0] mux_pc_next_pc;
wire mux_pc_pipelineFlush;
//Inst memory output
wire[`instWidth-1:0] inst_mem_inst;
//IF_ID output
wire[`instWidth-1:0] ifid_curr_pc;
wire[`instWidth-1:0] ifid_inst;
//Register output
wire[`instWidth-1:0] reg1_data;
wire[`instWidth-1:0] reg2_data;
//CTRL output
wire ctrl_branch;
wire ctrl_reg_wena;
wire ctrl_mem2reg;
wire ctrl_mem_rena;
wire ctrl_mem_wena;
wire[1:0] ctrl_aluop;
wire[1:0] ctrl_alusrc;
wire[1:0] ctrl_jump;
//Immediate Number generator output
wire[`instWidth-1:0] imm;
//ID_EX output
wire[`instWidth-1:0] idex_curr_pc;
wire[`instWidth-1:0] idex_reg1_data;
wire[`instWidth-1:0] idex_reg2_data;
wire[`instWidth-1:0] idex_imm;
wire[4:0] idex_reg_waddr;
wire idex_branch;
wire idex_reg_wena;
wire idex_mem_rena;
wire idex_mem_wena;
wire[1:0] idex_aluop;
wire[1:0] idex_alusrc;
wire[1:0] idex_jump;
wire[2:0] idex_funct3;
wire[6:0] idex_funct7;
wire idex_mem2reg;
wire[4:0] idex_reg1_raddr;
wire[4:0] idex_reg2_raddr;
//ALUSRC
wire[`instWidth-1:0] alusrc;
//ALU CTRL
wire[`aluOP-1:0] alufunc;
//ALU
wire[`instWidth-1:0] alu_result;
wire alu_zero;
//FFT module
wire[`instWidth-1:0] fftData;
wire butterfly3_ready;
//MUX_FFT_ALU
wire[`instWidth-1:0] mux_fft_alu;
//PC ADD
wire[`instWidth-1:0] pcwithimm;
//EX_MEM
wire[`instWidth-1:0] exmem_pcwithimm;
wire exmem_zero;
wire[`instWidth-1:0] exmem_alu_result;
wire exmem_branch;
wire exmem_mem_rena;
wire exmem_mem_wena;
wire exmem_mem2reg;
wire[`instWidth-1:0] exmem_reg2_data;
wire[4:0] exmem_reg_waddr;
wire exmem_reg_wena;
//Data memory
wire[`instWidth-1:0] mem_data;
//MEM_WB
wire[`instWidth-1:0] memwb_mem_data;
wire[`instWidth-1:0] memwb_alu_result;
wire memwb_mem2reg;
wire[4:0] memwb_reg_waddr;
wire memwb_reg_wena;
//MUX_DATA_MEM
wire[`instWidth-1:0] reg_data_wb;
//Forward decision Unit
wire[1:0] forward_a;
wire[1:0] forward_b;
//Forward A
wire[`instWidth-1:0] forward_data_a;
//Forward B
wire[`instWidth-1:0] forward_data_b;
//Hazard detection
wire pc_hazarded;
wire ifid_hazarded;
wire idex_hazarded;

//PC
pc u_pc(
    .clk(clk), .rst(rst),
    .next_pc(mux_pc_next_pc), .curr_pc(pc_curr_pc),
    .pc_hazarded(pc_hazarded)
);
//MUX_PC
mux_pc u_mux_pc(
    .jump(idex_jump), .zero(exmem_zero),
    .branch(exmem_branch), .reg1_data(idex_reg1_data),
    .curr_pc(pc_curr_pc), .imm(idex_imm), .pcWithImm(exmem_pcwithimm),
    .pipelineFlush(mux_pc_pipelineFlush),
    .next_pc(mux_pc_next_pc), .ex_curr_pc(idex_curr_pc)
);
//Inst memory
inst_mem u_inst_mem(
    .pc(pc_curr_pc), .inst(inst_mem_inst)
);
//IF_ID
if_id u_if_id(
    .clk(clk), .rst(rst),
    .curr_pc(pc_curr_pc), .inst(inst_mem_inst),
    .curr_pc_o(ifid_curr_pc), .inst_o(ifid_inst),
    .pipelineFlush(mux_pc_pipelineFlush),
    .ifid_hazarded(ifid_hazarded)
);
//Register
register u_register(
    .reg1_raddr(ifid_inst[19:15]), .reg2_raddr(ifid_inst[24:20]),
    .reg_wena(memwb_reg_wena), .reg_waddr(memwb_reg_waddr),
    .reg_wdata(reg_data_wb), .reg1_rdata_o(reg1_data),
    .reg2_rdata_o(reg2_data)
);
//CTRL
ctrl u_ctrl(
    .inst(ifid_inst[6:0]), .branch(ctrl_branch),
    .reg_wena(ctrl_reg_wena), .mem2reg(ctrl_mem2reg),
    .mem_rena(ctrl_mem_rena), .mem_wena(ctrl_mem_wena),
    .aluop(ctrl_aluop), .alusrc(ctrl_alusrc), 
    .jump(ctrl_jump)
);
//Immediate Number generator
imm_gen u_imm_gen(
    .inst(ifid_inst), .imm(imm)
);
//ID_EX
id_ex u_id_ex(
    .clk(clk), .rst(rst),
    .curr_pc(ifid_curr_pc), .reg1_data(reg1_data),
    .reg2_data(reg2_data), .imm(imm),
    .reg_waddr(ifid_inst[11:7]), .branch(ctrl_branch),
    .reg_wena(ctrl_reg_wena), .mem_rena(ctrl_mem_rena),
    .mem2reg(ctrl_mem2reg), .mem_wena(ctrl_mem_wena),
    .aluop(ctrl_aluop), .alusrc(ctrl_alusrc),
    .jump(ctrl_jump), .funct3(ifid_inst[14:12]),
    .funct7(ifid_inst[31:25]), .curr_pc_o(idex_curr_pc),
    .reg1_data_o(idex_reg1_data), .reg2_data_o(idex_reg2_data),
    .imm_o(idex_imm), .reg_waddr_o(idex_reg_waddr),
    .branch_o(idex_branch), .reg_wena_o(idex_reg_wena),
    .mem_rena_o(idex_mem_rena), .mem_wena_o(idex_mem_wena),
    .aluop_o(idex_aluop), .alusrc_o(idex_alusrc),
    .jump_o(idex_jump), .funct3_o(idex_funct3),
    .funct7_o(idex_funct7), .mem2reg_o(idex_mem2reg),
    .pipelineFlush(mux_pc_pipelineFlush),
    .reg1_raddr(ifid_inst[19:15]), .reg2_raddr(ifid_inst[24:20]),
    .reg1_raddr_o(idex_reg1_raddr), .reg2_raddr_o(idex_reg2_raddr),
    .idex_hazarded(idex_hazarded)
);
//Forward A
forward_a u_forward_a(
    .forward_decision(forward_a), .idex_reg1_data(idex_reg1_data),
    .exmem_result(exmem_alu_result), .memwb_result(reg_data_wb),
    .forward_data(forward_data_a)
);
//Forward B
forward_b u_forward_b(
    .forward_decision(forward_b), .idex_reg2_data(idex_reg2_data),
    .exmem_result(exmem_alu_result), .memwb_result(reg_data_wb),
    .forward_data(forward_data_b)
);
//ALU_SRC
alusrc u_alusrc(
    .alusel(idex_alusrc), .reg2_data(forward_data_b),
    .imm(idex_imm), .alu_src(alusrc)
);
//ALU CTRL
alu_ctrl u_alu_ctrl(
    .aluop(idex_aluop), .funct3(idex_funct3), 
    .funct7(idex_funct7), .alufunc(alufunc)
);
//ALU
alu u_alu(
    .curr_pc(idex_curr_pc),
    .alusrc1(forward_data_a), .alusrc2(alusrc),
    .aluop(alufunc), .alu_result(alu_result),
    .zero(alu_zero)
);
/*
//FFT module
fft u_fft(
    .clk(clk), .dataSrc(forward_data_a),
    .aluop(alufunc), .fftData(fftData),
    .butterfly3_ready(butterfly3_ready)
);
//MUX_FFT_ALU
mux_fft_alu u_mux_fft_alu(
    .butterfly3_ready(butterfly3_ready), .alu_result(alu_result),
    .fftData(fftData), .mux_fft_alu(mux_fft_alu)
);
*/
//PC ADD
pc_add u_pc_add(
    .curr_pc(idex_curr_pc), .imm(idex_imm),
    .pcWithImm(pcwithimm)
);
//EX_MEM
ex_mem u_ex_mem(
    .clk(clk), .rst(rst),
    .pcWithImm(pcwithimm), .zero(alu_zero),
    .alu_result(alu_result), .branch(idex_branch),
    .mem_rena(idex_mem_rena), .mem_wena(idex_mem_wena),
    .mem2reg(idex_mem2reg), .pcWithImm_o(exmem_pcwithimm),
    .zero_o(exmem_zero), .alu_result_o(exmem_alu_result),
    .branch_o(exmem_branch), .mem_rena_o(exmem_mem_rena),
    .mem_wena_o(exmem_mem_wena), .mem2reg_o(exmem_mem2reg),
    .reg2_data(idex_reg2_data), .reg2_data_o(exmem_reg2_data),
    .reg_waddr(idex_reg_waddr), .reg_waddr_o(exmem_reg_waddr),
    .reg_wena(idex_reg_wena), .reg_wena_o(exmem_reg_wena)
);
//Data memory
data_mem u_data_mem(
    .mem_rena(exmem_mem_rena), .mem_wena(exmem_mem_wena),
    .mem_wdata(exmem_reg2_data), .mem_addr(exmem_alu_result[4:0]),
    .mem_data_o(mem_data)
);
//MEM_WB
mem_wb u_mem_wb(
    .clk(clk), .rst(rst),
    .mem_data(mem_data), .alu_result(exmem_alu_result),
    .mem2reg(exmem_mem2reg), .mem_data_o(memwb_mem_data),
    .alu_result_o(memwb_alu_result), .mem2reg_o(memwb_mem2reg),
    .reg_waddr(exmem_reg_waddr), .reg_waddr_o(memwb_reg_waddr),
    .reg_wena(exmem_reg_wena), .reg_wena_o(memwb_reg_wena)
);
//MUX_DATA_MEM
mux_data_mem u_mem_data_mem(
    .mem2reg(memwb_mem2reg), .mem_data(memwb_mem_data),
    .alu_result(memwb_alu_result), .mem_data_o(reg_data_wb)
);
//Forward decision unit
forward_unit u_forward_unit(
    .idex_reg1_raddr(idex_reg1_raddr), .idex_reg2_raddr(idex_reg2_raddr),
    .exmem_reg_waddr(exmem_reg_waddr), .memwb_reg_waddr(memwb_reg_waddr),
    .exmem_reg_wena(exmem_reg_wena), .memwb_reg_wena(memwb_reg_wena),
    .forward_a(forward_a), .forward_b(forward_b)
);
//Hazard detection
hazard_detection u_hazard_detection(
    .ifid_reg1_raddr(ifid_inst[19:15]), .ifid_reg2_raddr(ifid_inst[24:20]),
    .idex_reg_waddr(idex_reg_waddr), .idex_mem_rena(idex_mem_rena),
    .pc_continue(pc_hazarded), .ifid_continue(ifid_hazarded),
    .idex_continue(idex_hazarded)
);
endmodule