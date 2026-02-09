module Reg_File(
  input logic reg_write, clk, reset,
  input logic [4:0] address_1, address_2, address_data,
  input [31:0] write_data,
  output logic [31:0] read_address_1, read_address_2
);
reg [31:0] Registers [31:0];

assign read_address_1 = (reset) ? 32'h0 : Registers[address_1];
assign read_address_2 = (reset) ? 32'h0 : Registers[address_2];

always @(posedge clk) begin
  Registers[address_data] <= (reg_write) ? write_data : 32'h0;
end
endmodule
