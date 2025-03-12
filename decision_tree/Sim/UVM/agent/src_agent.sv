class iris_wr_agent extends uvm_agent;
    `uvm_component_utils(iris_wr_agent)
    
    iris_wr_seqr w_seqr;
    iris_driver w_dr;
    iris_wrmon w_mon;
    iris_wr_agent_config w_cfg;
    
    function new(string name="iris_wr_agent",uvm_component parent);
        super.new(name,parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db #(iris_wr_agent_config)::get(this,"","wr_config",w_cfg))
		  `uvm_fatal("iris_wr_agent","cannot get config data");
	       w_mon=iris_wrmon::type_id::create("W_MON",this);
	       if(w_cfg.is_active==UVM_ACTIVE)
		      begin
		          w_seqr=iris_wr_seqr::type_id::create("W_SEQR",this);
		          w_dr=iris_driver::type_id::create("W_DR",this);
		      end
    endfunction
    
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
	    w_dr.seq_item_port.connect(w_seqr.seq_item_export);
    endfunction

    task run_phase(uvm_phase phase);
        uvm_top.print_topology;
    endtask
endclass
