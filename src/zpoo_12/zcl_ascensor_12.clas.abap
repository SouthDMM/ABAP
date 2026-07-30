CLASS zcl_ascensor_12 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS:
      constructor IMPORTING i_planta_max TYPE i
                            i_peso_max   TYPE i,
      entrar_peso IMPORTING i_peso TYPE i,
      vaciar,
      subir_a_planta IMPORTING i_num_planta TYPE i RETURNING VALUE(rv_moverse) TYPE abap_bool,
      consultar_estado EXPORTING e_planta_actual TYPE i
                                 e_peso_actual   TYPE i
                                 e_bloqueado     TYPE abap_bool,
      movimiento RETURNING VALUE(rv_movimiento) TYPE string.

  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA:
      planta      TYPE i,
      planta_max  TYPE i,
      peso_max    TYPE i,
      peso_actual TYPE i,
      bloqueado   TYPE abap_bool.
ENDCLASS.



CLASS zcl_ascensor_12 IMPLEMENTATION.
  METHOD constructor.
    planta_max = i_planta_max.
    peso_max = i_peso_max.
    planta = 0.
    peso_actual = 0.
    bloqueado = abap_false.
  ENDMETHOD.

  METHOD entrar_peso.
    IF peso_actual + i_peso < peso_max.
      peso_actual += i_peso.
    ELSE.
      bloqueado = abap_true.
    ENDIF.
  ENDMETHOD.

  METHOD vaciar.
    peso_actual = 0.
    bloqueado = abap_false.
  ENDMETHOD.

  METHOD subir_a_planta.
    IF ( i_num_planta >= 0 AND i_num_planta <= planta_max ) AND bloqueado = abap_false.
      planta = i_num_planta.
      rv_moverse = abap_true.
    ELSE.
      rv_moverse = abap_false.
    ENDIF.
  ENDMETHOD.

  METHOD consultar_estado.
    e_planta_actual = planta.
    e_peso_actual = peso_actual.
    e_bloqueado = bloqueado.
  ENDMETHOD.

  METHOD movimiento.
    IF not bloqueado.
      rv_movimiento = 'no está bloqueado'.
    ELSE.
      rv_movimiento = 'está bloqueado'.
    ENDIF.
  ENDMETHOD.

ENDCLASS.
