module Reg_File(
  input logic reg_write, clk, reset,
  input logic [4:0] address_1, address_2, address_data,
  input logic [31:0] write_data,
  output logic [31:0] read_address_1, read_address_2
);

//A 32-bit RISCV has 32 32-bit registers, so we create a 
//32-bit register with a depth of 32
reg [31:0] Registers [31:0];

//The data at address 1 and 2 needs to be read at all time
//so that's why we use combinational logic here to read
//the data at the respective registers
assign read_address_1 = (reset) ? 32'h0 : Registers[address_1];
assign read_address_2 = (reset) ? 32'h0 : Registers[address_2];

//Data can only be written when we allow it to write (write_data = HIGH)
//Register 0 (x0) is hardwired to 0, so we can't write into that register
always @(posedge clk) begin
  if (reg_write && address_data != 5'b0) Registers[address_data] <= write_data;
end
endmodule
