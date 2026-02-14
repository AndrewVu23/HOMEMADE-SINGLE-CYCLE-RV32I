module Instructions_tb;
    logic clk, reset;

    Instructions dut (
        .clk(clk),
        .reset(reset)
    );

    initial begin
        clk = 0; reset = 1;
        #10 reset = 0;

        // Setup: x1 = 0, Memory[1] = 0x12345678
        dut.Reg_File_Module.Registers[1] = 32'd0; 
        dut.Data_Mem_Module.data_mem[1]  = 32'h12345678;

        //Force Instruction: lw x2, 4(x1) -> Isolated Testing
        force dut.instruction = 32'b000000000100_00001_010_00010_0000011;

        @(posedge clk); #1; 

        if (dut.Reg_File_Module.Registers[2] !== 32'h12345678) $display("FAILED. Got: %h", dut.Reg_File_Module.Registers[2]);
        else $display("PASSED");
        
        release dut.instruction; //Stop the Force Instruction
        
        // Setup: x1 = 0, x2 = 0xDEADBEEF
        dut.Reg_File_Module.Registers[1] = 32'd0;
        dut.Reg_File_Module.Registers[2] = 32'hDEADBEEF;

        // Force Instruction: sw x2, 8(x1)
        force dut.instruction = 32'b0000000_00010_00001_010_01000_0100011;

        @(posedge clk); #1;

        // Check Memory Address 8 (Word Index 2)
        if (dut.Data_Mem_Module.data_mem[2] !== 32'hDEADBEEF) $display("FAILED. Memory[2] = %h", dut.Data_Mem_Module.data_mem[2]);
        else $display("PASSED");

        release dut.instruction;

        // Setup: x1=5, x2=5 (Equal)
        dut.Reg_File_Module.Registers[1] = 32'd5;
        dut.Reg_File_Module.Registers[2] = 32'd5;
        dut.PC_Module.PC = 32'd100; // Start at PC=100

        // Force Instruction: beq x1, x2, 8
        force dut.instruction = 32'b0_000000_00010_00001_000_0100_0_1100011;

        @(posedge clk); #1;

        // Expected PC: 100 + 8 = 108
        if (dut.PC_Module.PC !== 32'd108)
            $display("FAILED. PC = %d (Expected 108)", dut.PC_Module.PC);
        else
            $display("PASSED");

        release dut.instruction;

        // Setup: Start at PC=200
        dut.PC_Module.PC = 32'd200;

        // Force Instruction: jal x1, 20
        force dut.instruction = 32'b0_0000010100_0_00000000_00001_1101111;

        @(posedge clk); #1;

        // Check 1: PC Jump (200 + 20 = 220)
        if (dut.PC_Module.PC !== 32'd220) $display("FAILED (Jump). PC = %d (Expected 220)", dut.PC_Module.PC);
        else $display("PASSED");

        // Check 2: Link (x1 should hold old PC + 4 = 204)
        if (dut.Reg_File_Module.Registers[1] !== 32'd204) $display("FAILED (Link). x1 = %d (Expected 204)", dut.Reg_File_Module.Registers[1]);
        else $display("PASSED");

        release dut.instruction;

        #20;
        $finish;
    end

    always #5 clk = ~clk; 

endmodule
