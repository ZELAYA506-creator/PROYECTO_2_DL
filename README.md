# Proyecto 1 - Diseño Lógico (EL-3307)

## 1. Descripción General

Este proyecto implementa un sistema digital en FPGA que detecta y corrige errores de un solo bit utilizando el código de Hamming (7,4). Fue desarrollado utilizando SystemVerilog y probado en una FPGA TangNano, simulando la transmisión de una palabra binaria y la corrección de errores intencionales en la recepción.

## 2. Subsistemas del diseño

- **Codificador**: Genera la palabra de 7 bits con bits de paridad a partir de los 4 bits de entrada.
- **Decodificador**: Detecta errores y calcula el síndrome usando los bits de paridad.
- **Corrector**: Corrige la palabra en caso de error.
- **LED Display**: Muestra la palabra corregida en binario.
- **7 Segment Display**: Muestra la palabra o la posición del error según un switch de control.
- **Módulo principal**: Integra todos los subsistemas anteriores.

## 3. Diagrama de bloques

*(Aquí irá el diagrama del sistema, o una descripción textual si no tenés imagen)*

## 4. Simulaciones

*(Aquí se incluirán capturas y análisis del comportamiento esperado de entrada/salida)*

## 5. Análisis de recursos

*(Aquí se incluirá el uso de LUTs, FFs, potencia si usaste herramientas de síntesis)*

## 6. Problemas encontrados y soluciones

- Conexiones incorrectas en el display de 7 segmentos → resuelto revisando configuración de pines.
- Error en bits de paridad → corregido tras verificar ecuaciones del síndrome.
