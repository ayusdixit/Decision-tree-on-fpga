module testbench();

    // Inputs
    reg [4:0] petal_length_cm;
    reg [4:0] sepal_width_cm;
    reg [4:0] petal_width_cm;
    reg [4:0] sepal_length_cm;
    reg clk;
    reg reset;

    // Outputs
    wire [2:0] target;

    // Declare file variables
    integer file;
    integer outfile;

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
    always #5 clk = ~clk; // Toggle the clock every 5 time units

    // Stimulus
    initial begin
        // Initialize inputs
        petal_length_cm = 5'b0;
        sepal_width_cm = 5'b0;
        petal_width_cm = 5'b0;
        sepal_length_cm = 5'b0;
        clk = 0;
        reset = 0;

        // Reset
        #10 reset = 1;
        #10 reset = 0;

        // Open the file for reading
        file = $fopen("sample.txt", "r");

        // Open the file for writing
        outfile = $fopen("/home/binodssd/Desktop/project_2/project_1/new.txt", "w");

        // Read and process test cases from the file
        if (file != 0) begin
            while (!$feof(file)) begin
                // Read a line from the file
                $fscanf(file, "%h,%h,%h,%h", petal_length_cm, sepal_width_cm, petal_width_cm, sepal_length_cm);

                // Display inputs
                $display("Time=%0t, Petal Length=%d, Sepal Width=%d, Petal Width=%d, Sepal Length=%d", $time, petal_length_cm, sepal_width_cm, petal_width_cm, sepal_length_cm);

                // Wait for some time
                #10;

                // Display target
                $display("Time=%0t, Target=%d", $time, target);

                // Write the target value to the file
                $fwrite(outfile, "%d\n", target);

                // Display the target value
                $display("Target written to file: %d", target);

                // Wait for some time before next test case
                #10;
            end
            // Close the files
            $fclose(file);
            $fclose(outfile);
        end else begin
            $display("Error: Could not open file");
        end

        // End simulation
        #1000000000 $finish;
    end

endmodule
