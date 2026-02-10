module PC_plus_4(
  input reset,
  input logic [31:0] PC,
  output logic [31:0] PC_plus_4
);
//A Program Counter that automatically moves to the next
//address (increasing by 4) reading the current address
  assign PC_plus_4 = (reset) ? 32'h0 : PC + 32'd4;
endmodule
