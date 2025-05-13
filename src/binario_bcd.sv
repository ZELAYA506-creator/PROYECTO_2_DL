module bin_to_bcd (
    input  logic [12:0] bin,
    output logic [3:0] bcd0, bcd1, bcd2, bcd3
);
    logic [27:0] shift_reg;
    integer i;

    always_comb begin
        shift_reg = 28'd0;
        shift_reg[12:0] = bin;

        for (i = 0; i < 13; i = i + 1) begin
            if (shift_reg[15:12] >= 5) shift_reg[15:12] += 3;
            if (shift_reg[19:16] >= 5) shift_reg[19:16] += 3;
            if (shift_reg[23:20] >= 5) shift_reg[23:20] += 3;
            if (shift_reg[27:24] >= 5) shift_reg[27:24] += 3;
            shift_reg = shift_reg << 1;
        end

        bcd3 = shift_reg[27:24];
        bcd2 = shift_reg[23:20];
        bcd1 = shift_reg[19:16];
        bcd0 = shift_reg[15:12];
    end
endmodule

