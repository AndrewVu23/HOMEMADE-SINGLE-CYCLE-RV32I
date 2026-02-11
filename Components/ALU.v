module ALU(
  input logic [31:0] A, B,
  input logic [2:0] ALUControl,
  output logic flag,
  output logic [31:0] ALUResult
);
  
logic [31:0] signed_A, signed_B;

//Allowing operations on signed numbers 
//using $signed casting
assign signed_A = $signed(A);
assign signed_B = $signed(B);

//ALU Operations
always @(*) begin
  case(ALUControl)
    3'b000: ALUResult = signed_A + signed_B; //Addition
    3'b001: ALUResult = signed_A - signed_B; //Subtraction
    3'b101: ALUResult = (signed_A < signed_B) ? 32'h1 : 32'h0; //Set (if) Less Than
    3'b011: ALUResult = A | B; //OR
    3'b010: ALUResult = A & B; //AND
    default: ALUResult = 32'h0; //Initialize result to be 0
  endcase

  flag = (ALUResult == 32'h0) ? 1 : 0; //Set a zero flag for 'beq' Instruction
end
endmodule
