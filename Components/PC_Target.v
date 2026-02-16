module PC_Target(
  input logic [31:0] ImmExt, PC,
  output logic [31:0] PCTarget
);
  assign PCTarget = ImmExt + PC;
endmodule