CLASS zcl_chiringuito_bebidas_12 DEFINITION
  PUBLIC
  INHERITING FROM zcl_chiringuito_12
  FINAL
  CREATE PUBLIC .
*- Debe *redefinir vender, añadiendo esa condición mínima antes de aceptar la venta. Si el importe es menor de 1,50€,
*  no se suma nada y el método debe devolver (RETURNING) un abap_bool indicando si la venta se realizó o no.
*  (Ojo: esto implica que también tenéis que cambiar la firma con RETURNING respecto al padre — pensad si eso es posible
*  o no con REDEFINITION, y si hace falta ajustar el método del padre desde el principio para que ya lleve ese RETURNING
*  desde el diseño original.)
*- No toca calcular_comision_ayuntamiento — hereda la del 10% tal cual.
*- Añade además un método propio, anadir_hielo, sin parámetros ni lógica obligatoria (podéis dejarlo vacío o con un simple out->write).

  PUBLIC SECTION.
    METHODS:
        vender REDEFINITION,
        anadir_hielo RETURNING VALUE(rv_hielo) TYPE string.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_chiringuito_bebidas_12 IMPLEMENTATION.
  METHOD vender.
    rv_venta = abap_false.
    if i_importe >= '1.50'.
        rv_venta = super->vender( i_importe ).
    ENDIF.
*  PARA NO TENER QUE CAMBIAR EL PADRE
*  METHOD vender2.
*    rv_venta = abap_false.
*    if i_importe >= '1.50'.
*        rv_venta = super->vender( i_importe ).
*    ENDIF.
*  ENDMETHOD.
  ENDMETHOD.



  METHOD anadir_hielo.
    rv_hielo = 'Se le añade hielo a la bebida.'.
  ENDMETHOD.

ENDCLASS.
