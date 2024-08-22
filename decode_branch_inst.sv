`ifndef FILE_INCL
 `include "processor_defines.sv"
`endif
module decode_branch_inst(
 input logic [31:7] instruction_code,
 output logic [4:0] rs1,
 output logic [4:0] rs2,
 output logic [12:0] imm,
 output logic [2:0] branch_control
);
always_comb begin
 imm[0]=1'b0;
 rs1=instruction_code[19:15];
 rs2=instruction_code[24:20];
 imm[11]=instruction_code[7];
 imm[12]=instruction_code[31];
 imm[10:5]=instruction_code[30:25];
 imm[4:1]=instruction_code[11:8];
 case (instruction_code[14:12])
 0: branch_control=`BEQ;
 1: branch_control=`BNE;
 4:branch_control=`BLT;
 5:branch_control=`BGE;
 6:branch_control=`BLTU;
 7:branch_control=`BGEU;
 default: branch_control=`BR_NOP;
 endcase

end
endmodule