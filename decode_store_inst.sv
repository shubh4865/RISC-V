`ifndef FILE_INCL
 `include "processor_defines.sv"
`endif
module decode_store_inst(
 input logic [31:7] instruction_code,
 output logic [4:0] rs1,
 output logic [4:0] rs2,
 output logic [11:0] imm,
 output logic [2:0] store_control
);
always_comb begin
 rs1=instruction_code[19:15];
 rs2=instruction_code[24:20];
 imm[11:5]=instruction_code[31:25];
 imm[4:0]=instruction_code[11:7];
 case (instruction_code[14:12])
 0 : store_control=`SB;
 1: store_control=`SH ;
 2: store_control=`SW;
 default: store_control=`STR_NOP;
 endcase
end
endmodule