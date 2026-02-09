module Instr_Mem(
    input reset,
    input [31:0] address,
    output [31:0] instruction_out
);
logic [31:0] instruction_mem[1023:0]; 

assign instruction_out = (reset) ? 32'h0 : instruction_mem[address[11:2]];
endmodule
