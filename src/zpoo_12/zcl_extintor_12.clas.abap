CLASS zcl_extintor_12 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS:
        constructor IMPORTING carga_inicial TYPE i,
        usar,
        consultar_carga RETURNING VALUE(rv_carga_restante) type i.
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA carga_restante TYPE i.
ENDCLASS.



CLASS zcl_extintor_12 IMPLEMENTATION.

  METHOD constructor.
    carga_restante = carga_inicial.
  ENDMETHOD.

  METHOD usar.
    if carga_restante >= 35.
        carga_restante -= 35.
    ENDIF.
  ENDMETHOD.

  METHOD consultar_carga.
    rv_carga_restante = carga_restante.
  ENDMETHOD.

ENDCLASS.
