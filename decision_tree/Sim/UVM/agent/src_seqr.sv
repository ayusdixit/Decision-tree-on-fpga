class iris_wr_seqr extends uvm_sequencer#(iris_xtn);
    `uvm_component_utils(iris_wr_seqr)
    function new(string name = "iris_wr_seqr", uvm_component parent);
        super.new(name, parent);
    endfunction
endclass


class iris_rd_seqr extends uvm_sequencer#(smp_xtn);
    `uvm_component_utils(iris_rd_seqr)
    function new(string name = "iris_rd_seqr", uvm_component parent);
        super.new(name, parent);
    endfunction
endclass

