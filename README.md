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

## **3. Descripción general del funcionamiento del sistema**

El sistema completo se estructura en tres bloques funcionales principales, que trabajan de forma coordinada y sincronizada para cumplir con la tarea de captura, procesamiento y despliegue del resultado de una suma aritmética. Cada bloque está encapsulado en un subsistema independiente que interactúa con los demás a través de señales de control y datos.

### ** a. Subsistema de captura de datos**
Este módulo se encarga de recibir las entradas del teclado hexadecimal tipo matriz 4x4. Está compuesto por los siguientes elementos: 

- Un **debouncer** que elimina posibles rebotes mecánicos al presionar las teclas.  
- Un **codificador de fila y columna**, que traduce la posición física presionada del teclado en un valor binario de 4 bits (hexadecimal).
- Una **FSM de captura** (`fsm_captura`) que organiza la secuencia de ingreso y define cuándo capturar el valor, si pertenece al primer número (`num1`) o al segundo (`num2`).
- Un **contador** que verifica cuántos dígitos han sido ingresados (3 por número).
- Dos **registros de almacenamiento**, cada uno de 12 bits, que guardan tres dígitos en formato BCD (4 bits por dígito).

### ** b. Subsistema de suma aritmética**
Cuando se han capturado ambos números, este bloque realiza la suma binaria sin signo.

### ** c. Subsistema de despliegue en displays**
Muestra el resultado final de la suma en cuatro dígitos a través de los siguientes componentes:
- **Conversión binaria a BCD** Utiliza el algoritmo “double dabble” para convertir el número binario de 13 bits a 4 dígitos BCD.
- **Decodificador BCD a 7 segmentos** Convierte cada dígito BCD a la salida correspondiente en segmentos a–g.
- **Multiplexado de displays** Activa cada uno de los 4 dígitos de forma cíclica usando un contador.
Este subsistema garantiza una visualización continua, estable y sin parpadeos visibles.









