CLASS zcl_bombilla_12 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS:
        constructor IMPORTING i_potencia TYPE i,
        encender,
        get_encendida RETURNING VALUE(rv_encencida) type abap_bool.

  PROTECTED SECTION.
  PRIVATE SECTION.

    "Atributo
    DATA: esta_encendida TYPE abap_bool,
          potencia TYPE i.

ENDCLASS.


CLASS zcl_bombilla_12 IMPLEMENTATION.

  METHOD encender.
    esta_encendida = abap_true.
  ENDMETHOD.

  METHOD get_encendida.
    "Parametro = Atributo
    rv_encencida = esta_encendida.
  ENDMETHOD.

  METHOD constructor.
    potencia = i_potencia.
  ENDMETHOD.

ENDCLASS.
