class iris_driver extends uvm_driver#(iris_xtn);
    `uvm_component_utils(iris_driver)
    
    virtual iris_classifier_if.drv_mp vif;
    iris_wr_agent_config w_cfg;
    //iris_xtn dvn2dut;

    function new(string name = "iris_driver", uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db#(iris_wr_agent_config)::get(this, "", "wr_config", w_cfg)) begin
            `uvm_fatal("DRIVER", "cannot get config data")
        end
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
	    vif=w_cfg.vif;
	endfunction
	
    task run_phase(uvm_phase phase);
        @(vif.drv_cb);
	    vif.drv_cb.rst <= 1'b1;
        @(vif.drv_cb);
	    vif.drv_cb.rst <= 1'b0;
	
        forever begin
	    //req = iris_xtn::type_id::create("req");
            seq_item_port.get_next_item(req);
            drive_transaction(req);
            seq_item_port.item_done();
        end
    endtask

    task drive_transaction(iris_xtn dvn2dut);
       dvn2dut.print;
        @(vif.drv_cb);
            vif.drv_cb.petal_length_cm <= dvn2dut.petal_length_cm;
            vif.drv_cb.sepal_width_cm <= dvn2dut.sepal_width_cm;
            vif.drv_cb.petal_width_cm <= dvn2dut.petal_width_cm;
            vif.drv_cb.sepal_length_cm <= dvn2dut.sepal_length_cm;
            vif.drv_cb.rst <= dvn2dut.rst;
       
//        #1;
	@(vif.drv_cb);

    endtask
endclass
