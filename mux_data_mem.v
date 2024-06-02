`include "define.v"
//MUX_DATA_MEM
module mux_data_mem (
    input wire mem2reg,
    input wire [`instWidth-1:0] mem_data,
    input wire [`instWidth-1:0] alu_result,
    output reg [`instWidth-1:0] mem_data_o
);
    always @(*) begin
        if (mem2reg) begin
            mem_data_o <= mem_data;
        end else begin
            mem_data_o <= alu_result;
        end
    end
endmodule
