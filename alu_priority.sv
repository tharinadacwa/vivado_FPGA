module alu_priority #(
    parameter WIDTH = 8,
    parameter W_ALU_SEL =3
)(
    input logic signed [WIDTH-1:0] bus_a, bus_b,
    output logic signed [WIDTH-1:0] alu_out,
    input logic [W_ALU_SEL-1:0] alu_sel,
    output logic flag_n,flag_c
);
always_comb begin : basic_alu

    if (alu_sel == 'b001) alu_out = bus_a + bus_b;
    else if (alu_sel == 'b010) alu_out = bus_a - bus_b;
    else if (alu_sel == 'b011) alu_out = bus_a * bus_b;
    else if (alu_sel == 'b100) alu_out = bus_a / 2;
    else alu_out = bus_a;
   
    
end
assign flag_n = (alu_out <0);
assign flag_c = (alu_out == 0);
endmodule