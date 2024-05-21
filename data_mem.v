`include "define.v"
//Data memory
module data_mem (input wire mem_wena,
                 input wire[`instWidth-1:0] mem_wdata,
                 input wire[`regAddrWidth-1:0] mem_addr,
                 input wire mem_rena,
                 output reg[`instWidth-1:0] mem_data_o);
    //Regs initialization
    reg[`instWidth-1:0] regs [0:`regAddrDepth-1];
    integer i;
    initial begin
        for (i = 0; i<`regAddrDepth; i = i+1) begin
            regs[i]   = 0;
            //regs[i] = i;
        end
    end
    //read mem
    always @(*) begin
        if (!mem_rena) begin
            mem_data_o <= `zeroWord;
            end else begin
            mem_data_o <= regs[mem_addr];
        end
    end
    //write mem
    always @(*) begin
        if (mem_wena) begin
            regs[mem_addr] <= mem_wdata;
        end
    end
endmodule
