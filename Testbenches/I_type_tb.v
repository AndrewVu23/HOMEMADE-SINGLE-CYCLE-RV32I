module I_type_tb;
  logic clk, reset;

  Instructions dut(.*); 

  integer i;

  initial begin
    clk = 0; reset = 1; 
    //Initialize the Register File so that
    //the Register Data matches the Register Number
    for (i = 0; i < 32; i = i + 1) begin
       dut.Reg_File.Registers[i] = i;
    end

    //Write the Instructions to the Instruction Memory
    //Instruction 0 (PC=0): ADDI x10, x0, 10 (0 + 10 = 0)
    dut.Instr_Fetch.Instr_Mem.instruction_mem[0] = 32'b000000001010_00000_000_01010_0010011;

    //Instruction 1 (PC=4): ADDI x11, x0, -5 (0 + (-5) = -5)
    dut.Instr_Fetch.Instr_Mem.instruction_mem[1] = 32'b111111111011_00000_000_01011_0010011;

    //Instruction 2 (PC=8): ORI x12, x2, 5 (2 | 5 = 7)
    dut.Instr_Fetch.Instr_Mem.instruction_mem[2] = 32'b000000000101_00010_110_01100_0010011;

    //Instruction 3 (PC=12): ANDI x13, x2, 3 (2 & 3 = 2)
    dut.Instr_Fetch.Instr_Mem.instruction_mem[3] = 32'b000000000011_00010_111_01101_0010011;

    //Instruction 4 (PC=16): SLTI x14, x5, 6 (5 < 6)
    //Manually set x5 = -5
    dut.Reg_File.Registers[5] = -5;
    dut.Instr_Fetch.Instr_Mem.instruction_mem[4] = 32'b000000000110_00101_010_01110_0010011;

    #10 reset = 0;

    #1 if (dut.ALU_Reg !== 10) $display("Failed: ADDI (Positive)"); 
    else $display("Passed: ADDI (Positive)");
    #10 if (dut.ALU_Reg !== -5) $display("Failed: ADDI (Negative)"); 
    else $display("Passed: ADDI (Negative)");
    #10 if (dut.ALU_Reg !== 7) $display("Failed: ORI"); else $display("Passed: ORI");
    #10 if (dut.ALU_Reg !== 2) $display("Failed: ANDI"); else $display("Passed: ANDI");
    #10 if (dut.ALU_Reg !== 1) $display("Failed: SLTI"); else $display("Passed: SLTI");

    #100

    $finish;
  end
  always #5 clk = ~clk;
endmodule
