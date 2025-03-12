class iris_env extends uvm_env;
    `uvm_component_utils(iris_env)

    iris_env_config cfg;
    iris_scoreboard sb;
    iris_virtual_sequencer v_seqr;
    iris_agt_top agt_top; 
    reference_model ref_model; 

    function new(string name="ENV", uvm_component parent);
        super.new(name, parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db #(iris_env_config)::get(this, "", "env_config", cfg))
            `uvm_fatal("Environment", "cannot get config data");

        if (cfg.has_scoreboard)
            sb = iris_scoreboard::type_id::create("SB", this);

        if (cfg.has_virtual_sequencer)
            v_seqr = iris_virtual_sequencer::type_id::create("V_SEQR", this);

        agt_top = iris_agt_top::type_id::create("AGT_T", this);
	ref_model = reference_model::type_id::create("ref_model", this);
    endfunction
    
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);

        if (cfg.has_virtual_sequencer) begin
            v_seqr.w_seqr = agt_top.w_ag.w_seqr;  
            v_seqr.r_seqr = agt_top.r_ag.r_seqr;  
        end

        if (cfg.has_scoreboard) begin
	    
	    ref_model.target_ap.connect(sb.ref_model_ap.analysis_export);  // Reference model -> scoreboard
            agt_top.r_ag.r_mon.ap_r.connect(sb.rd_mon_ap.analysis_export);  // Read monitor -> scoreboard
            agt_top.w_ag.w_mon.ap_w.connect(ref_model.mon_imp);	// Write monitor -> reference model
        end
    endfunction
endclass
