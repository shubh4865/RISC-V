# RISC-V
Pronounced as risk five
Started as a research project in 2010 at UC Berkeley
Commercial ISAs were too complex and presented IP legal issues
RISC-V is available freely under a permissive license
RISC-V is not a company, it is not a CPU Implementation
RISC-V uses a standard naming convention to describe the ISAs supported in a given implementation
ISA Name format: RV[###][abc…..xyz]
RV – Indicates a RISC-V architecture
[###] - {32, 64, 128} indicate the width of the integer register file and the size of the user address space
[abc…xyz] – Used to indicate the set of extensions supported by an implementation.
Structure of the ISA
Small amount of fixed-size registers
For RV32I, 32 32-bit registers (32 64-bit registers for RV64)
A question: Why isn’t this number larger? Why not 1024 registers?
Another question: Why not zero?
Three types of instructions:
Computational operation: from register file to register file
xd = Op(xa , xb ), where Op ∈ {+, -, AND, OR, >, <, …}
Op implemented in ALU
Load/Store: between memory and register file
Control flow: jump to different part of code
Base Integer ISA Encoding
Base Integer ISA Encoding
32-bit fixed-width, naturally aligned instructions
rd/rs1/rs2 in fixed location, no implicit registers
Immediate field (imm[31]) always sign-extended
Instruction Encoding Types
R-type – Register
I-type – Immediate
S-type – Stores
U-Type – Loads with immediate
Base Integer ISA
With only 47 instructions, the RV32I base integer ISA implements the absolutely necessary operations to achieve basic functionality with 32-bit integers (its 64-bit variant is RV64I). This ISA, encoded in 32-bits, includes instructions for:
Addition
Subtraction
Bitwise operations
Load and store
Jumps
Branches
The base ISA also specifies the 32 CPU registers, which are all 32-bits wide, plus the program counter. The only special register is x0, which always reads 0.
