module ALU_Decoder_tb;
  logic [2:0] funct3;
  logic [1:0] ALUOp;
  logic op5;
  logic funct7_5;
  logic [2:0] ALUControl;
  
  ALU_Decoder dut(.*);

  initial begin
    $dumpfile("waveform.vcd");
    $dumpvars(0, ALU_Decoder_tb);
    
    funct3 = 0; ALUOp = 0; op5 = 0; funct7_5 = 0;
    #10 ALUOp = 2'b00; 
    #10 ALUOp = 2'b01;
    #10 ALUOp = 2'b10; funct3 = 3'b000; op5 = 1; funct7_5 = 1;
    #10 ALUOp = 2'b10; funct3 = 3'b010;
    #10 ALUOp = 2'b10; funct3 = 3'b111;
    #10 $finish; 
  end
endmodule
