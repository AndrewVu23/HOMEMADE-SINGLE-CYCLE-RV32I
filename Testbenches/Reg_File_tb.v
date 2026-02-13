module Reg_File_tb;
  logic clk, reset, reg_write;
  logic [4:0] address_1, address_2, address_data;
  logic [31:0] write_data;
  wire [31:0] read_address_1, read_address_2;

  Reg_File dut(.*);
  integer i;

  initial begin
    clk = 0; reset = 1; reg_write = 0;
    address_1 = 0; address_2 = 0; address_data = 0; write_data = 0;
    
    #10 reset = 0;

    //Initialize the values of each register
    //for easier testing
    for (i = 1; i < 6; i = i + 1) begin
      reg_write = 1;
      address_data = i;
      write_data = i * 10;
  
      @(posedge clk); #1;
    end
    
    reg_write = 0; 
    address_1 = 1;
    address_2 = 2;
    
    #1 
    //Case 1: Check if the ports read the data & address correctly
    if (read_address_1 !== 10) $display("FAILED. x1: Expected: 10. Got: %0d. Time: %0t", read_address_1, $time);
    else $display("PASSED");

    if (read_address_2 !== 20) $display("FAILED. x2: Expected: 20. Got: %0d. Time: %0t", read_address_2, $time);
    else $display("PASSED");

    address_data = 0;
    write_data = 32'hFFFFFFFF;
    reg_write = 1;
    
    @(posedge clk); #1
    //Case 2: Check if x0 can be overwritten or not (MUST BE NOT)
    address_1 = 0; #1
    
    if (read_address_1 !== 0) $display("FAILED. x0 Overwritten. Value: %0h. Time: %0t", read_address_1, $time);
    else $display("PASSED");

    address_data = 1;
    write_data = 99;
    
    @(posedge clk); #1
    //Case 3: Check if data can be written when we not enable RegWrite (MUST BE NOT)
    reg_write = 0; #1
    address_1 = 1; #1

    if (read_address_1 === 99) $display("FAILED. Data Changed when RegWrite was 0. Time %0t", $time);
    else if (read_address_1 === 10) $display("PASSED");
    else $display("FAILED. Got: %0d. Time: %0t", read_address_1, $time);

    #100
    $finish;
  end

  always #5 clk = ~clk;

endmodule
