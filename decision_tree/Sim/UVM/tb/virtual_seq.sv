class iris_virtual_sequence extends uvm_sequence #(uvm_sequence_item);
    `uvm_object_utils(iris_virtual_sequence)

    iris_virtual_sequencer v_seqr;
    iris_wr_seqr w_seqr;  
    iris_rd_seqr r_seqr;  
    iris_env_config cfg;

    function new(string name="V_SEQ");
        super.new(name);
    endfunction
    
    task body;
        if (!uvm_config_db#(iris_env_config)::get(null, get_full_name(), "env_config", cfg))
            `uvm_fatal("V_SEQ", "Cannot get config data");

        $cast(v_seqr, m_sequencer);
        w_seqr = v_seqr.w_seqr;
        r_seqr = v_seqr.r_seqr;
    endtask
endclass


class iris_virtual_sequence_c1 extends iris_virtual_sequence;
    `uvm_object_utils(iris_virtual_sequence_c1)

    iris_wr_seq_c1 w_seq1;
//    iris_rd_seq_c1 r_seq1; 

    function new(string name="V_SEQ_c1");
        super.new(name);
    endfunction
    
    task body;
        super.body;
        w_seq1 = iris_wr_seq_c1::type_id::create("W_SEQ1");
//        r_seq1 = iris_rd_seq_c1::type_id::create("R_SEQ1");

//        fork
//            begin
                w_seq1.start(w_seqr);  
//            end

//            begin
//                r_seq1.start(r_seqr); 
//            end
//        join
    endtask
endclass


class iris_virtual_sequence_c2 extends iris_virtual_sequence;
    `uvm_object_utils(iris_virtual_sequence_c2)

    iris_wr_seq_c2 w_seq2;
//    iris_rd_seq_c2 r_seq2;

    function new(string name="V_SEQ_c2");
        super.new(name);
    endfunction

    task body;
        super.body;
        w_seq2 = iris_wr_seq_c2::type_id::create("W_SEQ2");
        w_seq2.start(w_seqr);
    endtask
endclass


class iris_virtual_sequence_c3 extends iris_virtual_sequence;
    `uvm_object_utils(iris_virtual_sequence_c3)

    iris_wr_seq_c3 w_seq3;
//    iris_rd_seq_c3 r_seq3;

    function new(string name="V_SEQ_c3");
        super.new(name);
    endfunction

    task body;
        super.body;
        w_seq3 = iris_wr_seq_c3::type_id::create("W_SEQ3");
        w_seq3.start(w_seqr);
    endtask
endclass

