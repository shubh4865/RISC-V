`ifndef FILE_INCL
 `include "processor_defines.sv"
`endif
module decode_load_inst(
 input logic [31:7] instruction_code,
 output logic [4:0] rs1,
 output logic [4:0] rd,
 output logic [11:0] imm,
 output logic [2:0] load_control
);
always_comb begin
 rd=instruction_code[11:7];
 rs1=instruction_code[19:15];
 imm=instruction_code[21:20];

 case(instruction_code[14:12])
 0:load_control=`LB;
 1:load_control=`LH;
 2:load_control=`LW;
 4:load_control=`LBU;
 5:load_control=`LHU;
 `default: load_control=LD_NOP;
 endcase

end
endmodule