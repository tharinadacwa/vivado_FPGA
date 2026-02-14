module rapid_full_adder(
    input logic a,b,cin,
    output logic sum,cout
);
assign {cout,sum} = a+b+cin;
endmodule

module rapid_n_adder #(
    parameter N=8
)(
    input logic signed [N-1:0] A,B,
    input logic cin,
    output logic signed [N-1:0] sum,
    output logic cout

);

assign {cout,sum} = A+B+cin;
endmodule