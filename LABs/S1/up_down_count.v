module up_down_counter#(
    parameter WIDTH = 4                     // bit-width
)(
    input wire clk,                         // +ve edge triggered clk signal
    input wire rst_n,                       // -ve edge Asynch rst signal
    input wire load,                        // synch load enable
    input wire dir,                         // 1: up-counting. 0: down-counting
    input wire [WIDTH-1 : 0] din,           // data to be loaded (counter configuration)
    output reg [WIDTH-1 : 0] count          // counter output
);
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            count <= {WIDTH{1'b0}};         // Default Value
        end else if(load) begin
            count <= din;                   // counter configuration
        end else if(dir) begin              // up-counting
            count <= count + 1;             // increment the counter
        end else begin                      // down-counting
            count <= count - 1;             // decrement the counter
        end
    end
endmodule