CLASS zcl_taller_bicis_12 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS:
* registrar_reparacion* (el "Create"): recibe cliente y avería (IMPORTING), genera un nuevo id_reparacion
*(puede ser tan simple como coger el máximo existente y sumarle 1), inserta el registro en la tabla con
*estado 'PENDIENTE', y devuelve (RETURNING) el id_reparacion generado.
      registrar_reparacion IMPORTING i_cliente               TYPE string
                                     i_averia                TYPE string
                           RETURNING VALUE(rv_id_reparacion) TYPE i,
*consultar_reparacion* (el "Read"): recibe un id_reparacion (IMPORTING), y devuelve (EXPORTING) el cliente, la
*avería y el estado de esa reparación concreta. Pensad qué debería pasar si el id_reparacion no existe en la tabla.
      consultar_reparacion IMPORTING i_id_reparacion_read TYPE i
                           EXPORTING e_cliente            TYPE string
                                     e_averia             TYPE string
                                     e_estado             TYPE string
                           RETURNING VALUE(rv_consulta) TYPE abap_bool,
*cambiar_estado* (el "Update"): recibe id_reparacion y el nuevo estado (IMPORTING), y actualiza esa fila en la tabla.
*Debe devolver (RETURNING) un abap_bool indicando si la actualización se pudo hacer (por ejemplo, si el id_reparacion
* no existía, no se puede actualizar).
      cambiar_estado IMPORTING i_id_reparacion_update TYPE i
                               i_nuevo_estado         TYPE string
                     RETURNING VALUE(rv_update)       TYPE abap_bool,
*eliminar_reparacion* (el "Delete"): recibe id_reparacion (IMPORTING), borra esa fila de la tabla, y
*devuelve (RETURNING) un abap_bool indicando si se pudo borrar.
      eliminar_reparacion IMPORTING i_id_reparacion_delete TYPE i
                          RETURNING VALUE(rv_delete)       TYPE abap_bool.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_taller_bicis_12 IMPLEMENTATION.
  METHOD cambiar_estado.
        UPDATE ztaller_12 SET estado = @i_nuevo_estado WHERE id_reparacion =  @i_id_reparacion_update.
        IF sy-subrc = 0.
            rv_update = abap_true.
        ELSE.
            rv_update = abap_false.
        ENDIF.
  ENDMETHOD.

  METHOD consultar_reparacion.
    SELECT single from ztaller_12
    FIELDS cliente, averia, estado
    WHERE id_reparacion = @i_id_reparacion_read
    into @data(ls_aux_consulta).

    IF sy-subrc = 0.
        e_cliente = ls_aux_consulta-cliente.
        e_averia = ls_aux_consulta-averia.
        e_estado = ls_aux_consulta-estado.
        rv_consulta = abap_true.
    ELSE.
        rv_consulta = abap_false.
    ENDIF.

  ENDMETHOD.

  METHOD eliminar_reparacion.

    DELETE from ztaller_12
    WHERE id_reparacion = @i_id_reparacion_delete.
    if sy-subrc = 0.
        rv_delete = abap_true.
    else.
        rv_delete = abap_false.
    ENDIF.

  ENDMETHOD.

  METHOD registrar_reparacion.

    DATA ls_registro TYPE ztaller_12.

    SELECT SINGLE FROM ztaller_12
    FIELDS MAX( id_reparacion )
    INTO @DATA(aux_rep).

    rv_id_reparacion = aux_rep + 10.
    ls_registro = VALUE #( id_reparacion = rv_id_reparacion cliente = i_cliente averia = i_averia estado = '01' ).
    INSERT ztaller_12 FROM @ls_registro.

  ENDMETHOD.

ENDCLASS.
