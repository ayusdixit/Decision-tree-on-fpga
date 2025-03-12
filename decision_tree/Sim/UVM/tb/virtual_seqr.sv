class iris_virtual_sequencer extends uvm_sequencer #(uvm_sequence_item);
    `uvm_component_utils(iris_virtual_sequencer)

    iris_wr_seqr w_seqr;  
    iris_rd_seqr r_seqr;  
    iris_env_config cfg;

    function new(string name="V_SEQR", uvm_component parent);
        super.new(name, parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db #(iris_env_config)::get(this, "", "env_config", cfg))
            `uvm_fatal("VIRTUAL_SEQUENCER", "Cannot get config data");
        
//        w_seqr = iris_wr_seqr::type_id::create("W_SEQR", this);
//        r_seqr = iris_rd_seqr::type_id::create("R_SEQR", this);


    endfunction   

endclass

