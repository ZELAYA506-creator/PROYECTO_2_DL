module display_mux (
    input  logic clk,
    input  logic reset,
    input  logic [3:0] bcd0, bcd1, bcd2, bcd3,
    output logic [6:0] seg,
    output logic [3:0] sel
);
    logic [1:0] count;
    logic [3:0] current_bcd;

    // Contador para selección de display activo (2 bits)
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            count <= 0;
        else
            count <= count + 1;
    end

    // Selección del dígito actual según count
    always_comb begin
        case (count)
            2'd0: begin sel = 4'b1110; current_bcd = bcd0; end
            2'd1: begin sel = 4'b1101; current_bcd = bcd1; end
            2'd2: begin sel = 4'b1011; current_bcd = bcd2; end
            2'd3: begin sel = 4'b0111; current_bcd = bcd3; end
        endcase
    end

    // Decodificación BCD → 7 segmentos
    decoder_bcd_7seg dec (
        .bcd(current_bcd),
        .seg(seg)
    );

endmodule
