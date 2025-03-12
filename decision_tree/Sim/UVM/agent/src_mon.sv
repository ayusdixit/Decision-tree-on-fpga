class iris_wrmon extends uvm_monitor;
    `uvm_component_utils(iris_wrmon)
    
    virtual iris_classifier_if.wmon_mp vif;
    iris_wr_agent_config w_cfg;
    uvm_analysis_port#(iris_xtn) ap_w;
    iris_xtn wrmon_txn;

    function new(string name = "iris_wrmon", uvm_component parent);
        super.new(name, parent);
        ap_w = new("ap_w", this);  
    endfunction
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db#(iris_wr_agent_config)::get(this, "", "wr_config", w_cfg)) begin
            `uvm_fatal("MONITOR", "cannot get config data")
        end
    endfunction
    
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
	    vif=w_cfg.vif;
	endfunction

    task run_phase(uvm_phase phase);
        forever begin
	    repeat(4)begin
            @(vif.wmon_cb);
	    end

            wrmon_txn = iris_xtn::type_id::create("wrmon_txn");
            wrmon_txn.petal_length_cm = vif.wmon_cb.petal_length_cm;
            wrmon_txn.sepal_width_cm = vif.wmon_cb.sepal_width_cm;
            wrmon_txn.petal_width_cm = vif.wmon_cb.petal_width_cm;
            wrmon_txn.sepal_length_cm = vif.wmon_cb.sepal_length_cm;
            wrmon_txn.rst = vif.wmon_cb.rst;
               
            wrmon_txn.print;

//            @(vif.wmon_cb);
            ap_w.write(wrmon_txn);  // Send to reference model

            // Optional: Add delay for stability
//            #1;
        end
    endtask

endclass
