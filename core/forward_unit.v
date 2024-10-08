`include "define.v"
//数据前递判断模块
module forward_unit (
    input wire [`regAddrWidth-1:0] idex_reg1_raddr,
    input wire [`regAddrWidth-1:0] idex_reg2_raddr,
    input wire exmem_reg_wena,
    input wire [`regAddrWidth-1:0] exmem_reg_waddr,
    input wire memwb_reg_wena,
    input wire [`regAddrWidth-1:0] memwb_reg_waddr,
    output reg [1:0] forward_a,
    output reg [1:0] forward_b
);
    always @(*) begin
        if (exmem_reg_wena && (exmem_reg_waddr != 0) && (exmem_reg_waddr == idex_reg1_raddr)) begin
            forward_a <= 2'b10;//前递EX_MEM流水线寄存器的内容
        end
    else if (memwb_reg_wena && (memwb_reg_waddr != 0) && !(exmem_reg_wena && (exmem_reg_waddr != 0) && (exmem_reg_waddr == idex_reg1_raddr)) && (memwb_reg_waddr == idex_reg1_raddr)) begin
            forward_a <= 2'b01;//前递MEM_WB流水线寄存器的内容
        end else begin
            forward_a <= 2'b00;//不前递
        end
    end
    always @(*) begin
        if (exmem_reg_wena && (exmem_reg_waddr != 0) && (exmem_reg_waddr == idex_reg2_raddr)) begin
            forward_b <= 2'b10;//前递EX_MEM流水线寄存器的内容
        end
    else if (memwb_reg_wena && (memwb_reg_waddr != 0) && !(exmem_reg_wena && (exmem_reg_waddr != 0) && (exmem_reg_waddr == idex_reg2_raddr)) && (memwb_reg_waddr == idex_reg2_raddr)) begin
            forward_b <= 2'b01;//前递MEM_WB流水线寄存器的内容
        end else begin
            forward_b <= 2'b00;//不前递
        end
    end
endmodule
