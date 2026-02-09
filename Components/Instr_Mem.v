module Instr_Mem(
    input reset,
    input [31:0] address,
    output [31:0] instruction_out
);

//Initialize the Size of the Instruction Memory (width x depth)
//In this RISCV, we are going to use 32-bit x 1024-bit
logic [31:0] instruction_mem[1023:0]; 

//Reset gates output to 0 rather than clearing the entire 1024-word array to save area & power
//RISCV uses byte-addressing, so we shift the address right by 2 (or dividing by 4) to align the word index
//For example, we want Instruction Memory to read address 8 (which is index 2), we have to divide the address by 4
//Similarly, address 16 is index 4, address 20 is index 5,...
//To right shift by 2, we select only the upper bits, cutting out 2 bits at the bottom
//To select one of 1024 slots, we only use 10 bits since 2^10 = 1024 => [11:2]
assign instruction_out = (reset) ? 32'h0 : instruction_mem[address[11:2]];
endmodule
