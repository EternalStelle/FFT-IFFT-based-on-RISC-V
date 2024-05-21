`include "define.v"
//Data forward execution unit A
module forward_a (
    input wire[1:0] forward_decision,
    input wire[`instWidth-1:0] idex_reg1_data,
    input wire[`instWidth-1:0] exmem_result,
    input wire[`instWidth-1:0] memwb_result,
    output reg[`instWidth-1:0] forward_data
);
always @(*) begin
    case (forward_decision)
    2'b00: forward_data = idex_reg1_data;
    2'b10: forward_data = exmem_result;
    2'b01: forward_data = memwb_result;
    endcase
end
endmodule