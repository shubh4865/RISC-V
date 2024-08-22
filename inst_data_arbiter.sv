module inst_data_arbiter(
 input logic [31:0] inst_addr,
 input logic stall_pc,
 input logic [31:0] mem_addr,
 input logic mem_rw_mode,
 input logic [31:0] mem_write_data,
 input logic [3:0] mem_byte_en,
 input logic ignore_curr_inst,
 input logic [31:0] from_mem_data,
 output logic [31:0] instruction_code,
 output logic [31:0] mem_read_data,
 output logic [31:0] to_mem_addr,
 output logic to_mem_rw_mode,
 output logic [31:0] to_mem_write_data,
 output logic [3:0] to_mem_byte_en
);
always @(*)
begin
 if(stall_pc)
 begin
 to_mem_addr=mem_addr;
 to_mem_write_data=mem_write_data;
 to_mem_byte_en=mem_byte_en;
 to_mem_rw_mode=mem_rw_mode;
 end
 else
 begin
 to_mem_addr=inst_addr;
 to_mem_write_data=0;
 to_mem_byte_en=0;
 to_mem_rw_mode=1;
 end
 if(ignore_curr_inst)
 begin
 instruction_code=0;
 mem_read_data=from_mem_data;
 end
 else
 begin
 instruction_code=from_mem_data;
 mem_read_data=0;
 end
end
endmodule
