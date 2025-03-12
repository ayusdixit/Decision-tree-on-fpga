class iris_agt_top extends uvm_env;
    `uvm_component_utils(iris_agt_top)

    iris_env_config cfg;
    iris_wr_agent_config w_cfg;
    iris_rd_agent_config r_cfg;

    iris_wr_agent w_ag;
    iris_rd_agent r_ag;

    function new(string name="AGT_T", uvm_component parent);
        super.new(name, parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db #(iris_env_config)::get(this, "", "env_config", cfg))
            `uvm_fatal("AGT_TOP", "Cannot get config data");

        w_cfg = cfg.w_cfg;
        r_cfg = cfg.r_cfg;

        uvm_config_db#(iris_wr_agent_config)::set(this, "W_AGENT*", "wr_config", w_cfg);
	w_ag = iris_wr_agent::type_id::create("W_AGENT", this);
      
        uvm_config_db#(iris_rd_agent_config)::set(this, "R_AGENT*", "rd_config", r_cfg);
	r_ag = iris_rd_agent::type_id::create("R_AGENT", this);
    endfunction
endclass

