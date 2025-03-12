module iris_classifier(
    input [4:0] petal_length_cm,
    input [4:0] sepal_width_cm,
    input [4:0] petal_width_cm,
    input [4:0] sepal_length_cm,
    input clk,
    input reset,
    output reg [2:0] target
);

always @(posedge clk) begin
    if (reset) begin
        target <= 3'b000; // Reset target
    end else begin
        // Decision tree traversal
        if (petal_width_cm <= 3) begin
            target <= 3'b001; // Class 1
        end else begin
            if (petal_width_cm <= 6) begin
                if (petal_length_cm <= 6) begin
                    target <= 3'b010; // Class 2
                end else begin
                    if (petal_length_cm <= 7) begin
                        if (sepal_width_cm <= 1) begin
                            target <= 3'b011; // Class 3
                        end else begin
                            if (sepal_length_cm <= 5) begin
                                target <= 3'b010; // Class 2
                            end else begin
                                if (sepal_length_cm <= 6) begin
                                    if (sepal_width_cm <= 2) begin
                                        target <= 3'b010; // Class 2
                                    end else begin
                                        target <= 3'b011; // Class 3
                                    end
                                end else begin
                                    target <= 3'b010; // Class 2
                                end
                            end
                        end
                    end else begin
                        target <= 3'b011; // Class 3
                    end
                end
            end else begin
                if (petal_length_cm <= 6) begin
                    if (sepal_width_cm <= 4) begin
                        target <= 3'b011; // Class 3
                    end else begin
                        target <= 3'b010; // Class 2
                    end
                end else begin
                    target <= 3'b011; // Class 3
                end
            end
        end
    end
end



