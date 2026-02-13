module Mux2(
    input logic [31:0] read_address_2,
    input logic [31:0] ImmExt, 
    input logic ALUSrc,
    output logic [31:0] B
);
    assign B = (ALUSrc) ? ImmExt : read_address_2;
endmodule
