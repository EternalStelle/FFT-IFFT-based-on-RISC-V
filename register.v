`include "define.v"
//Register
module register (
    input wire [`regAddrWidth-1:0] reg1_raddr,
    input wire [`regAddrWidth-1:0] reg2_raddr,
    input wire reg_wena,
    input wire [`regAddrWidth-1:0] reg_waddr,
    input wire [`instWidth-1:0] reg_wdata,
    output reg [`instWidth-1:0] reg1_rdata_o,
    output reg [`instWidth-1:0] reg2_rdata_o
);
    //Regs initialization
    reg [`instWidth-1:0] regs[0:`regAddrDepth-1];
    integer i;
    initial begin
        for (i = 0; i < `regAddrDepth; i = i + 1) begin
            regs[i] = 0;
            //regs[i] = i;
        end
    end
    //Reg1 read
    always @(*) begin
        if (reg1_raddr == `instWidth'h0) begin
            reg1_rdata_o <= `instWidth'b0;
        end else if ((reg1_raddr == reg_waddr) && (reg_wena == `funEnable)) begin
            reg1_rdata_o <= reg_wdata;
        end else begin
            reg1_rdata_o <= regs[reg1_raddr];
        end
    end
    //Reg2 read
    always @(*) begin
        if (reg2_raddr == `instWidth'h0) begin
            reg2_rdata_o <= `instWidth'b0;
        end else if ((reg2_raddr == reg_waddr) && (reg_wena == `funEnable)) begin
            reg2_rdata_o <= reg_wdata;
        end else begin
            reg2_rdata_o <= regs[reg2_raddr];
        end
    end
    //reg Write
    always @(*) begin
        if (reg_wena && (reg_waddr != `instWidth'h0)) begin
            regs[reg_waddr] <= reg_wdata;
        end
    end
endmodule
