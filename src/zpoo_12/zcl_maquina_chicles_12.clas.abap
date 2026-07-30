CLASS zcl_maquina_chicles_12 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

  METHODS:
    constructor IMPORTING iv_chicles TYPE i,
    vender_chicle IMPORTING iv_monedas TYPE i RETURNING VALUE(rv_cambio) TYPE i,
    consultar_stock RETURNING VALUE(rv_chicles) type i.

  PROTECTED SECTION.
  PRIVATE SECTION.

    DATA:
      chicles_restantes TYPE i,
      precio_chicle     TYPE i.

ENDCLASS.



CLASS zcl_maquina_chicles_12 IMPLEMENTATION.
  METHOD CONSTRUCTOR.
    chicles_restantes = iv_chicles.
    precio_chicle = 25.
  ENDMETHOD.

  METHOD vender_chicle.
    IF chicles_restantes = 0 or iv_monedas < precio_chicle.
        rv_cambio = iv_monedas.
    ELSE.
        chicles_restantes -= 1.
        rv_cambio = iv_monedas - precio_chicle.
    ENDIF.
  ENDMETHOD.

  METHOD consultar_stock.
    rv_chicles = chicles_restantes.
  ENDMETHOD.

ENDCLASS.
