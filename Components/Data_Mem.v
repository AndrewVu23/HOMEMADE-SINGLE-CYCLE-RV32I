module Data_Mem(
  input clk, MemWrite,
  input logic [31:0] address, write_data,
  output logic [31:0] read_data
);
  //Initialize a 1024-bit depth RAM
  logic [31:0] data_mem [1023:0];

  assign read_data = data_mem[address[11:2]];

  always @(posedge clk) begin
    if (MemWrite) data_mem[address[11:2]] = write_data;
  end
endmodule
