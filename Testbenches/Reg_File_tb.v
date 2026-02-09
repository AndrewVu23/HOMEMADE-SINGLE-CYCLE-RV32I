module Reg_File_tb;
  logic reg_write, clk, reset;
  logic [4:0] address_1, address_2, address_data;
  logic [31:0] write_data;
  logic [31:0] read_address_1, read_address_2;

Reg_File dut(.*);

integer i;

initial begin
  $dumpfile("waveform.vcd");
  $dumpvars(0, Reg_File_tb);
  reset = 0; clk = 0; reg_write = 0;
  address_1 = 5'h0;
  address_2 = 5'h0;

  #5 reset = 1; #10 reset = 0;

  for (i = 0; i < 32; i = i + 1) begin
    dut.Registers[i] = 32'h0;
  end

  for (i = 0; i < 5; i = i + 1) begin
    address_data = i;
    write_data = i * 10;
    reg_write = 1;
    address_1 = i[4:0];
    #10;
  end

  reg_write = 0;

  for (i = 0; i < 5; i = i + 1) begin
    address_1 = i;
    address_2 = 2 - i;
    #10;
  end

  #100;

  $finish;
end

always #5 clk = ~clk;

endmodule
