`ifndef FILE_INCL
 `include "processor_defines.sv"
`endif
module jump(
 input logic i_clk,
 input logic i_rst,
 input logic [31:0] pc,
 input logic [31:0] imm,
 input logic [31:0] rs1_val,
 input logic [1:0] jump_control,
 output logic rd_write_control,
 output logic [31:0] rd_write_val,
 output logic pc_update_control,
 output logic [31:0] pc_update_val,
 output logic ignore_curr_inst
);

always @ (*) begin
 if (jump_control!=`JMP_NOP) begin
 case(jump_control)
 `JAL:begin
 rd_write_val=pc+4;
 pc_update_val=pc+imm;
 pc_update_control=1;
 rd_write_control=1;
 end
 `JALR:begin
 rd_write_val=pc+4;
 pc_update_val=rs1_val+imm;
 pc_update_control=1;
 rd_write_control=1;
 end
 endcase

 end else begin
 pc_update_control=0;
 pc_update_val=0;
 rd_write_control=0;
 rd_write_val=0;
 end
end
always_ff @(posedge i_clk or negedge i_rst) begin
 if(!i_rst) begin
 ignore_curr_inst<=0;
 end else begin
 ignore_curr_inst<=pc_update_control;
 end

end

`ifndef SUBMODULE_DISABLE_WAVES
 initial
 begin
 $dumpfile("./sim_build/jump.vcd");
 $dumpvars(0, jump);
 end
 `endif
endmodule
