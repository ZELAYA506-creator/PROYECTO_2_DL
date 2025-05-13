module registro_num (
    input  logic clk,
    input  logic reset,
    input  logic capturar,
    input  logic clear,
    input  logic [3:0] digito_in,
    output logic [11:0] numero_out  // 3 dígitos de 4 bits cada uno
);
    logic [3:0] d0, d1, d2;

    always_ff @(posedge clk or posedge reset) begin
        if (reset || clear) begin
            d0 <= 0;
            d1 <= 0;
            d2 <= 0;
        end else if (capturar) begin
            d2 <= d1;
            d1 <= d0;
            d0 <= digito_in;
        end
    end

    assign numero_out = {d2, d1, d0};  // Concatenación: MSD a LSD
endmodule

