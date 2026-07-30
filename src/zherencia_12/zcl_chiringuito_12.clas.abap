CLASS zcl_chiringuito_12 DEFINITION
  PUBLIC

  CREATE PUBLIC .
*Todo puesto de playa:
*- *Tiene*: un nombre, y el dinero recaudado en el día (empieza en 0).
*- *Sabe*:
*  - *vender*: recibe un importe (IMPORTING), y lo suma a la recaudación del día. Comportamiento por defecto (el del padre):
*    se acepta cualquier importe mayor que 0, sin más condiciones.
*  - *calcular_comision_ayuntamiento: sin parámetros, devuelve (RETURNING) un importe. Comportamiento por defecto del padre:
*    la comisión es siempre el **10%* de la recaudación del día.
*  - *consultar_recaudacion*: devuelve (RETURNING) la recaudación acumulada del día.
  PUBLIC SECTION.
    METHODS:
      constructor IMPORTING i_nombre TYPE string,
      vender IMPORTING i_importe TYPE zdecimals2
             RETURNING VALUE(rv_venta) TYPE abap_bool,
      calcular_comision_ayuntamiento RETURNING VALUE(rv_importe) TYPE zdecimals2,
      consultar_recaudacion RETURNING VALUE(rv_recaudacion) TYPE zdecimals2.

  PROTECTED SECTION.
    DATA:
      nombre      TYPE string,
      recaudacion TYPE zdecimals2.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_chiringuito_12 IMPLEMENTATION.

  METHOD constructor.
    nombre = i_nombre.
    recaudacion = 0.
  ENDMETHOD.

  METHOD vender.
    IF i_importe > 0.
      recaudacion += i_importe.
      rv_venta = abap_true.
    ENDIF.
  ENDMETHOD.

  METHOD calcular_comision_ayuntamiento.
    rv_importe = recaudacion * '0.1'.
  ENDMETHOD.

  METHOD consultar_recaudacion.
    rv_recaudacion = recaudacion.
  ENDMETHOD.


ENDCLASS.
