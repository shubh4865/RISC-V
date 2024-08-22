`ifndef FILE_INCL
 `include "processor_defines.sv"
`endif
module decode_reg_inst(
 input logic [31:7] instruction_code,
 output logic [4:0] rs1,
 output logic [4:0] rs2,
 output logic [4:0] rd,
 output logic [4:0] alu_control
);
logic [2:0] func3;
logic [6:0] func7;
always_comb begin
 rd= instruction_code[11:7];
 rs1=instruction_code[19:15];
 rs2=instruction_code[24:20];
 func3=instruction_code[14:12];
 func7=instruction_code[31:25];
 case (func3)
 0:begin
 if(func7==0)alu_control=`ADD;
 else if(func7==32) begin
 alu_control=`SUB;
 end
 else alu_control=`ALU_NOP;
 end
 1:begin
 if(func7==0) alu_control=`SLL;
 else alu_control=`ALU_NOP;
 end
 2:begin
 if(func7==0) alu_control=`SLT;
 else alu_control=`ALU_NOP;
 end
 3: begin
 if(func7==0) alu_control=`SLTU;
 else alu_control=`ALU_NOP;
 end
 4:begin
 if(func7==0) alu_control=`XOR;
 else alu_control=`ALU_NOP;
 end
 5:begin
 if (func7==0) alu_control=`SRL;
 else if(func7==32) begin
 alu_control=`SRA;
 end
 else alu_control=`ALU_NOP;
 end
 6:begin
 if(func7==0) alu_control=`OR;
 else alu_control=`ALU_NOP;
 end
 7:begin
 if(func7==0) alu_control=`AND;
 else alu_control=`ALU_NOP;
 end
 default:alu_control=`ALU_NOP;
 endcase

end

`ifndef SUBMODULE_DISABLE_WAVES
 initial
 begin
 $dumpfile("./sim_build/decode_reg_inst.vcd");
 $dumpvars(0, decode_reg_inst);
 end
 `endif
endmodule