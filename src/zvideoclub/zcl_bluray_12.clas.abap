CLASS zcl_bluray_12 DEFINITION
  PUBLIC
**********************************************************************
*Clase hija ZCL_BLURAY_XX (INHERITING FROM ZCL_SOPORTE_VIDEO_XX, con FINAL)

*Implementa también la interfaz ZIF_RECOMENDABLE_XX.
*Atributo propio: es_version_4k (abap_bool).
*Constructor propio: recibe titulo, precio_alquiler y es_version_4k. Llama a super->constructor, guarda el tercero.
*Redefine calcular_precio_final: parte del precio del padre (super->calcular_precio_final( )) y, si es_version_4k = abap_true,
*                                lo multiplica por 1,5 (no lo suma, lo multiplica — fijaos bien en esta diferencia con el DVD).
*Implementa recomendar: un mensaje que mencione si es versión 4K o no.
**********************************************************************
  INHERITING FROM zcl_soporte_video_12
  FINAL
  CREATE PUBLIC .




  PUBLIC SECTION.

    METHODS:
      constructor IMPORTING i_titulo_bluray         TYPE string
                            i_precio_alquiler_bluray TYPE zdecimals2
                            i_es_version_4k      TYPE abap_bool,
      calcular_precio_final REDEFINITION.

    INTERFACES zif_recomendable_12 .

  PROTECTED SECTION.

    DATA es_version_4k TYPE abap_bool.

  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_bluray_12 IMPLEMENTATION.


  METHOD zif_recomendable_12~recomendar.

    IF es_version_4k.
      i_recomendar = 'y es version 4K'.
    ELSE.
      i_recomendar = 'y no es version 4K'.
    ENDIF.

  ENDMETHOD.

  METHOD constructor.

    super->constructor( i_titulo = i_titulo_bluray i_precio_alquiler = i_precio_alquiler_bluray ).
    es_version_4k = i_es_version_4k.

  ENDMETHOD.

  METHOD calcular_precio_final.

    IF es_version_4k.
      rv_importe = super->calcular_precio_final( ) * '1.5'.
    ELSE.
      super->calcular_precio_final( ).
    ENDIF.

  ENDMETHOD.

ENDCLASS.
