`ifndef FILE_INCL
 `include "processor_defines.sv"
`endif
module alu(
 input logic [31:0] pc,
 input logic [31:0] imm,
 input logic [31:0] rs1_val,
 input logic [31:0] rs2_val,
 input logic [4:0] alu_control,
 output logic rd_write_control,
 output logic [31:0] rd_write_val
);
/*always_comb begin
 alu_rd_write_control=1;
 case(alu_control)
 0: rd_write_val=`ALU_NOP;
 1:rd_write_val=`ADD;
 2:rd_write_val=`SUB;
 3:rd_write_val=`XOR;
 4:rd_write_val=`OR;
 5:rd_write_val=`ADD;
 6:rd_write_val=`SLL;
 7:rd_write_val=`SRL;
 8:rd_write_val=`SRA;
 9:rd_write_val=`SLT;
 10:rd_write_val=`SLTU;
 11::rd_write_val=`
 12:rd_write_val=
 13:rd_write_val=
 14:rd_write_val=
 15:rd_write_val=
 16:rd_write_val=`ADDI;
 17:rd_write_val=`XORI;
 18:rd_write_val=`ORI;
 19:rd_write_val=`ANDI;
 21:rd_write_val=`SLLI;
 21:rd_write_val=`SRLI;
 22:rd_write_val=`SRAI;
 23:rd_write_val=`SLTI;
 24:rd_write_val=`SLTIU;
 25:rd_write_val=
 26:rd_write_val=
 27:rd_write_val=
 28:rd_write_val=`LUI;
 29:rd_write_val=`AUIPC;

 endcase

end*/

always @ (*) begin
 rd_write_control = 1'b1;
 rd_write_val = 32'h0;
 case (alu_control)
 5'd1: begin
 rd_write_val =rs1_val+rs2_val;

 end
 5'd2: begin
 rd_write_val=rs1_val-rs2_val;

 end
 5'd3: begin
 rd_write_val=rs1_val^rs2_val;

 end
 5'd4: begin
 rd_write_val=rs1_val|rs2_val;

 end
 5'd5: begin
 rd_write_val=rs1_val&rs2_val;

 end
 5'd6: begin
 rd_write_val=rs1_val <<rs2_val;

 end
 5'd7: begin
 rd_write_val=rs1_val>>rs2_val;

 end
 5'd8: begin
 rd_write_val=rs1_val>>>rs2_val;

 end
 /* default: begin
 rd_write_val=`ALU_NOP;

 end*/

 endcase
end
endmodule
