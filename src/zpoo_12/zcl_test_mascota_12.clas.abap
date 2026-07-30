CLASS zcl_test_mascota_12 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_test_mascota_12 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA(lo_mascota) = NEW  zcl_mascota_12( ).

    DATA:
      lv_energia TYPE i,
      lv_hambre  TYPE i.

    DO 7 TIMES.
        out->write( |Juega { sy-index } vez.| ).
        lo_mascota->jugar(  ).
        lo_mascota->consultar_estado( importing ev_energia = lv_energia
                                                ev_hambre = lv_hambre ).
        out->write( |Energia: { lv_energia } y hambre: { lv_hambre }.| ).
    ENDDO.

    out->write( |Come 1 vez.| ).
        lo_mascota->comer( ).
        lo_mascota->consultar_estado( importing ev_energia = lv_energia
                                                ev_hambre = lv_hambre ).
        out->write( |Energia: { lv_energia } y hambre: { lv_hambre }.| ).

  ENDMETHOD.
ENDCLASS.
