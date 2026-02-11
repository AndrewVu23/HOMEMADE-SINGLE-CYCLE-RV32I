module Instr_Fetch_tb;
  logic clk, reset;
  logic [31:0] instruction;
  
  Instr_Fetch dut(.*);

  initial begin
    //Set the value of each array of the 1024-word array so that
    //the Instruction Address matches the Instruction Data, making
    //debugging easier.
    integer i;
    for (i = 0; i < 1023; i = i + 1) begin
      Instr_Mem.instruction_mem[i] = i * 4;
    end
    PC.PC = 0;
    reset = 0; clk = 0;
    #5 reset = 1;
    #10 reset = 0;
    #200
    $finish;
  end

  always #5 clk = ~clk;
endmodule
