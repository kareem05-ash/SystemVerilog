module up_down_count_tb;
    // Local Parameters
        localparam clk_period = 20;
    // DUT Parameters
        parameter WIDTH = 4;                    // bit-width
    // DUT Inputs
        logic clk;                              // +ve edge triggered clk signal
        logic rst_n;                            // -ve edge Asynch rst signal
        logic load;                             // synch load enable
        logic dir;                              // 1: up-counting. 0: down-counting
        logic [WIDTH-1 : 0] din;                // data to be loaded (counter configuration)
    // DUT Outputs
        logic [WIDTH-1 : 0] count;              // counter output
    // Needed Signals
        logic [WIDTH-1 : 0] count_exp;          // expected counter value from golden model
        int passed_count;                       // passed assertions counter
        int failed_count;                       // failed assertions counter
    // DUT Instantiation
        up_down_counter #(
            .WIDTH(WIDTH)
        ) DUT(
            .clk(clk),
            .rst_n(rst_n),
            .load(load),
            .dir(dir),
            .din(din),
            .count(count)
        );
    // Clk Generation
        initial begin 
            clk = 0;                            // initially, clk = 0
            forever #(clk_period/2) clk = ~clk; // toggle clk signal
        end
    // Tasks
        // reset Task
            task reset(); begin 
                rst_n = 0;                      // activate rst_n
                load = 0;                       // disable loading operation
                dir = 1;                        // default value: up-counting
                din = {WIDTH{1'b0}};            // default value: zero
                count_exp = {WIDTH{1'b0}};      // reset golden model counter
                // @(negedge clk);                 // watis for 1.5 clk periods
                // rst_n = 1;                      // release rst_n
            end
            endtask
        // golden_model task
            task golden_model; begin 
                if(!rst_n)      count_exp = {WIDTH{1'b0}};
                else if(load)   count_exp = din;
                else if(dir)    count_exp = count_exp + 1;
                else            count_exp = count_exp - 1;
            end
            endtask
        // score_board task
            task score_board; begin 
                if(count == count_exp) begin 
                    $display("PASS | count = %d, expected = %d", count, count_exp);
                    passed_count = passed_count + 1;
                end else begin 
                    $display("FAIL | count = %d, expected = %d", count, count_exp);
                    failed_count = failed_count + 1;
                end
            end
            endtask
        // report Task
            task report; begin 
                $display("-------------------- Results Report --------------------");
                $display("Total Checks      : %d", passed_count + failed_count);
                $display("PASSed Checks     : %d", passed_count);
                $display("FAILed Checks     : %d", failed_count);
            end 
            endtask
    // Stimulus
        initial begin 
            // 1st Scenario: Functional Correctness (RESET Behavior)
                $display("========== 1st Scenario: Functional Correctness (RESET Behavior) ==========");
                reset;
                @(negedge clk);
                golden_model;
                score_board;
            // 2nd Scenario: Functional Correctness (Basic Up-Counting)
                $display("========== 2nd Scenario: Functional Correctness (Basic Up-Counting) ==========");
                rst_n = 1;      // release rst
                repeat(100) begin 
                    @(negedge clk);
                    golden_model;
                    score_board;
                end
            // 3rd Scenario: Functional Correctness (Basic Down-Counting)
                $display("========== 3rd Scenario: Functional Correctness (Basic Down-Counting) ==========");
                rst_n = 1;      // release rst
                dir = 0;        // enable down-counting
                repeat(100) begin 
                    @(negedge clk);
                    golden_model;
                    score_board;
                end
            // 4th Scenario: Functional Correcness (Counter Cofiguration using load signal)
                $display("========== 2nd Scenario: Functional Correctness (Basic Up-Counting) ==========");
                rst_n = 1;      // release rst
                load = 1;       // enable configuration
                repeat(20) begin 
                    din = $random;      // generate random data input
                    @(negedge clk);
                    golden_model;
                    score_board;
                end
            // STOP Simulation
                #100;
                report;
                $stop;
        end
endmodule