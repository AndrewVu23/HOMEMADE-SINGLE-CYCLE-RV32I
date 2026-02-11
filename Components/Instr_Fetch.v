module Instr_Fetch(
  input logic clk, reset,
  output logic [31:0] instruction
);
//Initialize wires to connect with other inputs/outputs of other modules' instances
wire [31:0] PC_wire, PC_plus_4_wire;

PC PC(
  .clk(clk),
  .reset(reset),
  .PC(PC_wire),
  .PC_next(PC_plus_4_wire)
);

PC_plus_4 PC_plus_4(
  .reset(reset),
  .PC(PC_wire),
  .PC_plus_4(PC_plus_4_wire)
);

Instr_Mem Instr_Mem(
  .reset(reset),
  .address(PC_wire),
  .instruction_out(instruction)
);

endmodule
