CLASS zcl_test_videoclub_12 DEFINITION
  PUBLIC
**********************************************************************
*Clase de test ZCL_TEST_VIDEOCLUB_XX
*
*Seguid este orden exacto, mostrando por consola el resultado de cada paso:
*
*1. Mostrar zcl_soporte_video_xx=>consultar_total_soportes( ) antes de crear nada (debe salir 0).
*2. Crear tres soportes:
*     dvd1: título 'Matrix', precio 3,00€, incluye_extras = abap_true.
*     dvd2: título 'Origen', precio 3,00€, incluye_extras = abap_false.
*     bluray1: título 'Dune', precio 4,00€, es_version_4k = abap_true.
*3. Volver a mostrar consultar_total_soportes( ) — debería salir 3, aunque sean de dos clases distintas (ZCL_DVD_XX y ZCL_BLURAY_XX).
*   Pensad bien por qué el contador es compartido entre las dos, a pesar de estar declarado en el padre y no en cada hija — es un buen
*   punto para razonar antes de ejecutar.
*4. Mostrar el calcular_precio_final( ) de cada uno de los tres, llamando directamente sobre cada variable (sin tabla todavía).
*   Comprobad a mano que os salen 3,50€, 3,00€ y 6,00€ respectivamente.
*5. Meter los tres en una tabla TYPE TABLE OF REF TO zcl_soporte_video_xx, y recorrerla con un LOOP mostrando calcular_precio_final( )
*   de cada uno — demuestra el polimorfismo vía herencia, con el mismo resultado que en el paso 4 pero sin preguntar nunca de qué tipo
*   concreto es cada elemento.
*6. Meter los tres (los mismos objetos) en una segunda tabla, esta vez TYPE TABLE OF REF TO zif_recomendable_xx, y recorrerla con un LOOP
*   mostrando recomendar( ) de cada uno — demuestra el polimorfismo vía interfaz, sin que exista ningún parentesco de tipos
*   entre ZCL_DVD_XX y ZCL_BLURAY_XX a nivel de esta tabla.
*7. Llamar 3 veces a registrar_alquiler( ) sobre dvd1, y 1 vez sobre bluray1. Mostrar después consultar_veces_alquilado( ) de ambos por
*   separado (deberían salir 3 y 1 — cada objeto lleva su propio contador de instancia, sin relación con el contador estático del paso 3).
*8. Parte CRUD, usando siempre zcl_gestor_alquileres_xx=>... (sin instanciar nada):
*   -> Crear un alquiler de 'Matrix' para el socio 'Fran', guardando el ID devuelto.
*   -> Crear un alquiler de 'Dune' para el socio 'Jesús', guardando el ID devuelto.
*   -> Consultar el primero y mostrar sus datos.
*   -> Marcar el primero como devuelto, y volver a consultarlo para comprobar que el estado ha cambiado.
*   -> Eliminar el segundo, e intentar consultarlo de nuevo (debe indicar que ya no existe).
**********************************************************************
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_test_videoclub_12 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
**********************************************************************
    out->write( '1. Mostrar zcl_soporte_video_xx=>consultar_total_soportes( ) antes de crear nada (debe salir 0).' ).
    out->write( |--> El número de soportes es { zcl_soporte_video_12=>consultar_total_soportes( ) }.\n| ).
**********************************************************************
    out->write( '2. Crear tres soportes diferentes.' ).
    out->write( '  + dvd1: título "Matrix", precio 3,00€, incluye_extras = abap_true.' ).
    out->write( '  + dvd2: título "Origen", precio 3,00€, incluye_extras = abap_false.' ).
    out->write( '  + bluray1: título "Dune", precio 4,00€, es_version_4k = abap_true.' ).
    DATA(lo_dvd1) = NEW zcl_dvd_12( i_titulo_dvd = 'Matrix' i_precio_alquiler_dvd = '3.00' i_incluye_extras = abap_true ).
    DATA(lo_dvd2) = NEW zcl_dvd_12( i_titulo_dvd = 'Origen' i_precio_alquiler_dvd = '3.00' i_incluye_extras = abap_false ).
    DATA(lo_bluray1) = NEW zcl_bluray_12( i_titulo_bluray = 'Dune' i_precio_alquiler_bluray = '4.00' i_es_version_4k = abap_true ).
    out->write( |--> Creados 2 DVDs y 1 BLURAY.\n| ).
**********************************************************************
    out->write( '3. Volver a mostrar consultar_total_soportes( ) — debería salir 3' ).
    out->write( |--> El número de soportes es { zcl_soporte_video_12=>consultar_total_soportes( ) }.\n| ).
