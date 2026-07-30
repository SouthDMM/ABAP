CLASS zcl_bodegas_12 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_bodegas_12 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

*  ### Bloque 0 — Declaración de variables
*" === DECLARACIÓN DE VARIABLES ===
* Declarad aqtuí una work area de tipo zbodegas_00 y una tabla interna para los listados.

    DATA:
      ls_bodega  TYPE zbodegas_12,
      lt_bodegas TYPE TABLE OF zbodegas_12.

*### Bloque 1 — CREATE: Insertar bodegas
*" === 1. CREATE: Insertando bodegas ===
*Insertad *al menos 3 bodegas* distintas (podéis usar los datos de la Parte 6). Probad tanto con la sintaxis
*clásica campo a campo como, en alguna de ellas, con VALUE #( ... ).

*| id_bodega | nombre | denominacion | tipo_vino | anyo_fundacion | precio_botella |
*|---|---|---|---|---|---|
*| BOD001 | Bodegas Marqués de Rioja | RI | TI | 1902 | 12.50 |
*| BOD002 | Pazo do Mar | RS | BL | 1978 | 9.90 |
*| BOD003 | Finca Priorat Alta | PR | TI | 1995 | 22.00 |

    ls_bodega = VALUE #( id_bodega = 'BOD001' nombre = 'Bodegas Marqués de Rioja' denominacion = 'RI'
    tipo_vino = 'TI' anyo_fundacion = '1902' precio_botella = '12.50' moneda = 'EUR' ).

    INSERT zbodegas_12 FROM @ls_bodega.

    IF sy-subrc = 0.
      out->write( |La bodega { ls_bodega-nombre } se ha insertado correctamente.| ).
    ELSE.
      out->write( |La bodega { ls_bodega-nombre } no se ha añadido.| ).
    ENDIF.

    ls_bodega = VALUE #( id_bodega = 'BOD002' nombre = 'Pazo do Mar' denominacion = 'RS'
    tipo_vino = 'BL' anyo_fundacion = '1978' precio_botella = '9.90' moneda = 'EUR' ).

    INSERT zbodegas_12 FROM @ls_bodega.

    IF sy-subrc = 0.
      out->write( |La bodega { ls_bodega-nombre } se ha insertado correctamente.| ).
    ELSE.
      out->write( |La bodega { ls_bodega-nombre } no se ha añadido.| ).
    ENDIF.

    ls_bodega-id_bodega = 'BOD003'.
    ls_bodega-nombre = 'Finca Priorat Alta'.
    ls_bodega-denominacion = 'PR'.
    ls_bodega-tipo_vino = 'TI'.
    ls_bodega-anyo_fundacion = '1995'.
    ls_bodega-precio_botella = '22.00'.
    ls_bodega-moneda = 'EUR'.


    INSERT zbodegas_12 FROM @ls_bodega.

    IF sy-subrc = 0.
      out->write( |La bodega { ls_bodega-nombre } se ha insertado correctamente.| ).
    ELSE.
      out->write( |La bodega { ls_bodega-nombre } no se ha añadido.| ).
    ENDIF.

  ENDMETHOD.

ENDCLASS.
