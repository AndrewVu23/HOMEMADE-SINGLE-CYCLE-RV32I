module Instructions(
  input clk, reset
);
logic [31:0] ALUResult, read_address_1, read_address_2, instruction, ImmExt, B, Result, read_data, PC, PC_plus_4, PCTarget, PC_next;
logic [2:0] ALUControl;
logic [1:0] ALUOp, ImmSrc;
logic reg_write, ALUSrc, MemWrite, ResultSrc, Branch, PCSrc, flag;

PC PC(
  .clk(clk),
  .reset(reset),
  .PC(PC),
  .PC_next(PC_next)
);

PC_plus_4 PC_plus_4(
  .reset(reset),
  .PC(PC),
  .PC_plus_4(PC_plus_4)
);

Instr_Mem Instr_Mem(
  .reset(reset),
  .address(PC),
  .instruction_out(instruction)
);

Reg_File Reg_File(
  .clk(clk),
  .reset(reset),
  .reg_write(reg_write),
  .address_1(instruction[19:15]),
  .address_2(instruction[24:20]),
  .address_data(instruction[11:7]),
  .read_address_1(read_address_1),
  .read_address_2(read_address_2),
  .write_data(Result)
);

Control_Unit Control_Unit(
  .opcode(instruction[6:0]),
  .reg_write(.reg_write),
  .ALUSrc(ALUSrc),
  .MemWrite(MemWrite),
  .ResultSrc(ResultSrc),
  .Branch(Branch),
  .ImmSrc(ImmSrc),
  .ALUOp(ALUOp),
  .flag(flag),
  .PCSrc(PCSrc)
);

Data_Mem Data_Mem(
  .clk(clk),
  .MemWrite(MemWrite),
  .address(ALUResult),
  .write_data(read_address_2),
  .read_data(read_data)
);

Sign_Ext Sign_Ext(
  .instruction(instruction),
  .ImmSrc(ImmSrc),
  .ImmExt(ImmExt)
);

ALU_Decoder ALU_Decoder(
  .op5(instruction[5]),
  .funct7_5(instruction[30]),
  .funct3(instruction[14:12]),
  .ALUControl(ALUControl),
  .ALUOp(ALUOp)
);

ALU ALU(
  .A(read_address_1),
  .B(B),
  .ALUResult(ALUResult),
  .ALUControl(ALUControl),
  .flag(flag)
);

PC_Target PC_Target(
  .PCTarget(PCTarget),
  .ImmExt(ImmExt),
  .PC(PC)
);

Mux1 Mux1(
  .PCTarget(PCTarget),
  .PC_plus_4(PC_plus_4),
  .PC_next(PC_next),
  .PCSrc(PCSrc)
);

Mux2 Mux2(
  .ALUSrc(ALUSrc),
  .read_address_2(read_address_2),
  .ImmExt(ImmExt),
  .B(B)
);

Mux3 Mux3(
  .PC_plus_4(PC_plus_4),
  .read_data(read_data),
  .ALUResult(ALUResult),
  .ResultSrc(ResultSrc),
  .Result(Result)
);

endmodule