**********************************************************************
    out->write( '4. Mostrar el calcular_precio_final( ) de cada uno de los tres, llamando directamente sobre cada variable. ' ).
    out->write( '   Comprobad a mano que os salen 3,50€, 3,00€ y 6,00€ respectivamente.' ).
    out->write( |--> El precio final del DVD 1 es { lo_dvd1->calcular_precio_final(  ) } €.| ).
    out->write( |--> El precio final del DVD 2 es { lo_dvd2->calcular_precio_final(  ) } €.| ).
    out->write( |--> El precio final del BLURAY 1 es { lo_bluray1->calcular_precio_final(  ) } €.\n| ).
**********************************************************************
    out->write( '5. Meter los tres en una tabla TYPE TABLE OF REF TO zcl_soporte_video_xx, y recorrerla con un LOOP' ).
    out->write( '   mostrando calcular_precio_final( ) de cada uno.' ).
    DATA lt_registros TYPE TABLE OF REF TO zcl_soporte_video_12.
    APPEND lo_dvd1 TO lt_registros.
    APPEND lo_dvd2 TO lt_registros.
    APPEND lo_bluray1 TO lt_registros.
    LOOP AT lt_registros INTO DATA(lo_registro).
      IF lo_registro IS INSTANCE OF zcl_dvd_12.
        out->write( |--> El precio del soporte { sy-tabix } es { lo_registro->calcular_precio_final(  ) } y el soporte es DVD.| ).
      ELSE.
        out->write( |--> El precio del soporte { sy-tabix } es { lo_registro->calcular_precio_final(  ) } y el soporte es BLURAY.| ).
      ENDIF.
    ENDLOOP.
    out->write( | \n | ).
**********************************************************************
    out->write( '6. Meter los tres (los mismos objetos) en una segunda tabla, esta vez TYPE TABLE OF REF TO zif_recomendable_xx, y' ).
    out->write( '   recorrerla con un LOOP mostrando recomendar( ) de cada uno — demuestra el polimorfismo vía interfaz, sin que ' ).
    out->write( '   exista ningún parentesco de tipos entre ZCL_DVD_XX y ZCL_BLURAY_XX a nivel de esta tabla.' ).
    DATA lt_registros_2 TYPE TABLE OF REF TO zif_recomendable_12.
    APPEND lo_dvd1 TO lt_registros_2.
    APPEND lo_dvd2 TO lt_registros_2.
    APPEND lo_bluray1 TO lt_registros_2.
    LOOP AT lt_registros_2 INTO DATA(lo_registro_2).
      IF lo_registro_2 IS INSTANCE OF zcl_dvd_12.
        out->write( |--> El soporte { sy-tabix } es DVD { lo_registro_2->recomendar(  ) }.| ).
      ELSE.
        out->write( |--> El soporte { sy-tabix } es BLURAY { lo_registro_2->recomendar(  ) }.| ).
      ENDIF.
    ENDLOOP.
    out->write( | \n | ).
**********************************************************************
    out->write( '7. Llamar 3 veces a registrar_alquiler( ) sobre dvd1, y 1 vez sobre bluray1. Mostrar después consultar_veces_alquilado( )' ).
    out->write( '   de ambos por separado (deberían salir 3 y 1 — cada objeto lleva su propio contador de instancia.' ).
    DO 3 TIMES.
      lo_dvd1->registrar_alquiler( ).
    ENDDO.
    lo_bluray1->registrar_alquiler( ).
    out->write( |--> El DVD 1 se ha alquilado: { lo_dvd1->consultar_veces_alquilado( ) }| ).
    out->write( |--> El DVD 2 se ha alquilado: { lo_dvd2->consultar_veces_alquilado( ) }| ).
    out->write( |--> El BLURAY 1 se ha alquilado: { lo_bluray1->consultar_veces_alquilado( ) }\n| ).
