module TopModule (
    input  logic [3:0] data_in,          // entrada de datos de 4 bits para codificar
    input  logic       modo_display,     // interruptor para cambiar entre palabra y síndrome
    output logic [6:0] segmentos_hex,    // salida al display de 7 segmentos
    output logic [3:0] led_salida       // salida binaria en LEDs
);

    logic [6:0] hamming_code;
    logic [3:0] dato_corregido;
    logic [2:0] posicion_error;

    // Codificador: genera código Hamming
    CodificadorHamming encoder_inst (
        .data_in(data_in),
        .encoded_out(hamming_code)
    );

    // Decodificador: corrige los errores 
    DecodificadorHamming decoder_inst (
        .encoded_in(hamming_code),
        .data_out(dato_corregido),
        .error_pos(posicion_error)
    );

    // LEDs muestran directamente el valor corregido
    LED_Display led_bin (
        .corrected_data(dato_corregido),
        .led(led_salida) 
    );

    // Display 7 segmentos (me ayudé con tablas y después metí lógica)
    SieteSeg_Display display_hex (
        .corrected_data(dato_corregido),
        .error_position(posicion_error),
        .switch_mode(modo_display),
        .seg_out(segmentos_hex)
    );

endmodule
