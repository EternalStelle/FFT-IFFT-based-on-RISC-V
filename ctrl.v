`include "define.v"
//CTRL module
module ctrl (
    input wire[6:0] inst,  //指令输入
    output reg branch,     //分支跳跃标志
    output reg reg_wena,   //寄存器使能写
    output reg mem2reg,    //读取数据存储器至寄存器
    output reg mem_rena,   //数据存储器使能读
    output reg mem_wena,   //数据存储器使能写
    output reg[1:0] aluop,
    output reg alusrc,
    output reg[1:0] jump
);
    always @(*) begin
        case (inst)
            `opcodeR: begin
                branch   <= `funDisable;
                reg_wena <= `funEnable;
                mem2reg  <= `funDisable;
                mem_rena <= `funDisable;
                mem_wena <= `funDisable;
                aluop    <= `aluR;
                alusrc   <= `aluSrcReg;
                jump     <= `jumpDisable;
            end
            `opcodeI: begin
                branch   <= `funDisable;
                reg_wena <= `funEnable;
                mem2reg  <= `funDisable;
                mem_rena <= `funDisable;
                mem_wena <= `funDisable;
                aluop    <= `aluR;
                alusrc   <= `aluSrcImm;
                jump     <= `jumpDisable;
            end
            `opcodeIL: begin
                branch   <= `funDisable;
                reg_wena <= `funEnable;
                mem2reg  <= `funEnable;
                mem_rena <= `funEnable;
                mem_wena <= `funDisable;
                aluop    <= `aluLoad;
                alusrc   <= `aluSrcImm;
                jump     <= `jumpDisable;
            end
            `opcodeS: begin
                branch   <= `funDisable;
                reg_wena <= `funDisable;
                mem2reg  <= `funDisable;
                mem_rena <= `funDisable;
                mem_wena <= `funEnable;
                aluop    <= `aluStore;
                alusrc   <= `aluSrcImm;
                jump     <= `jumpDisable;
            end
            `opcodeB: begin
                branch   <= `funEnable;
                reg_wena <= `funDisable;
                mem2reg  <= `funDisable;
                mem_rena <= `funDisable;
                mem_wena <= `funDisable;
                aluop    <= `aluR;
                alusrc   <= `aluSrcReg;
                jump     <= `jumpDisable;
            end
            7'b1101111: begin  //JAL
                branch   <= `funDisable;
                reg_wena <= `funEnable;
                mem2reg  <= `funDisable;
                mem_rena <= `funDisable;
                mem_wena <= `funDisable;
                aluop    <= `aluR;
                alusrc   <= `aluSrcImm;
                jump     <= `jumpJAL;
            end
            7'b1100111: begin  //JALR
                branch   <= `funDisable;
                reg_wena <= `funEnable;
                mem2reg  <= `funDisable;
                mem_rena <= `funDisable;
                mem_wena <= `funDisable;
                aluop    <= `aluR;
                alusrc   <= `aluSrcImm;
                jump     <= `jumpJALR;
            end
            7'b0110111: begin  //LUI
                branch   <= `funDisable;
                reg_wena <= `funEnable;
                mem2reg  <= `funDisable;
                mem_rena <= `funDisable;
                mem_wena <= `funDisable;
                aluop    <= `aluLoad;
                alusrc   <= `aluSrcImm;
                jump     <= `jumpDisable;
            end
            7'b0010111: begin  //AUIPC
                branch   <= `funDisable;
                reg_wena <= `funEnable;
                mem2reg  <= `funDisable;
                mem_rena <= `funDisable;
                mem_wena <= `funDisable;
                aluop    <= `aluSrcAUIPC;
                alusrc   <= `aluSrcImm;
                jump     <= `jumpDisable;
            end
        endcase
    end
endmodule
