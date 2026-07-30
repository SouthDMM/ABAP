CLASS zcl_cafetera_12 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
     METHODS:
        constructor IMPORTING agua_inicial TYPE i,
        preparar_cafe,
        consultar_agua RETURNING VALUE(rv_agua_restante) type i.

  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA agua_restante TYPE i.
ENDCLASS.



CLASS zcl_cafetera_12 IMPLEMENTATION.

  METHOD constructor.
    agua_restante = agua_inicial.
  ENDMETHOD.

  METHOD preparar_cafe.
    if agua_restante >= 250.
        agua_restante -= 250.
    ENDIF.
  ENDMETHOD.

  METHOD consultar_agua.
    rv_agua_restante = agua_restante.
  ENDMETHOD.

ENDCLASS.
