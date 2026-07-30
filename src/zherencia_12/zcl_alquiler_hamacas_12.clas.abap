CLASS zcl_alquiler_hamacas_12 DEFINITION
  PUBLIC
  INHERITING FROM zcl_chiringuito_12
  FINAL
  CREATE PUBLIC .
*- Debe *redefinir calcular_comision_ayuntamiento*, cambiando el porcentaje al 20%. Pensad si os conviene
*  reutilizar super->calcular_comision_ayuntamiento( ) de alguna forma ingeniosa (pista: el resultado del
*  padre ya os da el 10%... ¿cómo llegaríais al 20% a partir de eso, sin repetir el cálculo desde cero?),
*  o si preferís calcularlo directamente vosotros con vuestro propio porcentaje.
*- No toca vender — hereda el comportamiento del padre tal cual (cualquier importe mayor que 0 se acepta).
*- Añade además un método propio, reservar_sombrilla, recibe un número de sombrilla (IMPORTING), sin
*  lógica obligatoria más allá de guardarlo o mostrarlo (vosotros decidís el nivel de detalle).

  PUBLIC SECTION.
    METHODS:
        calcular_comision_ayuntamiento REDEFINITION,
        reservar_sombrilla IMPORTING i_sombrillas TYPE i RETURNING VALUE(rv_reservas) TYPE string.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_alquiler_hamacas_12 IMPLEMENTATION.
  METHOD calcular_comision_ayuntamiento.
    rv_importe = recaudacion * '0.2'.
  ENDMETHOD.

  METHOD reservar_sombrilla.
    rv_reservas = 'Se han reservado ' + i_sombrillas + ' sombrillas.'.
  ENDMETHOD.

ENDCLASS.
