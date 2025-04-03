module CodificadorHamming (
    input  logic [3:0] data_in,
    output logic [6:0] encoded_out
);
    always_comb begin
        encoded_out[2] = data_in[0];
        encoded_out[4] = data_in[1];
        encoded_out[5] = data_in[2];
        encoded_out[6] = data_in[3];

        encoded_out[0] = data_in[0] ^ data_in[1] ^ data_in[3];
        encoded_out[1] = data_in[0] ^ data_in[2] ^ data_in[3];
        encoded_out[3] = data_in[1] ^ data_in[2] ^ data_in[3];
    end
endmodulea
