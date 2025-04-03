// Módulo muestra los bits corregidos tal como vienen

module LED_Display (
    input  logic [3:0] corrected_data,
    output logic [3:0] led
);
    assign led = corrected_data;  // asignación directa
endmodule
