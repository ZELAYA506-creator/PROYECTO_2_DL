`timescale 1ns/1ps

module tb_top;

  logic clk = 0;
  logic reset;
  logic [3:0] fila;
  logic [3:0] columna;
  logic tecla_soltada;
  logic [6:0] display_seg;
  logic [3:0] display_sel;

  // Instanciar el sistema completo
  fsm_control_top dut (
    .clk(clk),
    .reset(reset),
    .tecla_raw(), // no se usa directamente
    .tecla_soltada(tecla_soltada),
    .fila(fila),
    .columna(columna),
    .display_seg(display_seg),
    .display_sel(display_sel)
  );

  // Generador de reloj
  always #5 clk = ~clk;

  // Simulación
  initial begin
    $dumpfile("tb_top.vcd");
    $dumpvars(0, tb_top);

    reset = 1;
    tecla_soltada = 0;
    fila = 4'b0000;
    columna = 4'b0000;
    #20 reset = 0;

    // Número 1 = 123
    presionar_tecla(4'b0001, 4'b0010); // tecla 1
    presionar_tecla(4'b0001, 4'b0100); // tecla 2
    presionar_tecla(4'b0001, 4'b1000); // tecla 3

    // Número 2 = 456
    presionar_tecla(4'b0010, 4'b0001); // tecla 4
    presionar_tecla(4'b0010, 4'b0010); // tecla 5
    presionar_tecla(4'b0010, 4'b0100); // tecla 6

    #100;
    $display(" Fin de simulación.");
    $finish;
  end

  // Tarea para simular una tecla con fila y columna
  task presionar_tecla(input logic [3:0] f, input logic [3:0] c);
    begin
      fila = f;
      columna = c;
      tecla_soltada = 0;
      #10;
      tecla_soltada = 1;
      #10;
      tecla_soltada = 0;
      #10;
    end
  endtask

endmodule
 