CLASS zcl_test_taller_bicis_12 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_test_taller_bicis_12 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DELETE FROM ztaller_12.

    DATA:
        lv_cliente TYPE string,
        lv_averia TYPE string,
        lv_estado TYPE string.

    DATA(lo_taller) = NEW zcl_taller_bicis_12( ).
*   1. Registre 3 reparaciones distintas y muestre los IDs generados.
    out->write( | Se ha generado la reparacion, con ID { lo_taller->registrar_reparacion( EXPORTING i_cliente = 'David Moreno' i_averia = 'Rotura de cadena' ) }. | ).
    out->write( | Se ha generado la reparacion, con ID { lo_taller->registrar_reparacion( EXPORTING i_cliente = 'Antonio Garcia' i_averia = 'Cambio de cubiertas' ) }. | ).
    out->write( | Se ha generado la reparacion, con ID { lo_taller->registrar_reparacion( EXPORTING i_cliente = 'Manuel Garcia' i_averia = 'Cambio de aceite' ) }. | ).
*   2. Consulte una de ellas (10) y muestre sus datos.
    data(aux_consulta) = 10.
    IF lo_taller->consultar_reparacion( EXPORTING i_id_reparacion_read = aux_consulta
                                        IMPORTING e_cliente = lv_cliente
                                                  e_averia = lv_averia
                                                  e_estado = lv_estado ).
        out->write( |Id de la reparacion: { aux_consulta }\nCliente: { lv_cliente } \nAveria: { lv_averia } \nEstado: { lv_estado }| ).
    ELSE.
        out->write( | No hay registros con el ID { aux_consulta } | ).
    ENDIF.

    aux_consulta = 40.
    IF lo_taller->consultar_reparacion( EXPORTING i_id_reparacion_read = aux_consulta
                                        IMPORTING e_cliente = lv_cliente
                                                  e_averia = lv_averia
                                                  e_estado = lv_estado ).
        out->write( |Id de la reparacion: { aux_consulta }\nCliente: { lv_cliente } \nAveria: { lv_averia } \nEstado: { lv_estado }| ).
    ELSE.
        out->write( | No hay registros con el ID { aux_consulta } | ).
    ENDIF.

*   3.Cambie el estado de una a 'EN CURSO', y vuelva a consultarla para comprobar que el cambio se ha guardado.
    data(aux_id_modificar) = 10.
    IF lo_taller->cambiar_estado( EXPORTING i_id_reparacion_update = aux_id_modificar
                                            i_nuevo_estado = '02' ).
        out->write( | El registro con Id { aux_id_modificar } se ha modificado correctamente.| ).
    ELSE.
        out->write( | El registro con Id { aux_id_modificar } no se ha encontrado.| ).
    ENDIF.

    aux_consulta = aux_id_modificar
    .
    IF lo_taller->consultar_reparacion( EXPORTING i_id_reparacion_read = aux_consulta
                                        IMPORTING e_cliente = lv_cliente
                                                  e_averia = lv_averia
                                                  e_estado = lv_estado ).
        out->write( |Id de la reparacion: { aux_consulta }\nCliente: { lv_cliente } \nAveria: { lv_averia } \nEstado: { lv_estado }| ).
    ELSE.
        out->write( | No hay registros con el ID { aux_consulta } | ).
    ENDIF.

    aux_id_modificar = 40.
    IF lo_taller->cambiar_estado( EXPORTING i_id_reparacion_update = aux_id_modificar
                                            i_nuevo_estado = '02' ).
        out->write( | El registro con Id { aux_id_modificar } se ha modificado correctamente.| ).
    ELSE.
        out->write( | El registro con Id { aux_id_modificar } no se ha encontrado.| ).
    ENDIF.
*   4. Elimine la otra reparación, e intente consultarla de nuevo (debería indicar que ya no existe).

    data(aux_id_eliminar) = 20.
    IF lo_taller->eliminar_reparacion( i_id_reparacion_delete = aux_id_eliminar ).
        out->write( | El registro con Id { aux_id_eliminar } se ha eliminado correctamente.| ).
    ELSE.
        out->write( | El registro con Id { aux_id_eliminar } no se ha encontrado.| ).
    ENDIF.

    aux_id_modificar = aux_id_eliminar.
    IF lo_taller->cambiar_estado( EXPORTING i_id_reparacion_update = aux_id_modificar
                                            i_nuevo_estado = '02' ).
        out->write( | El registro con Id { aux_id_modificar } se ha modificado correctamente.| ).
    ELSE.
        out->write( | El registro con Id { aux_id_modificar } no se ha encontrado.| ).
    ENDIF.

  ENDMETHOD.
ENDCLASS.
