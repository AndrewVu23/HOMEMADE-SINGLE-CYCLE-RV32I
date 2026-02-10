module Instr_Mem_tb;

    logic reset;
    logic [31:0] read_address;
    logic [31:0] instruction_out;

    Instr_Mem dut(.*);

    initial begin
        reset = 1;
        read_address = 32'b0;

        //Initialize each array so that the 
        //Instruction Data matches the Instruction Address
        //allowing for easier testing
        for (integer i = 0; i < 1024; i = i + 1) begin
            dut.instruction_mem[i] = i * 4;
        end

        #10 reset = 1; read_address = 32'h00000004;
        #10 reset = 1; read_address = 32'h00000008;

        reset = 0; #10;
        read_address = 32'h00000000; #10;
        read_address = 32'h00000004; #10;
        read_address = 32'h00000008; #10;

        #10 reset = 1; read_address = 32'h00000014;
        
        $finish;
    end

endmodule
