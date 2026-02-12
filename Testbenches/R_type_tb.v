module R_type_tb;
  logic clk, reset;
  
  R_type dut(.*);

  integer i;

  initial begin
    clk = 0; reset = 1; 
    for (i = 0; i < 32; i = i + 1) begin
       dut.Reg_File.Registers[i] = i;
    end

    //Instruction 0 (PC=0): ADD x10, x1, x2  (1 + 2 = 3)
    dut.Instr_Fetch.Instr_Mem.instruction_mem[0] = 32'b0000000_00010_00001_000_01010_0110011;

    //Instruction 1 (PC=4): SUB x11, x3, x1  (3 - 1 = 2)
    dut.Instr_Fetch.Instr_Mem.instruction_mem[1] = 32'b0100000_00001_00011_000_01011_0110011;

    //Instruction 2 (PC=8): OR x12, x2, x3   (2 | 3 = 3)
    dut.Instr_Fetch.Instr_Mem.instruction_mem[2] = 32'b0000000_00011_00010_110_01100_0110011;

    //Instruction 3 (PC=12): AND x13, x2, x3 (2 & 3 = 2)
    dut.Instr_Fetch.Instr_Mem.instruction_mem[3] = 32'b0000000_00011_00010_111_01101_0110011;
    
    //Instruction 4 (PC=16): SLT (Signed) -5 < 6
    //Manually set x5 = -5
    dut.Reg_File.Registers[5] = -5;
    dut.Instr_Fetch.Instr_Mem.instruction_mem[4] = 32'b0000000_00110_00101_010_01110_0110011;

    #10 reset = 0;

    #10 if (dut.ALU_Reg !== 3) $display("Failed: ADD"); else $display("Passed: ADD");
    #10 if (dut.ALU_Reg !== 2) $display("Failed: SUB"); else $display("Passed: SUB");
    #10 if (dut.ALU_Reg !== 3) $display("Failed: OR"); else $display("Passed: OR");
    #10 if (dut.ALU_Reg !== 2) $display("Failed: AND"); else $display("Passed: AND");
    #10 if (dut.ALU_Reg !== 1) $display("Failed: SLT"); else $display("Passed: SLT");

    #200
    
    $finish;
  end

  always #5 clk = ~clk;
endmodule
