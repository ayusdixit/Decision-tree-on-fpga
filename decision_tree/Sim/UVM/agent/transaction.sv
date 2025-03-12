class iris_xtn extends uvm_sequence_item;
    `uvm_object_utils(iris_xtn)

    rand bit [4:0] petal_length_cm;  
    rand bit [4:0] sepal_width_cm;   
    rand bit [4:0] petal_width_cm;   
    rand bit [4:0] sepal_length_cm;             
    
    bit rst;

    constraint pt_lth{petal_length_cm <= 5'd7;};
    constraint sp_wth{sepal_width_cm <= 5'd4;};
    constraint pt_wth{petal_width_cm <= 5'd6;};
    constraint sp_lth{sepal_length_cm <= 5'd6;};
 

    function new(string name = "iris_xtn");
        super.new(name);
    endfunction

    function void do_copy(uvm_object rhs);
        iris_xtn rhs_;

        if(!$cast(rhs_, rhs)) begin
            `uvm_fatal("do_copy", "Cast of the rhs object failed")
        end

        super.do_copy(rhs);
        petal_length_cm = rhs_.petal_length_cm;
        sepal_width_cm = rhs_.sepal_width_cm;
        petal_width_cm = rhs_.petal_width_cm;
        sepal_length_cm = rhs_.sepal_length_cm;
	rst=rhs_.rst;
    endfunction

    function bit do_compare(uvm_object rhs, uvm_comparer comparer);
        iris_xtn rhs_;

        if(!$cast(rhs_, rhs)) begin
            `uvm_fatal("do_compare", "Cast of the rhs object failed")
            return 0;
        end

        return super.do_compare(rhs, comparer) &&
               petal_length_cm == rhs_.petal_length_cm &&
               sepal_width_cm == rhs_.sepal_width_cm &&
               petal_width_cm == rhs_.petal_width_cm &&
               sepal_length_cm == rhs_.sepal_length_cm&&
	       rst==rhs_.rst;
    endfunction

    function void do_print(uvm_printer printer);
        printer.print_field("petal_length_cm", this.petal_length_cm, 5, UVM_DEC);
        printer.print_field("sepal_width_cm", this.sepal_width_cm, 5, UVM_DEC);
        printer.print_field("petal_width_cm", this.petal_width_cm, 5, UVM_DEC);
        printer.print_field("sepal_length_cm", this.sepal_length_cm, 5, UVM_DEC);
	printer.print_field("reset", this.rst, 1, UVM_BIN);

    endfunction
endclass


class smp_xtn extends uvm_sequence_item;
    `uvm_object_utils(smp_xtn)

    bit [2:0] target;

    function new(string name="smp_xtn");
        super.new(name);
    endfunction

    // Custom print function to display values
    function void do_print(uvm_printer printer);
        super.do_print(printer);

        printer.print_field("target", this.target, 3, UVM_DEC);

    endfunction

endclass

