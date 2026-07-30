CLASS zcl_test_cafetera_12 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_test_cafetera_12 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA(lo_cafetera) = NEW zcl_cafetera_12( 600 ).

    DO 3 TIMES.
        lo_cafetera->preparar_cafe( ).
    ENDDO.

    out->write( |El agua restante es { lo_cafetera->consultar_agua( ) }| ).

  ENDMETHOD.
ENDCLASS.
