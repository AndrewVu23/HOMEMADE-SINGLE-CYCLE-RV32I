module Instructions(
  input clk, reset
);

//Contain R, S, B, I Instructions
wire [31:0] ALU_Reg, read_address_1, read_address_2, instruction, ImmExt, B;
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

Sign_Ext Sign_Ext(
  .instruction(instruction),
  .ImmSrc(1'b00), //hardcoded for now
  .ImmExt(ImmExt)
);

ALU_Decoder ALU_Decoder(
  .op5(instruction[5]),
  .funct7_5(instruction[30]),
  .funct3(instruction[14:12]),
  .ALUControl(ALUControl),
  .ALUOp(2'b10)
);

ALU ALU(
  .A(read_address_1),
  .B(B),
  .ALUResult(ALU_Reg),
  .ALUControl(ALUControl),
  .flag()
);

Mux2 Mux2(
  .ALUSrc(1'b1), //hardcoded for now
  .read_address_2(read_address_2),
  .ImmExt(ImmExt),
  .B(B)
);

endmodule
