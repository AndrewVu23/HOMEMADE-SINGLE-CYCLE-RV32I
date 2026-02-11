module R_type(
  input clk, reset
);
//R-type datapath, which consists of:
//Instruction Fetch, ALU, ALU Decoder, and Register File
  
wire [31:0] ALU_Reg, read_address_1, read_address_2, instruction;
wire [2:0] ALUControl;

Instr_Fetch Instr_Fetch(.*);

Reg_File Reg_File(
  .clk(clk),
  .reset(reset),
  .reg_write(1'b1),
  .address_1(instruction[19:15]),
  .address_2(instruction[24:20]),
  .address_data(instruction[11:7]),
  .read_address_1(read_address_1),
  .read_address_2(read_address_2),
  .write_data(ALU_Reg)
);

ALU_Decoder ALU_Decoder(
  .op5(instruction[6]),
  .funct_7_5(instruction[30]),
  .funct3(instruction[14:12]),
  .ALUControl(ALUControl),
  .ALUOp(2'b10)
);

ALU ALU(
  .A(read_address_1),
  .B(read_address_2),
  .ALUResult(ALU_Reg),
  .ALUControl(ALUControl),
  .flag()
);

endmodule
