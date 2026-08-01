CLASS zcl_gestor_alquileres_12 DEFINITION
  PUBLIC
**********************************************************************
*Clase ZCL_GESTOR_ALQUILERES_XX
*
*Detalle interesante para esta clase: no tiene ningún sentido crear un objeto de ella — no representa "una cosa", sino
*un conjunto de operaciones sobre la tabla. Por eso, todos sus métodos van a ser estáticos (CLASS-METHODS), y se llaman
*siempre con =>, directamente sobre la clase, sin NEW en ningún momento. (Bonus opcional, no obligatorio: si queréis ir
*un paso más allá, investigad qué hace CREATE PRIVATE en la definición de una clase, y por qué podría tener sentido
*ponerlo aquí — es un adelanto de algo que no hemos visto en teoría, pero que podéis intuir con lo que ya sabéis.)
*
*crear_alquiler: IMPORTING título y socio, genera un id_alquiler nuevo (máximo existente + 1), inserta el registro con
*                estado 'ALQUILADO', RETURNING el ID generado.
*consultar_alquiler: IMPORTING un id_alquiler, EXPORTING título, socio, estado, y un abap_bool indicando si se encontró o no.
*devolver_alquiler: IMPORTING un id_alquiler, actualiza su estado a 'DEVUELTO', RETURNING un abap_bool (éxito o no).
*eliminar_alquiler: IMPORTING un id_alquiler, borra la fila, RETURNING un abap_bool (éxito o no).
**********************************************************************
  FINAL
*  CREATE PUBLIC .
CREATE PRIVATE.

  PUBLIC SECTION.
  CLASS-METHODS:
        crear_alquiler IMPORTING i_titulo type string
                                 i_socio TYPE string
                       RETURNING VALUE(rv_id_generado) TYPE i,
        consultar_alquiler IMPORTING i_id_alquiler TYPE i
                           EXPORTING e_titulo TYPE string
                                     e_socio TYPE string
                                     e_estado TYPE string
                                     e_encontrado TYPE abap_bool,
        devolver_alquiler IMPORTING i_id_alquiler TYPE i
                          RETURNING VALUE(rv_devuelto) TYPE abap_bool,
        eliminar_alquiler IMPORTING i_id_alquiler TYPE i
                          RETURNING VALUE(rv_eliminado) TYPE abap_bool.



  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_gestor_alquileres_12 IMPLEMENTATION.

  METHOD crear_alquiler.
    SELECT SINGLE FROM zalquiler_12
    FIELDS MAX( id_alquiler )
    INTO @DATA(lv_nuevo_id).
    IF sy-subrc = 0.
        data(ls_alquiler) = VALUE zalquiler_12( id_alquiler = lv_nuevo_id + 1
                                                titulo_pelicula = i_titulo
                                                socio = i_socio
                                                estado = 'ALQUILADO' ).
        INSERT zalquiler_12 FROM @ls_alquiler.
        rv_id_generado = lv_nuevo_id + 1.
    ENDIF.
  ENDMETHOD.

  METHOD consultar_alquiler.
    e_encontrado = abap_false.
    SELECT SINGLE
    FROM zalquiler_12
    FIELDS *
    WHERE id_alquiler = @i_id_alquiler
    into @data(ls_alquiler).
    if sy-subrc = 0.
        e_titulo = ls_alquiler-titulo_pelicula.
        e_socio = ls_alquiler-socio.
        e_estado = ls_alquiler-estado.
        e_encontrado = abap_true.
    ENDIF.
  ENDMETHOD.

  METHOD devolver_alquiler.
    UPDATE zalquiler_12 SET estado = 'DEVUELTO' WHERE id_alquiler = @i_id_alquiler.
    IF sy-subrc = 0.
        rv_devuelto = abap_true.
    ELSE.
        rv_devuelto = abap_false.
    ENDIF.
  ENDMETHOD.

  METHOD eliminar_alquiler.
    DELETE FROM zalquiler_12 WHERE id_alquiler = @i_id_alquiler.
    IF sy-subrc = 0.
        rv_eliminado = abap_true.
    ELSE.
        rv_eliminado = abap_false.
    ENDIF.
  ENDMETHOD.

ENDCLASS.
