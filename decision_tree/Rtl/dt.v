`timescale 1ns/1ps
/*

accuracy software = 96.66 percentage 

 

*/
module iris_classifier(
    input [4:0] petal_length_cm,
    input [4:0] sepal_width_cm,
    input [4:0] petal_width_cm,
    input [4:0] sepal_length_cm,
    input clk,
    input reset,
    output reg [2:0] target
);

always @(posedge clk) begin
    if (reset) begin
        target <= 3'b000; // Reset target
    end else begin
        // Decision tree traversal
        if (petal_width_cm <= 3) begin
            target <= 3'b001; // Class 1
        end else begin
            if (petal_width_cm <= 6) begin
                if (petal_length_cm <= 6) begin
                    target <= 3'b010; // Class 2
                end else begin
                    if (petal_length_cm <= 7) begin
                        if (sepal_width_cm <= 1) begin
                            target <= 3'b011; // Class 3
                        end else begin
                            if (sepal_length_cm <= 5) begin
                                target <= 3'b010; // Class 2
                            end else begin
                                if (sepal_length_cm <= 6) begin
                                    if (sepal_width_cm <= 2) begin
                                        target <= 3'b010; // Class 2
                                    end else begin
                                        target <= 3'b011; // Class 3
                                    end
                                end else begin
                                    target <= 3'b010; // Class 2
                                end
                            end
                        end
                    end else begin
                        target <= 3'b011; // Class 3
                    end
                end
            end else begin
                if (petal_length_cm <= 6) begin
                    if (sepal_width_cm <= 4) begin
                        target <= 3'b011; // Class 3
                    end else begin
                        target <= 3'b010; // Class 2
                    end
                end else begin
                    target <= 3'b011; // Class 3
                end
            end
        end
    end
end

endmodule
