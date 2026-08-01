CLASS zcl_notificacion_sms_12 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES zif_notificable_12.

    METHODS constructor IMPORTING i_telefono_cliente TYPE string.

  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA telefono_cliente TYPE string.
ENDCLASS.



CLASS zcl_notificacion_sms_12 IMPLEMENTATION.

  METHOD zif_notificable_12~consultar_coste_envio.
    rv_coste = '0.10'.
  ENDMETHOD.

  METHOD zif_notificable_12~notificar.

  ENDMETHOD.

  METHOD constructor.
    telefono_cliente = i_telefono_cliente.
  ENDMETHOD.

ENDCLASS.
