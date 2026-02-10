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

//Set the value of each array of the 1024-word array so that
//the Instruction Address matches the Instruction Data, making
//debugging easier. Also reset the Program Counter.
integer i;
initial begin
  for (i = 0; i < 1023; i = i + 1) begin
    Instr_Mem.instruction_mem[i] = i * 4;
  end
  PC.PC = 0;
end
endmodule
