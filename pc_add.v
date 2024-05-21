`include "define.v"
module pc_add (
    input wire[`instWidth-1:0] curr_pc,
    input wire[`instWidth-1:0] imm,
    output reg[`instWidth-1:0] pcWithImm
);
always @(*) begin
    pcWithImm = curr_pc + (imm << 1);
end
endmodule