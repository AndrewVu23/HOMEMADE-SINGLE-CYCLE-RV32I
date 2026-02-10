module Instr_Fetch_tb;
  logic clk, reset;
  logic [31:0] instruction;
  
  Instr_Fetch dut(.*);

  initial begin
    reset = 0; clk = 0;
    #5 reset = 1;
    #10 reset = 0;
    #200
    $finish;
  end

  always #5 clk = ~clk;
endmodule
