module SieteSeg_Display (
    input  logic [3:0] corrected_data,
    input  logic [2:0] error_position,
    input  logic       switch_mode,
    output logic [6:0] seg_out
);
    logic [3:0] value;

    always_comb begin
        value = switch_mode ? {1'b0, error_position} : corrected_data;
        case (value)
            4'h0: seg_out = 7'b1000000;
            4'h1: seg_out = 7'b1111001;
            4'h2: seg_out = 7'b0100100;
            4'h3: seg_out = 7'b0110000;
            4'h4: seg_out = 7'b0011001;
            4'h5: seg_out = 7'b0010010;
            4'h6: seg_out = 7'b0000010;
            4'h7: seg_out = 7'b1111000;
            4'h8: seg_out = 7'b0000000;
            4'h9: seg_out = 7'b0010000;
            4'hA: seg_out = 7'b0001000;
            4'hB: seg_out = 7'b0000011;
            4'hC: seg_out = 7'b1000110;
            4'hD: seg_out = 7'b0100001;
            4'hE: seg_out = 7'b0000110;
            4'hF: seg_out = 7'b0001110;
            default: seg_out = 7'b1111111;
        endcase
    end
endmodule
