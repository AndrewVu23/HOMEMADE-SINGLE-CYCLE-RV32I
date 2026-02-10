module PC(
  input logic clk, reset,
  input logic [31:0] PC_next,
  output logic [31:0] PC
);
always @(posedge clk) begin
  PC_next <= (reset) ? 32'h0 : PC;
end
endmodule
