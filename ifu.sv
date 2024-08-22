module ifu(
 input logic i_clk,
 input logic i_rst,
 input logic stall_pc,
 input logic pc_update_control,
 input logic [31:0] pc_update_val,
 output logic [31:0] pc,
 output logic [31:0] prev_pc
);
always_ff @(posedge i_clk ) begin
 if(!i_rst) begin
 pc<= 32'b0;
 prev_pc <= 32'b0;
 end else begin
 if (stall_pc) begin
 prev_pc<=pc;
 end else begin
 if (pc_update_control) begin
 prev_pc<=pc;
 pc<= pc_update_val;
 end
 else begin
 pc<= pc+4;
 prev_pc<=pc;
 end
 end

 end
 end

`ifndef SUBMODULE_DISABLE_WAVES
 initial
 begin
 $dumpfile("./sim_build/ifu.vcd");
 $dumpvars(0, ifu);
 end
`endif
endmodule