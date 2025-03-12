module top;

    bit clk;

    import uvm_pkg::*;
	`include "uvm_macros.svh"
    import iris_pkg::*;

    iris_classifier_if in0(clk);
    iris_classifier_if in1(clk);
    
    always #5 clk = ~clk;
    
    iris_classifier DUV (.petal_length_cm(in0.petal_length_cm),
                         .sepal_width_cm(in0.sepal_width_cm),
                         .petal_width_cm(in0.petal_width_cm),
                         .sepal_length_cm(in0.sepal_length_cm),
                         .clk(clk),
			 .rst(in0.rst),
                         .target(in1.target));
    
    
    initial 
        begin
        uvm_config_db #(virtual iris_classifier_if)::set(null,"*","vif0",in0);
        uvm_config_db #(virtual iris_classifier_if)::set(null,"*","vif1",in1);
        run_test();
        end


endmodule
