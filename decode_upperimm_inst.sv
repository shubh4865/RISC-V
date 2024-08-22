`ifndef FILE_INCL
 `include "processor_defines.sv"
`endif
module decode_upperimm_inst(
 input logic [31:0] instruction_code,
 output logic [4:0] rd,
 output logic [31:0] imm,
 output logic [4:0] alu_control
);
always_comb begin
 rd=instruction_code[11:7];
 imm[31:12]=instruction_code[31:12];
 imm[11:0]=12'b0;
 if (instruction_code[6:0]==7'h37) begin
 alu_control=`LUI;
 end else if (instruction_code[6:0]==7'h17) begin
 alu_control=`AUIPC;
 end
 else begin
 alu_control=`ALU_NOP;
 end
end
endmodule