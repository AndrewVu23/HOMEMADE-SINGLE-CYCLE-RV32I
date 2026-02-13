module Instr_Fetch_tb;
  logic clk, reset;
  logic [31:0] instruction;
  logic [31:0] expected_val;

  Instr_Fetch dut(.*);

  integer i;
  initial begin
    //Set the value of each array of the 1024-word array so that
    //the Instruction Address matches the Instruction Data, making
    //debugging easier.
    for (i = 0; i < 1023; i = i + 1) begin
      dut.Instr_Mem.instruction_mem[i] = i * 4;

      @(posedge clk);

      #1 expected_val = dut.PC_wire;

      if (instruction !== expected_val) $display("FAILED. Expected Values: %d. Got: %d", expected_val, instruction);
      else $display("PASSED");
    end
  end

  initial begin
    $dumpfile("waveform.vcd");
    $dumpvars(0, Instr_Fetch_tb);
    reset = 0; clk = 0;
    #5 reset = 1;
    #10 reset = 0;
    #200
    $finish;
  end

  always #5 clk = ~clk;
endmodule
