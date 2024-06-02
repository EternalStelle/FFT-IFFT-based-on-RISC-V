`include "define.v"
module imm_gen (
    input  wire [`instWidth-1:0] inst,
    output reg  [`instWidth-1:0] imm
);
    always @(*) begin
        case (inst[6:0])
            `opcodeI:   imm <= {{20{inst[31]}}, inst[31:20]};
            `opcodeS:   imm <= {{20{inst[31]}}, inst[31:25], inst[11:7]};
            `opcodeB:   imm <= {{20{inst[31]}}, inst[31], inst[7], inst[30:25], inst[11:8]};
            7'b0110111: imm <= {inst[31:12], 12'b0};  //此处已将其左移12位
            7'b0010111: imm <= {inst[31:12], 12'b0};  //此处已将其左移12位
            7'b1101111: imm <= {{12{inst[31]}}, inst[19:12], inst[20], inst[30:21], 1'b0};
        endcase
    end
endmodule
