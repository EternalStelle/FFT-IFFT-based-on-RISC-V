`include "define.v"
//instruction memory
module inst_mem (input wire[`instWidth-1:0] pc,
                 output reg[`instWidth-1:0] inst);
//regs definition
reg[`instWidth-1:0] regs[0:`instMemAddrDepth-1];
always @(*) begin
    inst <= regs[pc[`instMenAddrWidth+2-1:2]];
end
endmodule