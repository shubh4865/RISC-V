`ifndef FILE_INCL
 `include "processor_defines.sv"
`endif
module decode_imm_inst(
 input logic [31:7] instruction_code,
 output logic [4:0] rs1,
 output logic [4:0] rd,
 output logic [11:0] imm,
 output logic [4:0] alu_control
);
always_comb begin
 rd=instruction_code[11:7];
 rs1=instruction_code[19:15];
 imm=instruction_code[31:20];

 case(instruction_code[14:12])
 0:alu_control=`LB;
 1:alu_control=`LH;
 2:alu_control=`LW;
 4:alu_control=`LBU;
 5:alu_control=`LHU;
 default:LD_NOP;
 endcase
end
endmodule

`ifndef FILE_INCL
 `include "processor_defines.sv"
`endif
module decode_jump_inst(
 input logic [31:0] instruction_code,
 output logic [4:0] rd,
 output logic [4:0] rs1,
 output logic [20:0] imm,
 output logic [1:0] jump_control
);
always_comb begin
 rd=instruction_code[11:7];
 if (instruction_code[6:0]==7'b1101111) begin
 imm = {instruction_code[31], instruction_code[19:12],instruction_code[20],instruction_code[30:21],1'b0};
 jump_control=`JAL;
 rs1 = 5'd0;
 end
 else if(instruction_code[6:0]==7'b1100111) begin
 if (instruction_code[14:12]==0) begin
 rs1=instruction_code[19:15];
 imm={9'b0,instruction_code[31:20]};
 jump_control=`JALR;
 end else begin
 jump_control=`JMP_NOP;
 rs1=0;
 imm=0;
 end
 end
 else begin
 jump_control=`JMP_NOP;
 rs1=0;
 imm=0;
 end
 //default:jump_control=`JMP_NOP;

end
 initial
 begin
 $dumpfile("./sim_build/decode_jump_inst.vcd");
 $dumpvars(0, decode_jump_inst);
 end
endmodule