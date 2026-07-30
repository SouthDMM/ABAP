CLASS zcl_atraccion_feria_12 DEFINITION
  PUBLIC
  INHERITING FROM zcl_atraccion_12
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS:
      constructor IMPORTING i_nom_atraccion TYPE string
                            i_precio TYPE zdecimals2,
      calcular_precio_entrada REDEFINITION.
  PROTECTED SECTION.
    DATA precio_fijo TYPE zdecimals2.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_atraccion_feria_12 IMPLEMENTATION.
  METHOD calcular_precio_entrada.
    rv_importe = precio_fijo.
  ENDMETHOD.



  METHOD constructor.

    super->constructor( i_nombre = i_nom_atraccion ).
    precio_fijo = i_precio.
  ENDMETHOD.

ENDCLASS.
