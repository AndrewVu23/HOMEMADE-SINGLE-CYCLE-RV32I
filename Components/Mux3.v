//A MUX between Data Memory and ALU to enable data storage
module Mux3(
  input logic [31:0] ALUResult, read_data, PC_plus_4,
  input logic [1:0] ResultSrc,
  output logic [31:0] Result
);
  always @(*) begin
    case(ResultSrc)
      2'b00: Result = ALUResult;
      2'b01: Result = read_data;
      2'b10: Result = PC_plus_4;
    endcase
  end

endmodule
