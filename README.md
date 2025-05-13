# **Proyecto 2 - Diseño Lógico (EL-3307)**
# **SISTEMA DE CAPTURA Y SUMA CON TECLADO HEXADECIMAL**

## **1. Introducción**

Este proyecto se basa en el diseño, desarrollo y validación de un sistema digital sincrónico utilizando SystemVerilog, cuyo propósito es capturar, procesar y mostrar la suma de dos números decimales ingresados a través de un teclado hexadecimal mecánico. La arquitectura del sistema fue estructurada de manera completamente modular, facilitando la comprensión, depuración y escalabilidad del mismo.

El sistema se implementa de forma sincrónica bajo un único reloj de 27 MHz, ideal para su despliegue en plataformas FPGA como la Tang Nano 9K. El usuario puede ingresar dos números decimales de hasta tres dígitos cada uno. Tras la captura secuencial de los datos, el sistema realiza su suma binaria sin signo, y luego despliega el resultado de forma dinámica en cuatro displays de 7 segmentos mediante multiplexación.

Todo el flujo de funcionamiento ha sido modelado en SystemVerilog y validado exhaustivamente mediante simulaciones funcionales con herramientas como Icarus Verilog y GTKWave, asegurando la correcta transición entre estados, la confiabilidad de los datos ingresados y la claridad del resultado mostrado.


## **2. Definición del problema y objetivos**

El problema propuesto surge a partir de la necesidad de diseñar una solución digital confiable y eficiente que permita al usuario ingresar dos números decimales utilizando un teclado hexadecimal tipo matriz (4x4). El desafío principal radica en gestionar la entrada de datos mecánicos, los cuales pueden estar sujetos a ruido (rebote), y en procesar correctamente la información capturada en un entorno sincrónico controlado por un único reloj.

Al finalizar este sistema debe ser capaz de:
- Eliminar rebotes mecánicos mediante un mecanismo de debounce digital.
- Capturar secuencialmente los dígitos de cada número, diferenciando entre el primer y segundo número mediante lógica de control.
- Realizar una suma aritmética binaria sin signo entre los dos números ingresados.
- Convertir el resultado binario en formato BCD para permitir su visualización amigable.
- Multiplexar la salida a cuatro displays de 7 segmentos de forma clara y sin parpadeo.
- Sincronizar correctamente todos los bloques funcionales bajo una sola fuente de reloj (27 MHz).

### **Objetivos específicos:**
- Diseñar FSMs robustas para la captura ordenada de dígitos y el control global del sistema.
- Modularizar cada subsistema para facilitar simulaciones, pruebas unitarias e implementación física.
- Usar lógica combinacional eficiente para minimizar el uso de recursos en FPGA.
- Garantizar una interfaz amigable entre el teclado y el usuario mediante respuesta visual directa (displays).
- Verificar todo el comportamiento funcional con testbenches exhaustivos en GTKWave.

Como se observa, este proyecto no solo busca una solución funcional, sino también una implementación didáctica y profesional que pueda ser reproducida y mejorada en entornos académicos, con la finalidad de dar solución al problema planteado.


