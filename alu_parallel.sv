module alu_parallel #(
    parameter WIDTH = 8,
    parameter W_ALU_SEL = 3
)(
    input logic signed [WIDTH-1:0] bus_a , bus_b,
    output logic signed [WIDTH-1:0] alu_out,
    input logic [W_ALU_SEL-1:0] alu_sel,
    output logic flag_n, flag_c  
);
always_comb begin : basic_alu
    unique case (alu_sel)
        'b001: alu_out = bus_a +bus_b;
        'b010: alu_out = bus_a - bus_b;
        'b011: alu_out = bus_a * bus_b;
        'b100: alu_out = bus_a /2;
        default : alu_out = bus_a;
    endcase
end
assign flag_n = (alu_out < 0);
assign flag_c = (alu_out == 0);
endmodule