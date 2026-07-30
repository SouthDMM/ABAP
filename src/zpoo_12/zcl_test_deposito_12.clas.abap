CLASS zcl_test_deposito_12 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_test_deposito_12 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    DATA(lo_deposito) = NEW zcl_deposito_12( 1000 ).

    lo_deposito->repostar_deposito( 700 ).
    out->write( | Nivel 1: { lo_deposito->consultar_nivel( ) } | ).
    lo_deposito->repostar_deposito( 500 ).
    out->write( | Nivel 2: { lo_deposito->consultar_nivel( ) } | ).
    DATA(lv_aux) = 200.
    IF lo_deposito->despachar_combustible( lv_aux ).
        out->write( | Se ha despachado correctamente { lv_aux } y el nivel actual es { lo_deposito->consultar_nivel( ) } | ).
    ELSE.
        out->write( | No se ha despachado { lv_aux } y el nivel actual es { lo_deposito->consultar_nivel( ) } | ).
    ENDIF.
        out->write( '----------------------------------------' ).
    lv_aux = 5000.
    IF lo_deposito->despachar_combustible( lv_aux + lo_deposito->consultar_nivel( ) ).
        out->write( | Se ha despachado correctamente { lv_aux } y el nivel actual es { lo_deposito->consultar_nivel( ) } | ).
    ELSE.
        out->write( | No se ha despachado { lv_aux } y el nivel actual es { lo_deposito->consultar_nivel( ) } | ).
    ENDIF.
  ENDMETHOD.
ENDCLASS.
