CLASS zcl_guitarra_12 DEFINITION
  PUBLIC
  INHERITING FROM zcl_instrumento_12
  FINAL
  CREATE PUBLIC .
*- Constructor propio: recibe marca *y* número de cuerdas.
*- Atributo propio: número de cuerdas (tipo I).
*- Método propio afinar_cuerda: recibe (IMPORTING) el número de cuerda a afinar. Devuelve (RETURNING)
*un abap_bool: abap_true si el número de cuerda pedido es válido (mayor que 0 y no mayor que el número
*de cuerdas que tiene esa guitarra en concreto), abap_false si no lo es.
  PUBLIC SECTION.
    METHODS:
      constructor IMPORTING i_marca_guitarra TYPE string
                            i_cuerdas        TYPE i,
      afinar_cuerdas IMPORTING i_num_cuerdas TYPE i RETURNING VALUE(rv_valido) TYPE abap_bool.
  PROTECTED SECTION.
    DATA cuerdas TYPE i.
  PRIVATE SECTION.

ENDCLASS.



CLASS zcl_guitarra_12 IMPLEMENTATION.

  METHOD afinar_cuerdas.
    IF i_num_cuerdas > 0 AND i_num_cuerdas <= cuerdas.
      rv_valido = abap_true.

    ELSE.
      rv_valido = abap_false.
    ENDIF.
  ENDMETHOD.

  METHOD constructor.
    super->constructor( i_marca = i_marca_guitarra ).
    cuerdas = i_cuerdas.
  ENDMETHOD.

ENDCLASS.
