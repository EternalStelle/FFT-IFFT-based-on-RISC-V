`include "define.v"
//控制冒险检测
module hazard_detection (
    input wire [`regAddrWidth-1:0] ifid_reg1_raddr,
    input wire [`regAddrWidth-1:0] ifid_reg2_raddr,
    input wire [`regAddrWidth-1:0] idex_reg_waddr,
    input wire idex_mem_rena,
    output reg pc_continue, //PC模块的控制冒险信号
    output reg ifid_continue,//IF_ID流水线的控制冒险信号
    output reg idex_continue//ID_EX流水线的控制冒险信号
);
    always @(*) begin
        if (idex_mem_rena && ((idex_reg_waddr == ifid_reg1_raddr) || (idex_reg_waddr == ifid_reg2_raddr))) begin
            pc_continue   <= `funEnable;
            ifid_continue <= `funEnable;
            idex_continue <= `funEnable;
        end else begin
            pc_continue   <= `funDisable;
            ifid_continue <= `funDisable;
            idex_continue <= `funDisable;
        end
    end
endmodule
