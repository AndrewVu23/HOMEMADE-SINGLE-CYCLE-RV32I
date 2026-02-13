//A MUX between Data Memory and ALU to enable data storage
module Mux3(
  input logic [31:0] ALUResult, read_data,
  input logic ResultSrc,
  output logic [31:0] Result
);
assign Result = (ResultSrc) ? read_data : ALUResult;

endmodule
