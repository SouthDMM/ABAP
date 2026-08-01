CLASS zcl_notificacion_carta_12 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES zif_notificable_12.

    METHODS constructor IMPORTING i_direccion_cliente TYPE string.

  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA direccion_cliente TYPE string.
ENDCLASS.



CLASS zcl_notificacion_carta_12 IMPLEMENTATION.

  METHOD zif_notificable_12~consultar_coste_envio.
    rv_coste = '1.20'.
  ENDMETHOD.

  METHOD zif_notificable_12~notificar.

  ENDMETHOD.

  METHOD constructor.
    direccion_cliente = i_direccion_cliente.
  ENDMETHOD.

ENDCLASS.
