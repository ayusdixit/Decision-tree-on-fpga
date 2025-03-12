class iris_rd_mon extends uvm_monitor;
    `uvm_component_utils(iris_rd_mon)
    
    virtual iris_classifier_if.rmon_mp vif;
    iris_rd_agent_config r_cfg;
    uvm_analysis_port#(smp_xtn) ap_r;
    smp_xtn rdmon_txn;

    function new(string name = "iris_rmon", uvm_component parent);
        super.new(name, parent);
        ap_r = new("ap_r", this);  
    endfunction
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db#(iris_rd_agent_config)::get(this, "", "rd_config", r_cfg)) begin
            `uvm_fatal("READ_MONITOR", "cannot get config data")
//            $display("%p",r_cfg);
        end
    endfunction
    
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
	    vif=r_cfg.vif;
	endfunction

    task run_phase(uvm_phase phase);
        forever begin
	   repeat(4)begin
           @(vif.rmon_cb);
	   end
//           @(vif.rmon_cb);
            rdmon_txn = smp_xtn::type_id::create("rdmon_txn");
            rdmon_txn.target = vif.rmon_cb.target;
            
            rdmon_txn.print;
//	    @(vif.rmon_cb);
            ap_r.write(rdmon_txn);

            // Optional: Add delay for stability
//            #1;
        end
    endtask

endclass
