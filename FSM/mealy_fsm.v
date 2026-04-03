module mealy_1001 (
    input  wire clk,
    input  wire rst,
    input  wire in,
    output reg  out
);

reg [1:0] present_state, next_state;

parameter S0 = 2'b00,
          S1 = 2'b01,
          S2 = 2'b10,
          S3 = 2'b11;

// state register
always @(posedge clk or posedge rst) begin
    if (rst)
        present_state <= S0;
    else
        present_state <= next_state;
end

// next state logic + output (Mealy)
always @(*) begin
    next_state = present_state;
    out = 0;

    case(present_state)

        S0: begin
            if(in)
                next_state = S1;
            else
                next_state = S0;
        end

        S1: begin
            if(in)
                next_state = S1;
            else
                next_state = S2;
        end

        S2: begin
            if(in)
                next_state = S1;
            else
                next_state = S3;
        end

        S3: begin
            if(in) begin
                next_state = S1;
                out = 1;        // sequence detected
            end
            else
                next_state = S0;
        end

    endcase
end

endmodule
