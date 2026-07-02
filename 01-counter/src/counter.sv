/**
 * updown_counter:
 * A simple up/down counter with load functionality.
 *
 * Features:
 * - 4-bit counter
 * - Asynchronous active-low reset
 * - Load functionality: on load signal, the counter loads the input value
 * - Up/Down counting: controlled by the up_down signal
 *      1 = count up
 *      0 = count down
 * - Enable signal:
 *      1 = counter counts
 *      0 = counter holds its value
 */
module updown_counter(
    input  logic       clk,        // Clock input
    input  logic       rst_n,      // Active-low reset
    input  logic       load,       // Load enable
    input  logic       up_down,    // Direction control (1 = up, 0 = down)
    input  logic       enable,     // Counter enable
    input  logic [3:0] d_in,       // Input data for loading
    output logic [3:0] count       // Counter output
);

    // Sequential logic
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            count <= 4'b0000;
        else if (load)
            count <= d_in;
        else if (enable) begin
            if (up_down)
                count <= count + 4'd1;
            else
                count <= count - 4'd1;
        end
        else
            count <= count;   // Hold current value
    end

endmodule
