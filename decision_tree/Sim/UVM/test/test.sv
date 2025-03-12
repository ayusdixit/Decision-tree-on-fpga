class iris_test extends uvm_test;
    `uvm_component_utils(iris_test)
    
    iris_env_config cfg;
    iris_wr_agent_config w_cfg;  
    iris_rd_agent_config r_cfg;  
    int has_scoreboard = 1;
    int has_virtual_sequencer = 1;
    iris_env envh;

    function new(string name="TEST", uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        w_cfg = iris_wr_agent_config::type_id::create("WR_AGENT_CONFIG");
        r_cfg = iris_rd_agent_config::type_id::create("RD_AGENT_CONFIG");
        cfg = iris_env_config::type_id::create("ENV_CONFIG");

        if (!uvm_config_db #(virtual iris_classifier_if)::get(this, "", "vif0", w_cfg.vif))
            `uvm_fatal("TEST", "cannot get write config data");
        w_cfg.is_active = UVM_ACTIVE;
        cfg.w_cfg = w_cfg;  
        
        if (!uvm_config_db #(virtual iris_classifier_if)::get(this, "", "vif1", r_cfg.vif))
            `uvm_fatal("TEST", "cannot get read config data");
        r_cfg.is_active = UVM_PASSIVE;
        cfg.r_cfg = r_cfg;  
        
        cfg.no_of_sources = 1;  
        cfg.no_of_clients = 1;  
        cfg.has_scoreboard = has_scoreboard;
        cfg.has_virtual_sequencer = has_virtual_sequencer;

        uvm_config_db#(iris_env_config) ::set(this, "*", "env_config", cfg);

        envh = iris_env::type_id::create("ENV", this);

        super.build_phase(phase);
    endfunction

endclass


class iris_test_c1 extends iris_test;
    `uvm_component_utils(iris_test_c1)
    iris_virtual_sequence_c1 v_seq1;

    function new(string name="TEST-1",uvm_component parent);
    	super.new(name,parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
    	super.build_phase(phase);
    endfunction		
    
    task run_phase(uvm_phase phase);
    	v_seq1=iris_virtual_sequence_c1::type_id::create("V_SEQ1");
	    phase.raise_objection(this);
	    v_seq1.start(envh.v_seqr);
	    phase.drop_objection(this);
    endtask

endclass


class iris_test_c2 extends iris_test;
    `uvm_component_utils(iris_test_c2)
    iris_virtual_sequence_c2 v_seq2;

    function new(string name="TEST-2",uvm_component parent);
        super.new(name,parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
    endfunction

    task run_phase(uvm_phase phase);
        v_seq2=iris_virtual_sequence_c2::type_id::create("V_SEQ2");
            phase.raise_objection(this);
            v_seq2.start(envh.v_seqr);
            phase.drop_objection(this);
    endtask

endclass


class iris_test_c3 extends iris_test;
    `uvm_component_utils(iris_test_c3)
    iris_virtual_sequence_c3 v_seq3;

    function new(string name="TEST-3",uvm_component parent);
        super.new(name,parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
    endfunction

    task run_phase(uvm_phase phase);
        v_seq3=iris_virtual_sequence_c3::type_id::create("V_SEQ3");
            phase.raise_objection(this);
            v_seq3.start(envh.v_seqr);
            phase.drop_objection(this);
    endtask

endclass

