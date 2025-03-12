class iris_wr_seq extends uvm_sequence #(iris_xtn);

    `uvm_object_utils(iris_wr_seq)

    function new(string name="W_SEQ");
        super.new(name);
    endfunction
endclass


// Sequence class for Class 1 write transactions
class iris_wr_seq_c1 extends iris_wr_seq;
    `uvm_object_utils(iris_wr_seq_c1)

    function new(string name="W_SEQ_c1");
        super.new(name);
    endfunction
    
    task body();
	begin
        //iris_xtn xtn;
        req = iris_xtn::type_id::create("W_REQ");
    
        start_item(req);

	assert(req.randomize());

        finish_item(req);
	end	
    endtask
endclass



class iris_wr_seq_c2 extends iris_wr_seq;
    `uvm_object_utils(iris_wr_seq_c2)

    function new(string name="W_SEQ_c2");
        super.new(name);
    endfunction

    task body();
        begin
        //iris_xtn xtn;
        req = iris_xtn::type_id::create("W_REQ");

        start_item(req);

        assert(req.randomize() with {
			petal_length_cm == 7;
			sepal_width_cm >= 0 && sepal_width_cm <= 2;
			petal_width_cm >= 4 && petal_width_cm <= 6;
			sepal_length_cm == 6;
	});

        finish_item(req);
        end
    endtask
endclass



class iris_wr_seq_c3 extends iris_wr_seq;
    `uvm_object_utils(iris_wr_seq_c3)

    function new(string name="W_SEQ_c3");
        super.new(name);
    endfunction

    task body();
        begin
        //iris_xtn xtn;
        req = iris_xtn::type_id::create("dvn2dut");

        start_item(req);

        assert(req.randomize() with {
                        sepal_width_cm == 2;
        });

        finish_item(req);
        end
    endtask
endclass

