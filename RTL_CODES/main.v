 module data_driven_new (
    input clk,
    input rst,
    input [31:0] D,
    output reg [31:0] Q,
    output clk_g
);

    reg [31:0] D_prev;
    wire enable;

    // Probability-based switching detection
    assign enable = |(D ^ D_prev); // if any bit changes

    // Clock gating
    assign clk_g = clk & enable;

    // Store previous data
    always @(posedge clk or posedge rst) begin
        if (rst)
            D_prev <= 32'b0;
        else
            D_prev <= D;
    end

    // Multi-bit flip-flop (MBFF)
    always @(posedge clk_g or posedge rst) begin
        if (rst)
            Q <= 32'b0;
        else
            Q <= D;
    end

endmodule
