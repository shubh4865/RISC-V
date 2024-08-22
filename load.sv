`ifndef FILE_INCL
 `include "processor_defines.sv"
`endif
module load(
 input logic i_clk,
 input logic i_rst,
 input logic [31:0] rs1_val,
 input logic [31:0] imm,
 input logic [31:0] mem_data,
 input logic [4:0] rd_in,
 input logic [2:0] load_control,
 output logic stall_pc,
 output logic ignore_curr_inst,
 output logic rd_write_control,
 output logic [4:0] rd_out,
 output logic [31:0] rd_write_val,
 output logic mem_rw_mode,
 output logic [31:0] mem_addr
);
 logic [2:0]temp_control;
 logic [4:0]temp_rd;
 logic control;
 logic [31:0]prev_addr;
 //comb cycle 0
 always@(*)begin
 if(!control)
 begin
 ignore_curr_inst=1'b0;
 rd_write_val=32'b0;
 rd_write_control=1'b0;
 if(load_control)
 begin
 mem_rw_mode=1'b1;
 stall_pc=1;
 mem_addr=imm+rs1_val;
 end
 end

 else begin
 case(temp_control)
 `LB:begin
 case(prev_addr[1:0])
 2'b00:rd_write_val={{24{mem_data[7]}},mem_data[7:0]};
 2'b01:rd_write_val={{24{mem_data[15]}},mem_data[15:8]};
 2'b10:rd_write_val={{24{mem_data[23]}},mem_data[23:16]};
 2'b11:rd_write_val={{24{mem_data[31]}},mem_data[31:24]};
 endcase
 end
 `LH:begin
 case(prev_addr[1])
 00:rd_write_val={{16{mem_data[15]}},mem_data[15:0]};
 01:rd_write_val={{16{mem_data[31]}},mem_data[31:16]};
 endcase
 end
 `LW: rd_write_val=mem_data;
 `LBU:begin
 case(prev_addr[1:0])
 2'b00:rd_write_val={{24{1'b0}},mem_data[7:0]};
 2'b01:rd_write_val={{24{1'b0}},mem_data[15:8]};
 2'b10:rd_write_val={{24{1'b0}},mem_data[23:16]};
 2'b11:rd_write_val={{24{1'b0}},mem_data[31:24]};
 endcase
 end
 `LHU:begin
 case(prev_addr[1])
 00:rd_write_val={{16{1'b0}},mem_data[15:0]};
 01:rd_write_val={{16{1'b0}},mem_data[31:16]};
 endcase
 end
 endcase
 rd_write_control=1'b1;
 stall_pc=0;
 ignore_curr_inst=1'b1;
 mem_rw_mode=1'b1;
 mem_addr=32'b0;
 end
 end
 //sequential logic
 always@(posedge i_clk or negedge i_rst)
 begin
 if(!i_rst)
 begin
 mem_rw_mode<=1'b1;
 rd_out<=5'b0;
 //rd_write_val=32'b0;
 stall_pc=0;
 control<=1'b0;
 //ignore_curr_inst=1'b0;
 //rd_write_control<=1'b0;
 mem_addr=32'b0;
 end
 else
 begin
 case(control)
 0:begin
 if(load_control)begin
 control<=1;
 end
 end
 1: begin
 control<=0;
 end
 endcase
 rd_out<=(load_control)?rd_in:5'b0;
 temp_control<=load_control;
 prev_addr<=mem_addr;
 end
 end
/*logic [1:0] state;
always_comb begin
 mem_rw_mode = 1;
 if (state==1) begin
 stall_pc = 1;
 ignore_curr_inst = 0;
 rd_write_control = 0;
 rd_out = 0;
 mem_addr=rs1_val+imm;

 mem_rw_mode ase(load_control)
 `LW: begin
 rd_write_val = mem_data;
 end
 `LH: begin
 rd_write_val={{16{mem_data[mem_addr]}}}
 end
 `LW: begin

 end
 default: begin

 endcase
end
always_ff @(posedge i_clk or negedge i_rst) begin
 if(!i_rst)begin
 state<=0;
 rd_out<=0;
 rd_write_val<=0;
 mem_addr<=0;
 rd_out<=0;
 pc_stall<=0;
 end
 else begin
 if (state==0) begin
 if(load_control) state<=1
 else state <=0

 end
 else(state==1) begin
 state<=0;
 end
 end
end */
`ifndef SUBMODULE_DISABLE_WAVES
 initial
 begin
 $dumpfile("./sim_build/load.vcd");
 $dumpvars(0, load);
 end
 `endif
endmodule