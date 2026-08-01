INTERFACE zif_notificable_12
  PUBLIC .

    METHODS:

     notificar IMPORTING i_mensaje TYPE string,

     consultar_coste_envio RETURNING VALUE(rv_coste) TYPE zdecimals2.

ENDINTERFACE.
