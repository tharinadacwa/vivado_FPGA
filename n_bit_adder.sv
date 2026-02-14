module n_bit_adder #(
    parameter N=8 // parameter declaration we can use this any where in the module we can change this line and it will change all other lines it has used the parameter 
)(
    input logic signed  [N-1:0] A,B, // signed N bits packed vectors little endian wire vectors 
    input logic cin,
    output logic signed [N-1:0] sum,
    output logic co
);
logic [N:0] C ; // N+1 bit little endian wire vector unpacked vector 
assign C[0] = cin;
assign co = C[N];
genvar i;
generate
for (i = 0; i<N; i=i+1) begin:add
    full_adder fa(
        .a(A[i]),
        .b(B[i]),
        .cin(C[i]),
        .co(C[i+1]),
        .sum(sum[i])
    );
end
endgenerate
endmodule