`ifndef FILE_INCL
 `include "processor_defines.sv"
`endif
module branch(
 input logic i_clk,
 input logic i_rst,
 input logic [31:0] pc,
 input logic [31:0] imm,
 input logic [31:0] rs1_val,
 input logic [31:0] rs2_val,
 input logic [2:0] branch_control,
 output logic pc_update_control,
 output logic [31:0] pc_update_val,
 output logic ignore_curr_inst
);
logic f,nf;
initial f=0;
always_comb begin
 if(f==0 && branch_control!=0)
 begin
 ignore_curr_inst=0;
 pc_update_control=0;
 case (branch_control)
 `BEQ: if(rs1_val==rs2_val) begin
 pc_update_val=pc+imm;
 nf=1;
 pc_update_control=1;
 end
 `BNE: if(rs1_val!=rs2_val)begin
 pc_update_val=pc+imm;
 nf=1;
 pc_update_control=1;
 end
 `BLTU: if(rs1_val<rs2_val)begin
 pc_update_val=pc+imm;
 nf=1;
 pc_update_control=1;
 end
 `BGEU:if(rs1_val>=rs2_val)begin
 pc_update_val=pc+imm;
 nf=1;
 pc_update_control=1;
 end
 `BLT:if(rs1_val<rs2_val)begin
 pc_update_val=pc+imm;
 nf=1;
 pc_update_control=1;
 end
 `BGE:if(rs1_val>=rs2_val)begin
 pc_update_val=pc+imm;
 nf=1;
 pc_update_control=1;
 end
 endcase
 end
 else if(f==0 && branch_control==0)
 begin
 nf=0;
 pc_update_control=0;
 pc_update_val=0;
 ignore_curr_inst=0;
 end
 else if(f==1)
 begin
 nf=0;
 pc_update_control=0;
 pc_update_val=0;
 ignore_curr_inst=1;
 end
end
always @(posedge i_clk or negedge i_rst)
begin
 if(~i_rst)
 begin
 f<=0;
 end
 else
 begin
 f<=nf;
 end
end
/*always_comb begin
 pc_update_control = 1'b0;
 pc_update_val = 32'b0;
 case (branch_control!=`BR_NOP)
 `BEQ : begin
 if(rs1_val==rs2_val) begin
 pc_update_val=pc+imm;
 pc_update_control=1'b1;
 end

 end

 `BNE : begin
 if (rs1_val != rs2_val) begin
 pc_update_val=pc+imm;
 pc_update_control=1'b1;
 end
 end
 `BLT : begin
 if ($signed(rs1_val) < $signed(rs2_val)) begin
 pc_update_val=pc+imm;
 pc_update_control=1'b1;
 end

 end

 `BGE : begin
 if ($signed(rs1_val)>=$signed(rs2_val)) begin
 pc_update_val=pc+imm;
 pc_update_control=1'b1;
 end

 end
 `BLTU : begin
 if (rs1_val<rs2_val) begin
 pc_update_val=pc+imm;
 pc_update_control=1'b1;
 end
 end
 `BGEU : begin
 if (rs1_val>=rs2_val) begin
 pc_update_val=pc+imm;
 pc_update_control=1'b1;
 end
 end

 endcase
end
always_ff @(posedge i_clk or negedge i_rst) begin
 if(!i_rst) begin
 ignore_curr_inst<=1'b0;
 end else begin
 ignore_curr_inst<=pc_update_control;
 end
end */
endmodule