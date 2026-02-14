module Mux1(
  input logic PCSrc,
  input logic [31:0] PCTarget, PC_plus_4,
  output logic [31:0] PC_next
);
  assign PC_next = (PCSrc) ? PCTarget : PC_plus_4;
endmodule
