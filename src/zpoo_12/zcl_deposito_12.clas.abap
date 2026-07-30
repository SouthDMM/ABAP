CLASS zcl_deposito_12 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS:
      constructor IMPORTING cap_max TYPE i,
      repostar_deposito IMPORTING sumar_litros TYPE i,
      despachar_combustible IMPORTING despachar_litros TYPE i RETURNING VALUE(rv_depachado) TYPE abap_bool,
      consultar_nivel RETURNING VALUE(rv_consultar) TYPE i.
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA:
      litros_actuales  TYPE i,
      capacidad_maxima TYPE i.
ENDCLASS.



CLASS zcl_deposito_12 IMPLEMENTATION.
  METHOD constructor.
    capacidad_maxima = cap_max.
    litros_actuales = 0.
  ENDMETHOD.

  METHOD repostar_deposito.
    DATA(aux) = sumar_litros + litros_actuales.
    IF aux <= capacidad_maxima.
      litros_actuales += sumar_litros.
    ELSE.
      litros_actuales = capacidad_maxima.
    ENDIF.
  ENDMETHOD.

  METHOD despachar_combustible.
    IF despachar_litros <= litros_actuales.
        litros_actuales -= despachar_litros.
        rv_depachado = abap_true.
    ELSE.
        rv_depachado = abap_false.
    ENDIF.
  ENDMETHOD.

  METHOD consultar_nivel.
    rv_consultar = litros_actuales.
  ENDMETHOD.

ENDCLASS.
