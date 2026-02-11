module ALU_Decoder(
  input logic [2:0] funct3,
  input logic [1:0] ALUOp,
  input logic funct7_5, op5,
  output logic [2:0] ALUControl
);
wire [1:0] op5_funct7_5;

assign op5_funct7_5 = {op5, funct7_5};

always @(*) begin
  //Set a default value to prevent a latch
  //when funct3 = 111 (XOR)
  ALUControl = 3'b000; 

  case(ALUOp)
    2'b00: ALUControl = 3'b000; //Addition
    2'b01: ALUControl = 3'b001; //Subtraction
    2'b10: begin
    if (funct3 == 3'b000) begin
      if (op5_funct7_5 == 2'b11) ALUControl = 3'b001; //Subtract
      else ALUControl = 3'b000; //Addition 
      //We use 'else' since there are 3 different combinations 
      //of {op5, funct7_5} that could lead to addition
    end
    else if (funct3 == 3'b010) ALUControl = 3'b101; //Set (if) Less Than
    else if (funct3 == 3'b110) ALUControl = 3'b011; //OR
    else if(funct3 == 3'b111) ALUControl = 3'b010; //AND
    end
    default: ALUControl = 3'b000;
  endcase
end
endmodule
