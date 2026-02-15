module function_lut #(
    parameter W_X =4, W_Y= 8,
    parameter signed A=1,B=10,c=-10
)(
    input logic [W_X-1:0] xf,xq,
    input logic [W_Y-1:0] yiq,
    output logic [W_Y-1:0] yf,yq_lut,yq_fun,
    output logic [W_X-1:0] xiq
);
function automatic [W_Y-1:0] factorial (
    input logic [W_X-1:0] n // take the input as the n 
);
    factorial = (n==1||n==0) ? 1 : n*factorial(n-1); 
    // if (n==1||n==0) return 1 else return n*factorial(n-1) like this 
    // as we use the function name here we dont have to write return this 
endfunction
function automatic signed [W_Y-1:0] quadratic (
    input logic signed [W_X-1:0] x
);
    return A*x**2 +B*x +c;
endfunction

function automatic signed [W_X-1:0] inverse_quadratic (
    input logic signed [W_Y-1:0] y
);
    logic signed [W_Y-1:0] result,quad;
    int error, min_error = 2**W_Y;

    for (int ux=0; ux<2**W_X;ux++ ) begin
        logic signed [W_X-1:0] x = ux;
        quad = quadratic(x);
        error = (y-quad);
        error = error>0? error : -error ;
        if (error<min_error) begin 
            min_error = error;
            result = x;
        end
    end 
    return result;
    endfunction

genvar i;
logic signed [2**W_X-1:0][W_Y-1:0] lut_factorial;// this will create a 2D array of size 16*8 for W_X=4 and W_Y=8 and each element is signed
logic signed [2**W_X-1:0][W_Y-1:0] lut_quadratic; 
logic signed [2**W_Y-1:0][W_X-1:0] lut_inverse_quadratic;
generate 

for (i=0; i<2**W_X;i=i+1) begin: factorial_gen
    assign lut_factorial[i] = factorial(i);
end
for (i=0; i<2**W_X;i=i+1) begin :quadratic_gen
    assign lut_quadratic[i] = quadratic(i);
end
for (i=0; i<2**W_Y;i=i+1) begin: inverse_guadratic_gen
    assign lut_inverse_quadratic[i] = inverse_quadratic(i);
end
endgenerate

assign yf = lut_factorial[xf];
assign yq_lut = lut_quadratic[xq];
assign xiq = lut_inverse_quadratic[yiq];
assign yq_fun = quadratic(xq);
endmodule