**********************************************************************
    DATA:
      lv_titulo     TYPE string,
      lv_socio      TYPE string,
      lv_estado     TYPE string,
      lv_encontrado TYPE abap_bool.

    DELETE FROM zalquiler_12.

    out->write( '8. Parte CRUD, usando siempre zcl_gestor_alquileres_xx=>... (sin instanciar nada):' ).
    out->write( '  1) Crear un alquiler de "Matrix" para el socio "Fran", guardando el ID devuelto.' ).
    out->write( |\n| ).

    DATA(lv_alquiler_1) = zcl_gestor_alquileres_12=>crear_alquiler( i_titulo = 'Matrix' i_socio = 'Fran' ).

    out->write( '  2) Crear un alquiler de "Dune" para el socio "Jesús", guardando el ID devuelto.' ).
    DATA(lv_alquiler_2) = zcl_gestor_alquileres_12=>crear_alquiler( i_titulo = 'Dune' i_socio = 'Jesus' ).
    out->write( |\n| ).

    out->write( '  3) Consultarlos y mostrar sus datos.' ).
    out->write( |\n| ).
    zcl_gestor_alquileres_12=>consultar_alquiler( EXPORTING i_id_alquiler = lv_alquiler_1
                                                  IMPORTING e_titulo = lv_titulo
                                                            e_socio = lv_socio
                                                            e_estado = lv_estado
                                                            e_encontrado = lv_encontrado ).
    IF lv_encontrado.
      out->write( |  -->Datos ID: { lv_alquiler_1 }\n     Pelicula: { lv_titulo }\n     Socio: { lv_socio }\n     Alquilado: { lv_estado }| ).
    ELSE.
      out->write( |  -->No se ha encontardo el alquiler con ID { lv_alquiler_1 }.| ).
    ENDIF.
    out->write( | \n | ).
    zcl_gestor_alquileres_12=>consultar_alquiler( EXPORTING i_id_alquiler = lv_alquiler_2
                                                  IMPORTING e_titulo = lv_titulo
                                                            e_socio = lv_socio
                                                            e_estado = lv_estado
                                                            e_encontrado = lv_encontrado ).
    IF lv_encontrado.
      out->write( |  -->Datos ID: { lv_alquiler_2 }\n     Pelicula: { lv_titulo }\n     Socio: { lv_socio }\n     Alquilado: { lv_estado }| ).
    ELSE.
      out->write( |  -->No se ha encontardo el alquiler con ID { lv_alquiler_2 }.| ).
    ENDIF.
    out->write( | \n | ).

    out->write( '  4) Marcar el primero como devuelto, y volver a consultarlo para comprobar que el estado ha cambiado.' ).
    out->write( | \n | ).
    IF zcl_gestor_alquileres_12=>devolver_alquiler( lv_alquiler_1 ).
      zcl_gestor_alquileres_12=>consultar_alquiler( EXPORTING i_id_alquiler = lv_alquiler_1
                                                IMPORTING e_titulo = lv_titulo
                                                          e_socio = lv_socio
                                                          e_estado = lv_estado
                                                          e_encontrado = lv_encontrado ).
      IF lv_encontrado.
        out->write( |  -->Datos ID: { lv_alquiler_1 }\n     Pelicula: { lv_titulo }\n     Socio: { lv_socio }\n     Alquilado: { lv_estado }| ).
      ELSE.
        out->write( |  -->No se ha encontardo el alquiler con ID { lv_alquiler_1 }.| ).
      ENDIF.
      out->write( | \n | ).
      zcl_gestor_alquileres_12=>consultar_alquiler( EXPORTING i_id_alquiler = lv_alquiler_2
                                                    IMPORTING e_titulo = lv_titulo
                                                              e_socio = lv_socio
                                                              e_estado = lv_estado
                                                              e_encontrado = lv_encontrado ).
      IF lv_encontrado.
        out->write( |  -->Datos ID: { lv_alquiler_2 }\n     Pelicula: { lv_titulo }\n     Socio: { lv_socio }\n     Alquilado: { lv_estado }| ).
      ELSE.
        out->write( |  -->No se ha encontardo el alquiler con ID { lv_alquiler_2 }.| ).
      ENDIF.
    ELSE.
        out->write( 'El alquiler no existe.' ).
    ENDIF.
    out->write( | \n | ).

    out->write( '  5) Eliminar el segundo, e intentar consultarlo de nuevo (debe indicar que ya no existe).' ).
    out->write( | \n | ).
    IF zcl_gestor_alquileres_12=>eliminar_alquiler( lv_alquiler_2 ).
      zcl_gestor_alquileres_12=>consultar_alquiler( EXPORTING i_id_alquiler = lv_alquiler_1
                                                IMPORTING e_titulo = lv_titulo
                                                          e_socio = lv_socio
                                                          e_estado = lv_estado
                                                          e_encontrado = lv_encontrado ).
      IF lv_encontrado.
        out->write( |  -->Datos ID: { lv_alquiler_1 }\n     Pelicula: { lv_titulo }\n     Socio: { lv_socio }\n     Alquilado: { lv_estado }| ).
      ELSE.
        out->write( |  -->No se ha encontardo el alquiler con ID { lv_alquiler_1 }.| ).
      ENDIF.
      out->write( | \n | ).
      zcl_gestor_alquileres_12=>consultar_alquiler( EXPORTING i_id_alquiler = lv_alquiler_2
                                                    IMPORTING e_titulo = lv_titulo
                                                              e_socio = lv_socio
                                                              e_estado = lv_estado
                                                              e_encontrado = lv_encontrado ).
      IF lv_encontrado.
        out->write( |  -->Datos ID: { lv_alquiler_2 }\n     Pelicula: { lv_titulo }\n     Socio: { lv_socio }\n     Alquilado: { lv_estado }| ).
      ELSE.
        out->write( |  -->No se ha encontardo el alquiler con ID { lv_alquiler_2 }.| ).
      ENDIF.
    ELSE.
        out->write( 'El alquiler no existe.' ).
    ENDIF.

  ENDMETHOD.
ENDCLASS.
