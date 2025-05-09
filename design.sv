module sequence_generator (
    input clk,
    input rst,
    output reg [3:0] out
);

    // State encoding
    typedef enum logic [2:0] {
        S0 = 3'b000,  // Output 1
        S1 = 3'b001,  // Output 2
        S2 = 3'b010,  // Output 3
        S3 = 3'b011,  // Output 6
        S4 = 3'b100   // Output 4
    } state_t;

    state_t current_state, next_state;

    // State register (D Flip-Flop behavior)
    always @(posedge clk or posedge rst) begin
        if (rst)
            current_state <= S0;
        else
            current_state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            S0: next_state = S1;
            S1: next_state = S2;
            S2: next_state = S3;
            S3: next_state = S4;
            S4: next_state = S0;
            default: next_state = S0;
        endcase
    end

    // Output logic (Moore Machine)
    always @(*) begin
        case (current_state)
            S0: out = 4'd1;
            S1: out = 4'd2;
            S2: out = 4'd3;
            S3: out = 4'd6;
            S4: out = 4'd4;
            default: out = 4'd0;
        endcase
    end

endmodule
