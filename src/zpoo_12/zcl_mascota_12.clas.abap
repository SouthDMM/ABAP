CLASS zcl_mascota_12 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS:
        constructor,
        comer,
        jugar,
        consultar_estado EXPORTING ev_hambre TYPE i
                                   ev_energia TYPE i.

  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA:
        hambre TYPE i,
        energia TYPE i.
ENDCLASS.



CLASS zcl_mascota_12 IMPLEMENTATION.
  METHOD constructor.
    hambre = 100.
    energia = 100.
  ENDMETHOD.

  METHOD comer.
    IF  hambre < 100.
        hambre += 20.
        IF hambre > 100.
            hambre = 100.
        ENDIF.
    ENDIF.
  ENDMETHOD.

  METHOD jugar.
    if energia >= 20.
        energia -= 15.
        hambre -= 10.
    ENDIF.
  ENDMETHOD.

  METHOD consultar_estado.
    ev_hambre = hambre.
    ev_energia = energia.
  ENDMETHOD.

ENDCLASS.
