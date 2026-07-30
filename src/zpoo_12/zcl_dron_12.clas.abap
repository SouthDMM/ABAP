CLASS zcl_dron_12 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
* Constructor: recibe la carga máxima. Inicializa batería a 100, carga actual a 0, modo reserva a abap_false.
    METHODS:
      constructor IMPORTING i_carga_max TYPE i,
* Método recoger_paquete: IMPORTING peso del paquete, RETURNING abap_bool (se aceptó o no).
      recoger_paquete IMPORTING i_peso_paquete TYPE i RETURNING VALUE(rv_valido) TYPE abap_bool,
* Método volar_a_cliente: sin parámetros de entrada, RETURNING abap_bool (se realizó el vuelo o no).
* Si se realiza y llevaba carga, la entrega (carga a 0) dentro del propio método.
      volar_a_cliente RETURNING VALUE(rv_envio) TYPE abap_bool,
      recargar,
*Método consultar_estado: EXPORTING batería, carga actual y modo reserva a la vez.
      consultar_estado EXPORTING e_bateria      TYPE i
                                 e_carga_actual TYPE i
                                 e_modo_reserva TYPE abap_bool.
  PROTECTED SECTION.
  PRIVATE SECTION.
* Atributos privados: batería (I, 0-100), carga máxima (I), carga actual (I), modo reserva (abap_bool).
    DATA:
      bateria      TYPE i,
      carga_max    TYPE i,
      carga_actual TYPE i,
      modo_reserva TYPE abap_bool.
ENDCLASS.



CLASS zcl_dron_12 IMPLEMENTATION.
  METHOD constructor.
    carga_max = i_carga_max.
    bateria = 100.
    carga_actual = 0.
    modo_reserva = abap_false.
  ENDMETHOD.

  METHOD recoger_paquete.
    DATA(carga_aux) = carga_actual + i_peso_paquete.
    IF carga_aux <= carga_max AND bateria >= 20.
      carga_actual = carga_aux.
      rv_valido = abap_true.
    ELSE.
      rv_valido = abap_false.
    ENDIF.
  ENDMETHOD.

  METHOD volar_a_cliente.
    IF modo_reserva = abap_false.
      IF carga_actual = 0.

        IF bateria - 5 < 0.
          rv_envio = abap_false.
        ELSE.
          bateria -= 5.
          rv_envio = abap_true.
          IF ( bateria < 10 ).
            modo_reserva = abap_true.
          ENDIF.
        ENDIF.

      ELSE.

        IF bateria - 15 < 0.
          rv_envio = abap_false.
        ELSE.
          bateria -= 15.
          rv_envio = abap_true.
          carga_actual = 0.
          IF ( bateria < 10 ).
            modo_reserva = abap_true.
          ENDIF.
        ENDIF.
      ENDIF.
    ENDIF.
  ENDMETHOD.

  METHOD consultar_estado.
    e_bateria = bateria.
    e_carga_actual = carga_actual.
    e_modo_reserva = modo_reserva.
  ENDMETHOD.

  METHOD recargar.
    bateria = 100.
  ENDMETHOD.

ENDCLASS.
