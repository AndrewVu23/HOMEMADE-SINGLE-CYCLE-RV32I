module Control_Unit(
  input logic [6:0] opcode,
  output logic reg_write, ALUSrc, MemWrite, ResultSrc, Branch, 
  output logic [1:0] ImmSrc, ALUOp
);
  always @(*) begin
    case(opcode)
      7'b0000011: begin
        reg_write = 1; ALUSrc = 1; MemWrite = 0; ResultSrc = 1; Branch = 0;
        ImmSrc = 2'b00; ALUOp = 2'b00;
      end
      7'b0100011: begin
        reg_write = 0; ALUSrc = 1; MemWrite = 1; ResultSrc = 1'bx; Branch = 0;
        ImmSrc = 2'b01; ALUOp = 2'b00;
      end
      7'b0110011: begin
        reg_write = 1; ALUSrc = 0; MemWrite = 0; ResultSrc = 0; Branch = 0;
        ImmSrc = 2'bxx; ALUOp = 2'b10;
      end
      7'b1100011: begin
        reg_write = 0; ALUSrc = 0; MemWrite = 0; ResultSrc = 1'bx; Branch = 1;
        ImmSrc = 2'b10; ALUOp = 2'b01;
      end
      7'b0010011: begin
        reg_write = 1; ALUSrc = 1; MemWrite = 0; ResultSrc = 0; Branch = 0;
        ImmSrc = 2'b00; ALUOp = 2'b10;
      end
      default: begin
        reg_write = 0; ALUSrc = 0; MemWrite = 0; ResultSrc = 0; Branch = 0;
        ImmSrc = 2'b00; ALUOp = 2'b00;
      end
    endcase
  end
endmodule
