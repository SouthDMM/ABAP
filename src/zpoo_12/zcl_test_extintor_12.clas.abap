CLASS zcl_test_extintor_12 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_test_extintor_12 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

  DATA(lo_extintor) = NEW zcl_extintor_12( 100 ).

    DO 3 TIMES.
        lo_extintor->usar( ).
    ENDDO.

    out->write( |El carga restante es { lo_extintor->consultar_carga( ) }| ).

  ENDMETHOD.
ENDCLASS.
