module PC(
  input logic clk, reset,
  input logic [31:0] PC_next,
  output logic [31:0] PC
);
//A Program Counter which points to the address
//of the curret instruction and taking the next
//address on each rising edge 
always @(posedge clk) begin
  PC <= (reset) ? 32'h0 : PC_next;
end
endmodule
