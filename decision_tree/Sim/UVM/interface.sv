interface iris_classifier_if(input bit clk);

    // Signals for DUT
    logic [4:0] petal_length_cm;
    logic [4:0] sepal_width_cm;
    logic [4:0] petal_width_cm;
    logic [4:0] sepal_length_cm;
    logic rst;
    logic [2:0] target;

    // Clocking block for the write monitor
    clocking wmon_cb @(posedge clk);
        default input #1 output #1;
        input petal_length_cm;
        input sepal_width_cm;
        input petal_width_cm;
        input sepal_length_cm;
        input rst;
    endclocking

    // Clocking block for the read monitor
    clocking rmon_cb @(posedge clk);
        default input #1 output #1;
        input target;
    endclocking

    // Clocking block for the driver
    clocking drv_cb @(posedge clk);
        default input #1 output #1;
        output petal_length_cm;
        output sepal_width_cm;
        output petal_width_cm;
        output sepal_length_cm;
        output rst;
    endclocking

    // Modport for the driver
    modport drv_mp (clocking drv_cb);

    // Modport for the write monitor
    modport wmon_mp (clocking wmon_cb);

    // Modport for the read monitor
    modport rmon_mp (clocking rmon_cb);

endinterface
