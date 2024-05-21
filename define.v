//Macro Definition
`define funEnable 1'b1
`define funDisable 1'b0
`define instWidth 32
`define zeroWord 32'h00000000
`define jumpDisable 2'b00
`define jumpJAL 2'b01
`define jumpJALR 2'b10
//Inst mem Definition
`define instMemAddrDepth 1024
`define instMenAddrWidth 10
//Register Definition
`define regAddrDepth 32
`define regAddrWidth 5
//Immediate Number Generator Definition
`define immGenType 3
`define immGenTypeI `immGenType'b000
`define immGenTypeS `immGenType'b001
`define immGenTypeB `immGenType'b010
`define immGenTypeU `immGenType'b011
`define immGenTypeJ `immGenType'b100
//OPCODE
`define opcodeR 7'b0110011
`define opcodeI 7'b0010011
`define opcodeIL 7'b0000011
`define opcodeS 7'b0100011
`define opcodeB 7'b1100011
`define opcodeU 7'b0110111
//ALU CTRL definition
`define aluR 2'b00
`define aluLoad 2'b01
`define aluStore 2'b01
`define aluBranch 2'b10
//ALU definition
`define aluOP 4
`define aluPlus `aluOP'b0000
`define aluSub `aluOP'b0001
`define aluMul `aluOP'b0010
`define aluXor `aluOP'b0011
`define aluOr `aluOP'b0100
`define aluAnd `aluOP'b0101
`define aluSLL `aluOP'b0110
`define aluSRL `aluOP'b0111
`define aluSRA `aluOP'b1000
`define aluSLT `aluOP'b1001
`define aluSLTU `aluOP'b1010
`define aluBEQ `aluOP'b1011
`define aluBNE `aluOP'b1100
`define aluBLT `aluOP'b1101
`define aluBGE `aluOP'b1110