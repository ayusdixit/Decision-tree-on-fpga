class iris_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(iris_scoreboard)

    uvm_tlm_analysis_fifo#(smp_xtn) ref_model_ap;  // Analysis port to receive reference model output
    uvm_tlm_analysis_fifo#(smp_xtn) rd_mon_ap;     // Analysis port to receive monitor output

    smp_xtn ref_output;  // To store reference model output
    smp_xtn mon_output;  // To store monitor output
/*    iris_xtn coverage;

    covergroup cov;
	petal_length : coverpoint coverage.petal_length_cm{
			bins target2 = {[0:6]};
			bins target3 = {7};

			}

	sepal_width : coverpoint coverage.sepal_width_cm{
			bins target3 = {[0:1]};
			bins target2 = {2};
			bins target3a = {[3:4]};

                        }


	petal_width : coverpoint coverage.petal_width_cm{
			bins target1 = {[0:3]};
			bins target2 = {[4:6]};

                        }


	sepal_length : coverpoint coverage.sepal_length_cm{
			bins target2 = {[0:5]};
			bins target2a = {6};

                        }
    endgroup
*/
    // Constructor
    function new(string name = "iris_scoreboard", uvm_component parent);
        super.new(name, parent);
        ref_model_ap = new("ref_model_ap", this);  // Create analysis port for reference model
        rd_mon_ap = new("rd_mon_ap", this);        // Create analysis port for read monitor
	//cov = new();
    endfunction

    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
    endfunction

 
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
    endfunction

    // Run Phase - Compare outputs from the reference model and monitor
    task run_phase(uvm_phase phase);
        forever begin
	    fork
            ref_model_ap.get(ref_output);  // Receive data from the reference model
            rd_mon_ap.get(mon_output);    // Receive data from the read monitor
	    join

	    //coverage = ref_output;
	    //cov.sample();

            // Compare outputs
            if (ref_output.target !== mon_output.target) begin
                // Log mismatch
                `uvm_error("SCOREBOARD", $sformatf("Target mismatch! Reference model: %b, Monitor: %b", ref_output.target, mon_output.target));
            end else begin
                // Log match
                `uvm_info("SCOREBOARD", $sformatf("Target matched: %b", ref_output.target), UVM_LOW);
            end

            // Optional: Add delay for stability
            #1;
        end
    endtask

endclass
