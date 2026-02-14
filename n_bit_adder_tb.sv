module n_bit_adder_tb;
timeunit 10ns; timeprecision 1ns;

localparam N=8;
logic signed [N-1:0] A,B,sum; // packed vectors little endian wire vectors
logic cin,co;

n_bit_adder #(.N(N)) dut(.*); // important to use #(.N(N)) to pass the parameter value to the module otherwise it will take default value of N which is 8 in this case and it will give error if we change the value of N in the module and not in the testbench
initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0,dut);
    A <= 8'd5; B<= 8'd10; cin <= 0;
    #1 assert (sum == 8'd15) else $error("Fail");// #1 is there for the combinational logic to setlle down before the assertion is checked otherwise it will give error 
    #10 A <= 8'd30; B <= -8'd10; cin <= 0;
    #10 A<= 8'd5; B <= 8'd10; cin <= 1;
    #10 A<= 8'd127; B <= 8'd1; cin <= 0;
    

    repeat (10) begin 
        #9
        std::randomize(cin);
        std::randomize(A) with {A inside {[-127:127]};};
        std::randomize(B) with {B inside {[-127:127]};};
        #1 
        assert ({co,sum}==A+B+cin)
        else $error("%d+%d+%d != {%d,%d}",A,B,cin,co,sum);
    end
end
endmodule