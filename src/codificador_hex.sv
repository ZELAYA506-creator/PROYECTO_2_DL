module codificador_hex (
    input  logic [3:0] fila,
    input  logic [3:0] columna,
    output logic [3:0] tecla_bin,
    output logic tecla_valida
);
    always_comb begin
        tecla_valida = 1;
        case ({fila, columna})
            8'b0001_0001: tecla_bin = 4'h0;
            8'b0001_0010: tecla_bin = 4'h1;
            8'b0001_0100: tecla_bin = 4'h2;
            8'b0001_1000: tecla_bin = 4'h3;
            8'b0010_0001: tecla_bin = 4'h4;
            8'b0010_0010: tecla_bin = 4'h5;
            8'b0010_0100: tecla_bin = 4'h6;
            8'b0010_1000: tecla_bin = 4'h7;
            8'b0100_0001: tecla_bin = 4'h8;
            8'b0100_0010: tecla_bin = 4'h9;
            8'b0100_0100: tecla_bin = 4'hA;
            8'b0100_1000: tecla_bin = 4'hB;
            8'b1000_0001: tecla_bin = 4'hC;
            8'b1000_0010: tecla_bin = 4'hD;
            8'b1000_0100: tecla_bin = 4'hE;
            8'b1000_1000: tecla_bin = 4'hF;
            default: begin
                tecla_bin = 4'h0;
                tecla_valida = 0;
            end
        endcase
    end
endmodule
