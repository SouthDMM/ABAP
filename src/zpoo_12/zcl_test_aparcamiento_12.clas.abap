CLASS zcl_test_aparcamiento_12 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_test_aparcamiento_12 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

  DATA lv_minutos type i.

  DATA(lo_aparcamiento) = NEW zcl_aparcamiento_12( ).

  out->write( | El precio es de { lo_aparcamiento->calcular_tarifa( exporting iv_horas_estacionado = 3 importing ev_minutos_totales = lv_minutos ) } en { lv_minutos } minutos.| ).

  ENDMETHOD.
ENDCLASS.
