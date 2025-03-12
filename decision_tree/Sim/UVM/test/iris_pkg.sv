package iris_pkg;

    import uvm_pkg::*;
    `include "uvm_macros.svh"
	
    `include "transaction.sv"
    `include "config.sv"
	
    `include "src_driver.sv"
    `include "src_mon.sv"
    `include "src_seqr.sv"
    `include "drv_agent.sv"
    `include "src_seq.sv"

    `include "dst_mon.sv"
    `include "smp_agent.sv"

    `include "virtual_seqr.sv"
    `include "virtual_seq.sv"
    `include "scoreboard.sv"
	
    `include "agent_top.sv"
    `include "env.sv"

    `include "test.sv"
endpackage
