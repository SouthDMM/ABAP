CLASS zcl_concierto_12 DEFINITION
  PUBLIC
  INHERITING FROM zcl_atraccion_12
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS calcular_precio_entrada REDEFINITION.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_concierto_12 IMPLEMENTATION.
  METHOD calcular_precio_entrada.
    if consultar_visitante( )  > 500.
        rv_importe = 5.
    else.
        rv_importe = 10.
    ENDIF.
  ENDMETHOD.

ENDCLASS.
