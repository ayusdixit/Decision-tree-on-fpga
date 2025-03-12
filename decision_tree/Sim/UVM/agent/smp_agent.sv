class iris_rd_agent extends uvm_agent;
    `uvm_component_utils(iris_rd_agent)
    
    iris_rd_seqr r_seqr;
//    iris_rd_dr r_dr;
    iris_rd_mon r_mon;
    iris_rd_agent_config r_cfg;
    
    function new(string name="iris_rd_agent",uvm_component parent);
    	super.new(name,parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
    	super.build_phase(phase);
        if(!uvm_config_db #(iris_rd_agent_config)::get(this,"","rd_config",r_cfg))
		  `uvm_fatal("R_AGENT","cannot get config data");
           r_mon=iris_rd_mon::type_id::create("R_MON",this);
	       if(r_cfg.is_active==UVM_ACTIVE)
		      begin
		          r_seqr=iris_rd_seqr::type_id::create("R_SEQR",this);
//		          r_dr=iris_rd_dr::type_id::create("R_DR",this);
		      end
    endfunction

    function void connect_phase(uvm_phase phase);
    	super.connect_phase(phase);
//	    r_dr.seq_item_port.connect(r_seqr.seq_item_export);
     endfunction

endclass
