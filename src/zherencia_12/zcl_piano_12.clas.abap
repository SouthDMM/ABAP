CLASS zcl_piano_12 DEFINITION
  PUBLIC
  INHERITING FROM zcl_instrumento_12
  FINAL
  CREATE PUBLIC .
*- Constructor propio: recibe marca *y* si es eléctrico (abap_bool).
*- Atributo propio: si es eléctrico (abap_bool).
*- Método propio pedalear: sin parámetros de entrada. Solo tiene sentido si el piano lleva *al menos 1 hora
*  de uso acumulada* (un piano recién estrenado, sin haberse tocado nunca, no tiene sentido que ya se le esté
*  dando al pedal). Devuelve (RETURNING) un abap_bool indicando si la acción se pudo hacer.
  PUBLIC SECTION.
    METHODS:
      constructor IMPORTING i_marca_piano TYPE string
                            i_electrico   TYPE abap_bool,
      pedalear RETURNING VALUE(rv_pisar) TYPE abap_bool.
  PROTECTED SECTION.
    DATA electrico TYPE abap_bool.
  PRIVATE SECTION.

ENDCLASS.



CLASS zcl_piano_12 IMPLEMENTATION.
  METHOD constructor.
    super->constructor( i_marca = i_marca_piano ).
    electrico = i_electrico.
  ENDMETHOD.

  METHOD pedalear.
    IF consultar_horas_uso( ) >= 1.
      rv_pisar = abap_true.
    ELSE.
      rv_pisar = abap_false.
    ENDIF.
  ENDMETHOD.

ENDCLASS.
