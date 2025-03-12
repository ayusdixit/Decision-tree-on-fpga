class iris_wr_agent_config extends uvm_object;
    `uvm_object_utils(iris_wr_agent_config)

    virtual iris_classifier_if vif;
    uvm_active_passive_enum is_active = UVM_ACTIVE;

    function new(string name = "iris_wr_agent_config");
        super.new(name);
    endfunction

endclass


class iris_rd_agent_config extends uvm_object;
    `uvm_object_utils(iris_rd_agent_config)

    virtual iris_classifier_if vif;
    uvm_active_passive_enum is_active = UVM_PASSIVE;

    function new(string name = "iris_rd_agent_config");
        super.new(name);
    endfunction

endclass


class iris_env_config extends uvm_object;
    `uvm_object_utils(iris_env_config)

    int no_of_sources;        
    int no_of_clients;        
    int has_scoreboard;       
    int has_virtual_sequencer; 

    iris_wr_agent_config w_cfg;  
    iris_rd_agent_config r_cfg; 

    function new(string name="ENV_CONFIG");
        super.new(name);
    endfunction

endclass
