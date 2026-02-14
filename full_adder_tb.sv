module full_adder_tb;
timeunit 10ns; timeprecision 1ns;  // time unit and time precision
logic a=0,b,cin=0,sum,cout; // variable diclaration with and without initial values 
full_adder dut(.*); // module instantiation here we can use .* varable namse should be same as port names in the module or we can use .a(a),.b(b) etc. ehere we are using .* so we have to make sure that variable names in the testbench and port names in the module should be same otherwise it will give error.
initial begin // initial block is used to initialize the variables and to apply the test vectors to the inputs of the module. it will execute only once at the beginning of the simulation.
    $dumpfile("dump.vcd"); $dumpvars(0,dut); // 
    #30 a<= 0; b<= 0 ; cin <= 0;
    #10 a<=0 ; b<=0; cin <= 1;
    #20 a <= 1; b <= 1; cin <=0;

    #1 assert ({cout,sum}== a+b+cin)
         $display ("ok");
    else $error("Not ok");
    #10 a<= 1; b<=1; cin<=1;
    #1 assert (dut.wire_1 == 0) // accesing internal wire of the module using dut.wire_1
         $display ("True.wire_1:%d",dut.wire_1);// %d is string formating with integer arguments
    else $error ("False.wire_1:%d",dut.wire_1);
    $finish();// simulation ends 

end
endmodule