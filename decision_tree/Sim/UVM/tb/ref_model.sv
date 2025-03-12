class reference_model extends uvm_component;
    `uvm_component_utils(reference_model)
	
    // Declare TLM ports for communication
    uvm_analysis_port#(smp_xtn) target_ap;  
    uvm_analysis_imp#(iris_xtn, reference_model) mon_imp;
    iris_xtn tr;
    smp_xtn target_tr;

    iris_xtn coverage;

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

    // Constructor
    function new(string name="ref_model", uvm_component parent);
        super.new(name, parent);
        target_ap = new("target_ap", this);  // Create the analysis port
        mon_imp = new("mon_imp", this);  // Create the input port
	cov = new();
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
	target_tr = smp_xtn::type_id::create("target_tr",this);
    endfunction

    virtual function void write(iris_xtn tr);

        if (tr.rst) begin
        target_tr.target = 3'b000; // Reset target
        end else begin
        // Decision tree traversal
        if (tr.petal_width_cm <= 3) begin
            target_tr.target = 3'b001; // Class 1
        end else begin
            if (tr.petal_width_cm <= 6) begin
                if (tr.petal_length_cm <= 6) begin
                    target_tr.target = 3'b010; // Class 2
                end else begin
                    if (tr.petal_length_cm <= 7) begin
                        if (tr.sepal_width_cm <= 1) begin
                            target_tr.target = 3'b011; // Class 3
                        end else begin
                            if (tr.sepal_length_cm <= 5) begin
                                target_tr.target = 3'b010; // Class 2
                            end else begin
                                if (tr.sepal_length_cm <= 6) begin
                                    if (tr.sepal_width_cm <= 2) begin
                                        target_tr.target = 3'b010; // Class 2
                                    end else begin
                                        target_tr.target = 3'b011; // Class 3
                                    end
                                end else begin
                                    target_tr.target = 3'b010; // Class 2
                                end
                            end
                        end
                    end else begin
                        target_tr.target = 3'b011; // Class 3
                    end
                end
            end else begin
                if (tr.petal_length_cm <= 6) begin
                    if (tr.sepal_width_cm <= 4) begin
                        target_tr.target = 3'b011; // Class 3
                    end else begin
                        target_tr.target = 3'b010; // Class 2
                    end
                end else begin
                    target_tr.target = 3'b011; // Class 3
                end
            end
        end
    end

    `uvm_info(get_type_name(), $sformatf("Classified Target: %b", target_tr.target), UVM_LOW)
    coverage = tr;
    cov.sample();
    target_ap.write(target_tr);
endfunction

endclass
