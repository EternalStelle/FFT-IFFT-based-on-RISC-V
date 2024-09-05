`include "define.v"
//指令寄存器
module inst_mem (
    input  wire [`instWidth-1:0] pc,
    output reg  [`instWidth-1:0] inst
);
    //寄存器定义
    reg [`instWidth-1:0] regs[0:`instMemAddrDepth-1];
    always @(*) begin
        //忽略最低2bit，即PC+4
        inst <= regs[pc[`instMenAddrWidth+2-1:2]];
    end
endmodule
