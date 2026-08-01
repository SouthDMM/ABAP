CLASS zcl_test_notificaciones_12 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_test_notificaciones_12 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    DATA(lo_sms) = NEW zcl_notificacion_sms_12( i_telefono_cliente = '600696969' ).
    DATA(lo_carta) = NEW zcl_notificacion_carta_12( i_direccion_cliente = 'Calle Gaviota, 12' ).

    lo_sms->zif_notificable_12~notificar( i_mensaje = '' ).
    lo_carta->zif_notificable_12~notificar( i_mensaje = '' ).

    DATA(lv_coste) = lo_sms->zif_notificable_12~consultar_coste_envio(  ).
    out->write( | El coste del SMS es { lv_coste }| ).

    lv_coste = lo_carta->zif_notificable_12~consultar_coste_envio(  ).
    out->write( | El coste de la carta es { lv_coste }| ).

    DATA lt_notificaciones TYPE TABLE OF REF TO zif_notificable_12.
    APPEND lo_sms TO lt_notificaciones.
    APPEND lo_carta TO lt_notificaciones.

    APPEND NEW zcl_notificacion_sms_12( i_telefono_cliente = '612345678' ) TO lt_notificaciones.
    APPEND NEW zcl_notificacion_carta_12( i_direccion_cliente = 'Avenida Galaroza, 24' ) TO lt_notificaciones.

    data(lv_contador) = 0.
    LOOP AT lt_notificaciones INTO DATA(lo_notificacion).
        lv_coste = lo_notificacion->consultar_coste_envio( ).
        "---- AQUI AVERIGUAMOS SI PERTENECE A UN TIPO DE CLASE ----"
        if lo_notificacion IS INSTANCE OF zcl_notificacion_sms_12.
            out->write( |El coste del sms es { lv_coste } €.| ).
        else.
            out->write( |El coste de la carta es { lv_coste } €.| ).
        ENDIF.
        "----------------------------------------------------------"

        "---- AQUI AVERIGUAMOS DE QUE TIPO CLASE ES ----"
        DATA(lo_descriptor) = cl_abap_typedescr=>describe_by_object_ref( lo_notificacion ).
        DATA(lv_tipo_real) = lo_descriptor->get_relative_name( ).
        out->write( | La notificacion es de tipo: { lv_tipo_real }| ).
        "-----------------------------------------------"
        lv_contador += 1.
    ENDLOOP.
    out->write( |El número de envios es { lv_contador }.| ).
  ENDMETHOD.
ENDCLASS.

