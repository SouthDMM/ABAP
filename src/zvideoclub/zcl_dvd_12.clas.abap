CLASS zcl_dvd_12 DEFINITION
  PUBLIC
**********************************************************************
*Clase hija ZCL_DVD_XX (INHERITING FROM ZCL_SOPORTE_VIDEO_XX, con FINAL)

*Implementa la interfaz ZIF_RECOMENDABLE_XX.
*Atributo propio: incluye_extras (abap_bool).
*Constructor propio: recibe titulo, precio_alquiler e incluye_extras. Llama a super->constructor con
*                    los dos primeros, y guarda el tercero.
*Redefine calcular_precio_final: parte del precio calculado por el padre (usad super->calcular_precio_final( )
*                                para no repetir lógica) y, si incluye_extras = abap_true, le suma 0,50€.
*Implementa recomendar (de la interfaz): un mensaje que mencione si incluye extras o no.
**********************************************************************
  INHERITING FROM zcl_soporte_video_12
  FINAL
  CREATE PUBLIC .




  PUBLIC SECTION.

    METHODS:
      constructor IMPORTING i_titulo_dvd          TYPE string
                            i_precio_alquiler_dvd TYPE zdecimals2
                            i_incluye_extras      TYPE abap_bool,
      calcular_precio_final REDEFINITION.

    INTERFACES zif_recomendable_12.

  PROTECTED SECTION.

    DATA incluye_extras TYPE abap_bool.

  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_dvd_12 IMPLEMENTATION.


  METHOD zif_recomendable_12~recomendar.

    IF incluye_extras.
      i_recomendar = 'e incluye extras'.
    ELSE.
      i_recomendar = 'y no incluye extras'.
    ENDIF.

  ENDMETHOD.

  METHOD constructor.

    super->constructor( i_titulo = i_titulo_dvd i_precio_alquiler = i_precio_alquiler_dvd ).
    incluye_extras = i_incluye_extras.

  ENDMETHOD.

  METHOD calcular_precio_final.

    IF incluye_extras.
      rv_importe = super->calcular_precio_final( ) + '0.5'.
    ELSE.
      rv_importe = super->calcular_precio_final( ).
    ENDIF.

  ENDMETHOD.

ENDCLASS.
