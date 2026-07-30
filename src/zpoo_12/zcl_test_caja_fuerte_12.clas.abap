CLASS zcl_test_caja_fuerte_12 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_test_caja_fuerte_12 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA lv_codigo TYPE string.
    DATA(lo_caja_fuerte) = NEW zcl_caja_fuerte_12( '1234' ).

    lv_codigo = '1234'.
    out->write( '  ------------------------- CODIGO CORRECTO ------------------------' ).
    IF lo_caja_fuerte->esta_bloqueada( ).
      out->write( '  --> La caja está bloqueada. <--' ).
    ELSEIF NOT lo_caja_fuerte->esta_bloqueada( ) AND lo_caja_fuerte->abrir( lv_codigo ).
      out->write( '  --> Intento acertado <--' ).
    ELSEIF NOT lo_caja_fuerte->esta_bloqueada( ) AND NOT lo_caja_fuerte->abrir( lv_codigo ).
      out->write( '  --> Intentelo de nuevo <--' ).
    ENDIF.
    out->write( '  ------------------------- CODIGO INCORRECTO ------------------------' ).
    lv_codigo = '1235'.
    DO 4 TIMES.
      IF lo_caja_fuerte->esta_bloqueada( ).
        out->write( '  --> La caja está bloqueada. <--' ).
      ELSEIF NOT lo_caja_fuerte->esta_bloqueada( ) AND lo_caja_fuerte->abrir( lv_codigo ).
        out->write( '  --> Intento acertado <--' ).
      ELSEIF NOT lo_caja_fuerte->esta_bloqueada( ) AND NOT lo_caja_fuerte->abrir( lv_codigo ).
        out->write( '  --> Intentelo de nuevo <--' ).
      ENDIF.
    ENDDO.

  ENDMETHOD.
ENDCLASS.
