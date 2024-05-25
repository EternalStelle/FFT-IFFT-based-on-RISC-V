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
`define aluOP 5
`define aluPlus `aluOP'b00000
`define aluSub `aluOP'b00001
`define aluMul `aluOP'b00010
`define aluXor `aluOP'b00011
`define aluOr `aluOP'b00100
`define aluAnd `aluOP'b00101
`define aluSLL `aluOP'b00110
`define aluSRL `aluOP'b00111
`define aluSRA `aluOP'b01000
`define aluSLT `aluOP'b01001
`define aluSLTU `aluOP'b01010
`define aluBEQ `aluOP'b01011
`define aluBNE `aluOP'b01100
`define aluBLT `aluOP'b01101
`define aluBGE `aluOP'b01110
`define aluLUI `aluOP'b01111
`define aluFFTLoad `aluOP'b10000
`define aluFFTCAL `aluOP'b10001
`define aluFFTExport `aluOP'b10010