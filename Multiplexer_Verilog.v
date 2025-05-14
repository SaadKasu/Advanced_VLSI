module mux_2_1_bcase(
input dIN1, dIN2, ch,
output reg dOUT
);

always @(*) begin
    case(ch)
        1'b0: 
            dOUT= dIN1;
        1'b1: 
            dOUT = dIN2;
    endcase
end
