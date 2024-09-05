# Design programme
The design of a RISC-V CPU with FFT/IFFT support is carried out according to the Computer Organization and Design: The Hardware-Software Interfaces (Original Book 5th Edition - RISC-V Edition) (David A. Patterson etc.).
# Support for FFT and IFFT
## A custom instruction set is used to complete the design, which is based on the R-type instructions.
| funct7 | meaning | funct7 | meaning |
| ------ | ------------------------------| -------- | ---- |
| 0x10 | Load first number with real and imaginary parts | 0x1F | Export the real part of third FFT/IFFT result |
| 0x11 | Load second number with real and imaginary parts | 0x21 | Export the imaginary part of third FFT/IFFT result | 
| 0x12 | Load third number with real and imaginary parts | 0x22 | Export the real part of fourth FFT/IFFT result |
| 0x13 | Load fourth number with real and imaginary parts | 0x23 | Export the imaginary part of fourth FFT/IFFT result |
| 0x14 | Load fifth number with real and imaginary parts | 0x24 | Export the real part of fifth FFT/IFFT result | 
| 0x15 | Load sixth number with real and imaginary parts | 0x25 | Export the imaginary part of fifth FFT/IFFT result| 
| 0x16 | Load seventh number with real and imaginary parts | 0x26 | Export the real part of sixth FFT/IFFT result | 
| 0x17 | Load eighth number with real and imaginary parts | 0x27 | Export the imaginary part of sixth FFT/IFFT result | 
| 0x18 | Perform FFT first butterfly operation | 0x28 | Export the real part of seventh FFT/IFFT result |
| 0x19 | Perform FFT second butterfly operation | 0x29 | Export the imaginary part of seventh FFT/IFFT result | 
| 0x1A | Perform FFT third butterfly operation | 0x2A | Export the real part of eighth FFT/IFFT result |
| 0x1B | Export the real part of first FFT/IFFT result | 0x2B | Export the imaginary part of eighth FFT/IFFT result |
| 0x1C | Export the imaginary part of first FFT/IFFT result | 0x2C | Perform IFFT first butterfly operation |
| 0x1D | Export the real part of second FFT/IFFT result | 0x2D | Perform IFFT second butterfly operation |
| 0x1E | Export the imaginary part of second FFT/IFFT result | 0x2E | Perform IFFT third butterfly operation |
## Use fixed point numbers to improve accuracy
In my design, I divided the 32 bits into three parts, the highest bit is the sign bit, which indicates positive and negative; the lowest 6 bits indicate the decimal part; and the remaining bits in the middle indicate the integer part. The meaning of the bit bits is as follows:
| MSB(31) | 30 | ......  | 7 | 6 | 5 | ......  | LSB(0) | 
| ------ | ----| ------ | ---- | ---- | ---- | ---- | ---- |
| symbol bits | $2^{24}$ | - | $2^1$ | $2^0$ | $2^{-1}$ | - | $2^{-6}$ |
# Usage
1. Before the calculation, we can use the instructions already in the RV32I to prepare the data.
2. Use the value of funct7 in the above table to write the instruction for the calculation. For example, the instruction to load the x1 register as the real part of the first number and x2 register as the imaginary part of the first number can be written as follows: 0010000_00010_00001_000_00000_0110011 (binary), which is 20208033 (hexadecimal).
3. After load all 8 numbers with real and imaginary parts, we could manually input 3-times butterfly calculation operations.
4. Then use the value of funct7 to input operations to export all results to registers.
5. In Questa(This is what I use in Quartus), change the format of results according to designed format to show accurate numbers.

** All C files are just used for validating results. All Verilog files needed are already set in riscv.v file.