// Assertion for reset behavior
property ppt1;
	(@(posedge clk) reset |=> target == 3'b000);
endproperty

// Assertion for valid target values
//property ppt2;
//        (@(posedge clk) (target >= 3'b000 && target <= 3'b111));
//endproperty

// Assertion for petal_width_cm range
property ppt3;
        (@(posedge clk) (petal_width_cm >= 0 && petal_width_cm <= 31));
endproperty

// Assertion for petal_length_cm range
property ppt4;
        (@(posedge clk) (petal_length_cm >= 0 && petal_length_cm <= 31));
endproperty

// Assertion for sepal_width_cm range
property ppt5;
        (@(posedge clk) (sepal_width_cm >= 0 && sepal_width_cm <= 31));
endproperty

// Assertion for sepal_length_cm range
property ppt6;
        (@(posedge clk) (sepal_length_cm >= 0 && sepal_length_cm <= 31));
endproperty

// Assertion for class 1 when petal_width_cm <= 3
property ppt7;
        (@(posedge clk) (petal_width_cm <= 3) |=> target == 3'b001);
endproperty

// Assertion for class 2 or 3 when petal_width_cm <= 6
property ppt8;
        (@(posedge clk) (petal_width_cm <= 6) |=> (target == 3'b010 || target == 3'b011));
endproperty

// Assertion for class 3 when petal_width_cm > 6
property ppt9;
        (@(posedge clk) (petal_width_cm > 6) |=> target == 3'b011);
endproperty

// Assertion for class 2 when petal_length_cm <= 6
property ppt10;
        (@(posedge clk) (petal_length_cm <= 6) |=> target == 3'b010);
endproperty

// Assertion for class 3 when petal_length_cm > 7
property ppt11;
        (@(posedge clk) (petal_length_cm > 7) |=> target == 3'b011);
endproperty

// Assertion for class 3 based on sepal width and length
property ppt12;
        (@(posedge clk) (sepal_width_cm <= 1 && petal_length_cm > 6) |=> target == 3'b011);
endproperty

// Assertion for class 2 decision logic
property ppt13;
        (@(posedge clk) (petal_width_cm <= 6 && petal_length_cm > 6 && petal_length_cm <= 7 && sepal_width_cm > 1 && sepal_length_cm > 5) |=> target == 3'b010);
endproperty

// Assertion for class 3 decision logic
property ppt14;
        (@(posedge clk) (petal_width_cm <= 6 && petal_length_cm > 7) |=> target == 3'b011);
endproperty



resetn : assert property (ppt1)
			$display("Reset assertion passed: target is correctly set to 3'b000.");
		else 
			$fatal("Reset assertion failed: target should be 3'b000 when reset is active.");
    
	
//valid : assert property (ppt2)
//			$info("Target value is within range: target is between 3'b000 and 3'b111.");
//		else
//			$fatal("Target out of range: target value should be between 3'b000 and 3'b111.");
		
	
ptl_wth : assert property (ppt3)
			$info("Petal width is within valid range: petal_width_cm is between 0 and 31.");
		else 
			$fatal("Petal width out of range: petal_width_cm should be between 0 and 31.");
    
	
ptl_lth : assert property (ppt4)
			$info("Petal length is within valid range: petal_length_cm is between 0 and 31.");
		else 
			$fatal("Petal length out of range: petal_length_cm should be between 0 and 31.");
    
	
spl_wth : assert property (ppt5)
			$info("Sepal width is within valid range: sepal_width_cm is between 0 and 31.");
		else 
			$fatal("Sepal width out of range: sepal_width_cm should be between 0 and 31.");
    
	
spl_lth : assert property (ppt6)
			$info("Sepal length is within valid range: sepal_length_cm is between 0 and 31.");
		else 
			$fatal("Sepal length out of range: sepal_length_cm should be between 0 and 31.");
    
	
ptl_wth3 : assert property (ppt7) 
			$info("Class 1 assertion passed: target is correctly set to 3'b001 when petal_width_cm <= 3.");
		else 
			$fatal("Class 1 assertion failed: target should be 3'b001 when petal_width_cm <= 3.");
    
	
ptl_wth6 : assert property (ppt8)
			$info("Class 2/3 assertion passed: target is 3'b010 or 3'b011 when petal_width_cm <= 6.");
		else 
			$fatal("Class 2/3 assertion failed: target should be 3'b010 or 3'b011 when petal_width_cm <= 6.");
    
	
ptl_wth6c : assert property (ppt9)
			$info("Class 3 assertion passed: target is correctly set to 3'b011 when petal_width_cm > 6.");
		else 
			$fatal("Class 3 assertion failed: target should be 3'b011 when petal_width_cm > 6.");
   
	
ptl_lth6 : assert property (ppt10)
			$info("Class 2 assertion passed: target is correctly set to 3'b010 when petal_length_cm <= 6.");
		else 
			$fatal("Class 2 assertion failed: target should be 3'b010 when petal_length_cm <= 6.");
    
	
ptl_lth7 : assert property (ppt11)
			$info("Class 3 assertion passed: target is correctly set to 3'b011 when petal_length_cm > 7.");
		else 
			$fatal("Class 3 assertion failed: target should be 3'b011 when petal_length_cm > 7.");
    
	
spl_wlth : assert property (ppt12)
		$info("Class 3 assertion passed: target is correctly set to 3'b011 when sepal_width_cm <= 1 and petal_length_cm > 6.");
		else 
			$fatal("Class 3 assertion failed: target should be 3'b011 when sepal_width_cm <= 1 and petal_length_cm > 6.");
    

clss2 : assert property (ppt13)
			$info("Class 2 assertion passed: target is correctly set to 3'b010 when conditions for class 2 are met.");
		else 
			$fatal("Class 2 assertion failed: target should be 3'b010 when conditions for class 2 are met.");
   
    	
clss3 : assert property (ppt14)
			$info("Class 3 assertion passed: target is correctly set to 3'b011 when conditions for class 3 are met.");
		else 
			$fatal("Class 3 assertion failed: target should be 3'b011 when conditions for class 3 are met.");
    

cover property (ppt1);
//cover property (ppt2);
cover property (ppt3);
cover property (ppt4);
cover property (ppt5);
cover property (ppt6);
cover property (ppt7);
cover property (ppt8);
cover property (ppt9);
cover property (ppt10);
cover property (ppt11);
cover property (ppt12);
cover property (ppt13);
cover property (ppt14);


endmodule



module tb_iris_classifier;
    // Testbench signals
    reg [4:0] petal_length_cm;
    reg [4:0] sepal_width_cm;
    reg [4:0] petal_width_cm;
    reg [4:0] sepal_length_cm;
    reg clk;
    reg reset;
    wire [2:0] target;

    // Instantiate the iris_classifier module
    iris_classifier dut (
        .petal_length_cm(petal_length_cm),
        .sepal_width_cm(sepal_width_cm),
        .petal_width_cm(petal_width_cm),
        .sepal_length_cm(sepal_length_cm),
        .clk(clk),
        .reset(reset),
        .target(target)
    );

    // Clock generation
    always begin
        #5 clk = ~clk;  // Generate a clock with a period of 10 time units
    end

    // Test stimulus
    initial begin
        // Initialize signals
        clk = 0;
        reset = 0;
        petal_length_cm = 0;
        sepal_width_cm = 0;
        petal_width_cm = 0;
        sepal_length_cm = 0;
	#10;
        // Apply reset
        $display("Applying reset...");
        reset = 1;  // Assert reset
        #10;
        reset = 0;  // Deassert reset
        #10;

        // Test Case 1: Test for Class 1 (petal_width_cm <= 3)
        petal_width_cm = 3;
        petal_length_cm = 4;
        sepal_width_cm = 2;
        sepal_length_cm = 5;
        #10;  // Wait for the next clock edge
        $display("Test Case 1: petal_width_cm = %d -> target = %b", petal_width_cm, target);

        // Test Case 2: Test for Class 2 (petal_width_cm <= 6 and petal_length_cm <= 6)
        petal_width_cm = 5;
        petal_length_cm = 5;
        sepal_width_cm = 3;
        sepal_length_cm = 5;
        #10;
        $display("Test Case 2: petal_width_cm = %d, petal_length_cm = %d -> target = %b", petal_width_cm, petal_length_cm, target);

        // Test Case 3: Test for Class 3 (petal_width_cm > 6)
        petal_width_cm = 7;
        petal_length_cm = 8;
        sepal_width_cm = 3;
        sepal_length_cm = 6;
        #10;
        $display("Test Case 3: petal_width_cm = %d -> target = %b", petal_width_cm, target);

        // Test Case 4: Another Case for Class 2
        petal_width_cm = 4;
        petal_length_cm = 6;
        sepal_width_cm = 2;
        sepal_length_cm = 6;
        #10;
        $display("Test Case 4: petal_width_cm = %d, petal_length_cm = %d -> target = %b", petal_width_cm, petal_length_cm, target);

        // Test Case 5: Complex case for Class 3
        petal_width_cm = 5;
        petal_length_cm = 7;
        sepal_width_cm = 1;
        sepal_length_cm = 7;
        #10;
        $display("Test Case 5: petal_width_cm = %d, petal_length_cm = %d, sepal_width_cm = %d -> target = %b", petal_width_cm, petal_length_cm, sepal_width_cm, target);

        // Test Case 6: Another Class 3 with larger petal_length_cm
        petal_width_cm = 8;
        petal_length_cm = 9;
        sepal_width_cm = 3;
        sepal_length_cm = 7;
        #10;
        $display("Test Case 6: petal_width_cm = %d, petal_length_cm = %d -> target = %b", petal_width_cm, petal_length_cm, target);

        // Test Case 7: Random Case for Class 2
        petal_width_cm = 3;
        petal_length_cm = 6;
        sepal_width_cm = 2;
        sepal_length_cm = 5;
        #10;
        $display("Test Case 7: petal_width_cm = %d, petal_length_cm = %d -> target = %b", petal_width_cm, petal_length_cm, target);

        // Finish the simulation
        $finish;
    end

    // Monitor target changes
    initial begin
        $monitor("At time %0t, target = %b", $time, target);
    end

endmodule














    

