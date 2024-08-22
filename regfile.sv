module regfile(
 input logic i_clk,
 input logic i_rst,
 input logic [4:0] rs1,
 input logic [4:0] rs2,
 input logic [4:0] rd,
 input logic rd_write_control,
 input logic [31:0] rd_write_val,
 output logic [31:0] rs1_val,
 output logic [31:0] rs2_val
);
logic [31:0]register[32];

always @(posedge i_clk or negedge i_rst ) begin
 if(!i_rst) begin
 for (int i=0; i<=31;i++ ) begin
 register[i] <= 32'b0;
 end

 end
 else begin

 if (rd_write_control) begin
 register[rd]<=rd_write_val;
 end
 //register[0]<={32{1'b0}};
 register[0]<=32'b0;
 end
end
always_comb begin
 rs1_val=register[rs1];
 rs2_val=register[rs2];
end
endmodule
