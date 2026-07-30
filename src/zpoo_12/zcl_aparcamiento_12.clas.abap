CLASS zcl_aparcamiento_12 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS
        calcular_tarifa
            IMPORTING iv_horas_estacionado TYPE i
            EXPORTING ev_minutos_totales   TYPE i
            RETURNING VALUE(rv_precio)     TYPE zdecimals2.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_aparcamiento_12 IMPLEMENTATION.
  METHOD calcular_tarifa.
    rv_precio = iv_horas_estacionado * '1.5'.
    ev_minutos_totales = iv_horas_estacionado * 60.
  ENDMETHOD.

ENDCLASS.
