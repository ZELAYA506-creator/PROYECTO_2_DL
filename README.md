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

### **a. Subsistema de captura de datos**
Este módulo se encarga de recibir las entradas del teclado hexadecimal tipo matriz 4x4. Está compuesto por los siguientes elementos: 

- Un **debouncer** que elimina posibles rebotes mecánicos al presionar las teclas.  
- Un **codificador de fila y columna**, que traduce la posición física presionada del teclado en un valor binario de 4 bits (hexadecimal).
- Una **FSM de captura** (`fsm_captura`) que organiza la secuencia de ingreso y define cuándo capturar el valor, si pertenece al primer número (`num1`) o al segundo (`num2`).
- Un **contador** que verifica cuántos dígitos han sido ingresados (3 por número).
- Dos **registros de almacenamiento**, cada uno de 12 bits, que guardan tres dígitos en formato BCD (4 bits por dígito).

### **b. Subsistema de suma aritmética**
Cuando se han capturado ambos números, este bloque realiza la suma binaria sin signo.

### **c. Subsistema de despliegue en displays**
Muestra el resultado final de la suma en cuatro dígitos a través de los siguientes componentes:
- **Conversión binaria a BCD** Utiliza el algoritmo “double dabble” para convertir el número binario de 13 bits a 4 dígitos BCD.
- **Decodificador BCD a 7 segmentos** Convierte cada dígito BCD a la salida correspondiente en segmentos a–g.
- **Multiplexado de displays** Activa cada uno de los 4 dígitos de forma cíclica usando un contador.
Este subsistema garantiza una visualización continua, estable y sin parpadeos visibles.

## 4. Diagramas de bloques y funcionamiento

A continuación se describen los principales bloques funcionales del sistema, junto con los diagramas que ilustran el flujo de datos y control entre módulos. Cada uno de estos diagramas representa un subsistema clave en el procesamiento, desde la lectura hasta la visualización del resultado.

---

### Figura 1. Diagrama de bloques del subsistema de lectura del teclado hexadecimal

Este diagrama representa la primera etapa del sistema, encargada de capturar los datos desde el teclado físico. El proceso de lectura inicia con un barrido de columnas usando un contador de anillo (ring counter), el cual activa cada columna una por una. Las filas detectan si alguna tecla ha sido presionada, generando una señal que pasa por un módulo debouncer, encargado de eliminar rebotes mecánicos. Una vez estabilizada, la señal entra a un codificador que convierte la posición fila/columna en un valor hexadecimal de 4 bits. Finalmente, una unidad de control determina si el valor debe almacenarse en el registro `Num1` o `Num2`, según la etapa de captura en la que se encuentre el sistema.

---

### Figura 2. Diagrama de bloques del subsistema de suma aritmética

Este diagrama muestra cómo se conectan los registros de entrada `Num1` y `Num2` con un sumador binario. Cada registro contiene 12 bits (3 dígitos decimales en BCD). El sumador opera de forma combinacional, sin requerir un reloj, y genera una salida de 13 bits que representa el resultado de la suma en binario sin signo. Esta operación es sencilla, pero crucial, pues establece la transición del sistema desde la captura hacia la visualización del resultado.

---

### Figura 3. Diagrama de bloques del subsistema de despliegue en displays de 7 segmentos

Aquí se ilustra cómo se procesa el resultado binario para hacerlo legible al usuario. Primero, el número binario pasa por un conversor binario a BCD (`bin_to_bcd`), que separa el valor en unidades, decenas, centenas y millares. Luego, cada dígito BCD es transformado en su patrón de encendido correspondiente por medio del módulo `decoder_bcd_7seg`. Finalmente, un multiplexor de displays activa secuencialmente cada uno de los cuatro dígitos a una frecuencia que el ojo humano percibe como una imagen continua. Esto permite mostrar números de hasta cuatro cifras en solo cuatro displays físicos compartiendo las mismas líneas de segmentos.

---

### Figura 4. Diagrama de estados de la FSM de control del sistema

Este diagrama representa la máquina de estados finita (FSM) global que gobierna la operación del sistema completo. Comienza en el estado `IDLE`, donde espera una pulsación de tecla. Luego transita por `CAPTURA 1` y `CAPTURA 2`, capturando los tres dígitos de cada número. Una vez que ambos están completos, pasa a `SUMA`, realiza la operación aritmética, y muestra el resultado en `MOSTRAR`. Finalmente, puede entrar en `RESET` para reiniciar el ciclo. Esta FSM es clave para sincronizar los tres subsistemas y garantizar que cada acción ocurra en el momento correcto.

---

### Figura 5. Diagrama de estados de la FSM del módulo de lectura del teclado

Este diagrama detalla la FSM local del módulo de lectura de teclado. Inicia en `ESPERA_TECLA`, esperando una pulsación válida. Al detectar una tecla, avanza a `CAPTURA_DIGITO`, donde almacena el valor. Luego pasa a `ESPERA_SOLTAR` para evitar rebotes, y sigue a `VERIFICA_DIGITOS` para contar cuántos dígitos se han ingresado. Si ya se capturaron 3 dígitos, pasa a `CAMBIA_NUMERO` (cambia de Num1 a Num2). Al capturar 6 dígitos (3 por número), entra en `LISTO`. Esta FSM asegura la captura ordenada y sin errores de cada dígito introducido.











