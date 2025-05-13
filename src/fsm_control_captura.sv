module fsm_control_top (
    input  logic clk,
    input  logic reset,
    input  logic [3:0] tecla_raw,
    input  logic tecla_soltada,
    input  logic [3:0] fila,
    input  logic [3:0] columna,
    output logic [6:0] display_seg,
    output logic [3:0] display_sel
);
    // Internos
    logic [3:0] tecla_bin;
    logic tecla_valida;
    logic capturar;
    logic num1_activo;
    logic listo;
    logic [11:0] num1, num2;
    logic [12:0] resultado_bin;

    // Codificador fila/columna a tecla binaria
    codificador_hex codif (
        .fila(fila),
        .columna(columna),
        .tecla_bin(tecla_bin),
        .tecla_valida(tecla_valida)
    );

    // Subsistema de lectura
    subsistema_lectura_teclado lectura (
        .clk(clk),
        .reset(reset),
        .tecla_raw(tecla_bin),
        .tecla_soltada(tecla_soltada),
        .tecla_out(), // opcional
        .capturar(capturar),
        .num1_activo(num1_activo),
        .listo(listo)
    );

    // Registro de número 1
    registro_num reg1 (
        .clk(clk),
        .reset(reset),
        .capturar(capturar && num1_activo && tecla_bin <= 4'd9),
        .clear(0),
        .digito_in(tecla_bin),
        .numero_out(num1)
    );

    // Registro de número 2
    registro_num reg2 (
        .clk(clk),
        .reset(reset),
        .capturar(capturar && !num1_activo && tecla_bin <= 4'd9),
        .clear(0),
        .digito_in(tecla_bin),
        .numero_out(num2)
    );

    // Sumador
    subsistema_suma suma_unit (
        .numero1(num1),
        .numero2(num2),
        .resultado_binario(resultado_bin)
    );

    // Display 7 segmentos
    subsistema_display display (
        .clk(clk),
        .reset(reset),
        .resultado_binario(resultado_bin),
        .display_seg(display_seg),
        .display_sel(display_sel)
    );
endmodule
