module PC_plus_4(
  input logic clk, reset,
  input logic [31:0] PC,
  output logic [31:0] PC_plus_4
);
always @(posedge clk) begin
  PC_plus_4 <= (reset) ? 32'h0 : PC + 32'd4;
end
endmodule
