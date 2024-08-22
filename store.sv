`ifndef FILE_INCL
 `include "processor_defines.sv"
`endif
module store(
 input logic i_clk,
 input logic i_rst,
 input logic [31:0] rs1_val,
 input logic [31:0] rs2_val,
 input logic [31:0] imm,
 input logic [2:0] store_control,
 output logic stall_pc,
 output logic ignore_curr_inst,
 output logic mem_rw_mode,
 output logic [31:0] mem_addr,
 output logic [31:0] mem_write_data,
 output logic [3:0] mem_byte_en
);
 logic f,nf;
initial f=0;
always @(*)
begin
 if(f==0 && store_control!=0)
 begin
 nf=1;
 stall_pc=1;
 ignore_curr_inst=0;
 mem_rw_mode=0;
 mem_addr=rs1_val+imm;
 case (store_control)
 `SB: begin
 case (mem_addr[1:0])
 2'h0: begin
 mem_write_data = {24'h0,rs2_val[7:0]};
 mem_byte_en=1;
 end
 2'h1: begin
 mem_write_data = {16'h0,rs2_val[7:0],8'h0};
 mem_byte_en=2;
 end
 2'h2: begin
 mem_write_data= {8'h0,rs2_val[7:0],16'h0};
 mem_byte_en=4;
 end
 default: begin
 mem_write_data= {rs2_val[7:0],24'h0};
 mem_byte_en=8;
 end
 endcase
 end
 `SH: begin
 if(mem_addr[1:0]==2'h0 || mem_addr[1:0]==2'h1)
 begin
 mem_write_data={16'h0,rs2_val[15:0]};
 mem_byte_en=3;
 end
 else
 begin
 mem_write_data= {rs2_val[15:0],16'h0};
 mem_byte_en=12;
 end
 end
 `SW:begin
 mem_write_data=rs2_val;
 mem_byte_en=15;
 end
 default: begin
 mem_write_data=0;
 mem_byte_en=0;
 end
 endcase
 end
 else if(f==0 && store_control==0)
 begin
 nf=0;
 stall_pc=0;
 ignore_curr_inst=0;
 mem_rw_mode=1;
 mem_addr=0;
 mem_write_data=0;
 mem_byte_en=0;
 end
 else if(f==1)
 begin
 nf=0;
 ignore_curr_inst=1;
 stall_pc=0;
 mem_rw_mode=1;
 mem_addr=0;
 mem_write_data=0;
 mem_byte_en=0;
 end
end
always @(posedge i_clk or negedge i_rst) begin
 if(~i_rst)
 begin
 f<=0;
 end
 else
 begin
 f<=nf;
 end
end
/*logic [2:0] temp_control;
 logic [31:0] prev_addr;
 logic control;
 // Comb logic
 always_comb begin
 if (!control) begin
 ignore_curr_inst = 1'b0;
 mem_write_data = 32'b0;
 mem_byte_en = 4'b0000;
 if (store_control) begin
 mem_rw_mode = 1'b0; // Write mode
 stall_pc = 1;
 mem_addr = imm + rs1_val;
 case (store_control)
 `SB: begin
 mem_byte_en = 4'b0001 << mem_addr[1:0];
 mem_write_data = {4{rs2_val[7:0]}};
 end
 `SH: begin
 if (mem_addr[1] == 1'b0) begin
 mem_byte_en = 4'b0011;
 mem_write_data = {2{rs2_val[15:0]}};
 end else begin
 mem_byte_en = 4'b1100;
 mem_write_data = {2{rs2_val[15:0]}};
 end
 end
 `SW: begin
 mem_byte_en = 4'b1111;
 mem_write_data = rs2_val;
 end
 default: begin
 mem_rw_mode = 1'b1; // Invalid store control, do not perform write
 end
 endcase
 end
 end else begin
 mem_rw_mode = 1'b0; // Write mode
 mem_addr = prev_addr;
 stall_pc = 0;
 ignore_curr_inst = 1'b1;
 end
 end
 // Sequential logic
 always_ff @(posedge i_clk or negedge i_rst) begin
 if (!i_rst) begin
 mem_rw_mode <= 1'b0;
 stall_pc <= 0;
 control <= 1'b0;
 mem_addr <= 32'b0;
 end else begin
 case (control)
 0: begin
 if (store_control) begin
 control <= 1;
 end
 end
 1: begin
 control <= 0;
 end
 endcase
 temp_control <= store_control;
 prev_addr <= mem_addr;
 end
 end
`ifndef SUBMODULE_DISABLE_WAVES
 initial begin
 $dumpfile("./sim_build/store.vcd");
 $dumpvars(0, store);
 end
 `endif */
endmodule