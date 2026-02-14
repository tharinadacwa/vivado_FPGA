module full_adder
(
    input logic a,b,cin,
    output logic sum,cout
);
// three different ways of combinational assignment 
logic wire_1, wire_2; // internal wires
assign wire_1 = a^b;
assign wire_2 = wire_1 & cin;
wire wire_3 = a & b;
always_comb begin
    cout = wire_3 | wire_2;
    sum = wire_1 ^ cin;
end
endmodule
