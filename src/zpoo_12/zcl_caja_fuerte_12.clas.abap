CLASS zcl_caja_fuerte_12 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS:
        constructor IMPORTING iv_codigo TYPE string,
        abrir IMPORTING iv_intento_codigo TYPE string RETURNING VALUE(rv_abierto) TYPE abap_bool,
        esta_bloqueada RETURNING VALUE(rv_bloqueada) TYPE abap_bool.

  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA:
        pin TYPE string,
        intentos type i.
ENDCLASS.

CLASS zcl_caja_fuerte_12 IMPLEMENTATION.
  METHOD constructor.
    pin = iv_codigo.
    intentos = 0.
  ENDMETHOD.

  METHOD abrir.
    if intentos < 3 and pin = iv_intento_codigo.
        rv_abierto = abap_true.
        intentos = 0.
    ELSE.
        rv_abierto = abap_false.
        intentos += 1.
    ENDIF.
  ENDMETHOD.

  METHOD esta_bloqueada.
    if intentos >= 2.
        rv_bloqueada = abap_true.
    ELSE.
        rv_bloqueada = abap_false.
    ENDIF.

  ENDMETHOD.

ENDCLASS.
