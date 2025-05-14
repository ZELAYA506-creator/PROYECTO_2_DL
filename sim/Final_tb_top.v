
`timescale 1ns / 1ps

// Testbench para el proyecto con Tang Nano 9K
// Simula ingreso de datos por teclado y verifica suma desplegada en displays de 7 segmentos

module tb_top;

  // Entradas
  reg clk;                  // Reloj (Pin físico 71 - IO41)
  reg rst;                  // Reset (Pin físico 70 - IO42)
  reg [3:0] fila;           // Fila del teclado (Pins físicos 63–60 - IO8–IO11)

  // Salidas
  wire [3:0] columna;       // Columnas del teclado (Pins físicos 59–56 - IO12–IO15)
  wire [6:0] segmentos;     // Segmentos a–g (Pins físicos 84–78 - IO31–IO37)
  wire [3:0] an;            // Control de dígitos del display (Pins 76–73 - IO21–IO24)

  // Instancia del diseño principal
  top DUT (
    .clk(clk),
    .rst(rst),
    .fila(fila),
    .columna(columna),
    .segmentos(segmentos),
    .an(an)
  );

  // Generador de reloj de 27 MHz (periodo ≈ 37 ns)
  always #18.5 clk = ~clk;

  initial begin
    // Inicialización
    clk = 0;
    rst = 1;
    fila = 4'b1111;

    // Ciclo de reset
    #100;
    rst = 0;

    // Simulación de ingreso de números: ejemplo "123 + 456"
    simulate_keypress(4'b1110);  // Simula tecla 0 (Fila 0 activa)
    #50000;
    simulate_keypress(4'b1101);  // Simula tecla 1 (Fila 1 activa)
    #50000;
    simulate_keypress(4'b1011);  // Simula tecla 2 (Fila 2 activa)
    #50000;

    // Simula segundo número
    simulate_keypress(4'b0111);  // Tecla 3 (Fila 3 activa)
    #50000;
    simulate_keypress(4'b1110);  // Tecla 0
    #50000;
    simulate_keypress(4'b1101);  // Tecla 1
    #50000;

    // Espera para despliegue y suma
    #200000;

    $finish;
  end

  // Tarea que simula una pulsación de tecla (columna se simula dentro del DUT)
  task simulate_keypress(input [3:0] fila_activa);
    begin
      fila = fila_activa;
      #10000;        // Duración de la pulsación
      fila = 4'b1111; // Liberación
    end
  endtask

  // Dump para GTKWave
  initial begin
    $dumpfile("tb_top.vcd");
    $dumpvars(0, tb_top);
  end

endmodule
