module ALU_tb;
  logic [31:0] A, B, ALUResult;
  logic [2:0] ALUControl;
  logic flag;
  logic [31:0] signed_A, signed_B;

  ALU dut(.*);

  initial begin
    A = 0; B = 0;
    
    //Case 1: A = B = 3
    #10 A = 32'h00000003; B = 32'h00000003;
    #10 ALUControl = 3'b000;
    #10 ALUControl = 3'b001;
    #10 ALUControl = 3'b101;
    #10 ALUControl = 3'b011;
    #10 ALUControl = 3'b010;
    
    //Case 2: A = 5, B = 7
    #10 A = 32'h00000005; B = 32'h00000007;
    #10 ALUControl = 3'b000;
    #10 ALUControl = 3'b001;
    #10 ALUControl = 3'b101;
    #10 ALUControl = 3'b011;
    #10 ALUControl = 3'b010;

    //Case 3: A = -7, B = -5
    #10 A = -32'sd7; B = -32'sd5;
    #10 ALUControl = 3'b000;
    #10 ALUControl = 3'b001;
    #10 ALUControl = 3'b101;
    #10 ALUControl = 3'b011;
    #10 ALUControl = 3'b010;

    $finish;
  end
endmodule

