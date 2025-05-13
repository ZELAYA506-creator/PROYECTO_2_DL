module subsistema_suma (
    input  logic [11:0] numero1,
    input  logic [11:0] numero2,
    output logic [12:0] resultado_binario
);
    assign resultado_binario = numero1 + numero2;
endmodule

