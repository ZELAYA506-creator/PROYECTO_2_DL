module DecodificadorHamming (
    input  logic [6:0] encoded_in,
    output logic [3:0] data_out,
    output logic [2:0] error_pos
);
    logic [6:0] corrected;
    logic [2:0] bit_error;

    always_comb begin
        bit_error[0] = encoded_in[0] ^ encoded_in[2] ^ encoded_in[4] ^ encoded_in[6];
        bit_error[1] = encoded_in[1] ^ encoded_in[2] ^ encoded_in[5] ^ encoded_in[6];
        bit_error[2] = encoded_in[3] ^ encoded_in[4] ^ encoded_in[5] ^ encoded_in[6];

        error_pos = bit_error;
        corrected = encoded_in;

        if (bit_error != 3'b000)
            corrected[bit_error] = ~encoded_in[bit_error];

        data_out[0] = corrected[2];
        data_out[1] = corrected[4];
        data_out[2] = corrected[5];
        data_out[3] = corrected[6];
    end
endmodule
