CLASS zcl_test_dron_12 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_test_dron_12 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    DATA(lo_dron) = NEW zcl_dron_12( 5 ).

    DATA:
      lv_bateria      TYPE i,
      lv_carga_actual TYPE i,
      lv_modo_reserva TYPE abap_bool.

    lo_dron->consultar_estado( IMPORTING e_bateria = lv_bateria
                                         e_carga_actual = lv_carga_actual
                                         e_modo_reserva = lv_modo_reserva ).
    out->write( | La bateria está al { lv_bateria }, la carga actual es de { lv_carga_actual } y modo reserva { lv_modo_reserva }.\n | ).
    out->write( ' 1.- Recoge paquete de 3 Kg.' ).
    IF lo_dron->recoger_paquete( 3 ).
      out->write( ' Paquete recogido.' ).
    ELSE.
      out->write( ' Paquete no recogido.' ).
    ENDIF.
    lo_dron->consultar_estado( IMPORTING e_bateria = lv_bateria
                                         e_carga_actual = lv_carga_actual
                                         e_modo_reserva = lv_modo_reserva ).
    out->write( | La bateria está al { lv_bateria }, la carga actual es de { lv_carga_actual } y modo reserva { lv_modo_reserva }.\n | ).
    DO 7 TIMES.
      out->write( ' 2*.- Vuela y entrega.' ).
      IF lo_dron->volar_a_cliente( ).
        out->write( ' Vuela al cliente.' ).
      ELSE.
        out->write( ' No puede volar.' ).
      ENDIF.
      lo_dron->consultar_estado( IMPORTING e_bateria = lv_bateria
                                           e_carga_actual = lv_carga_actual
                                           e_modo_reserva = lv_modo_reserva ).
      out->write( | La bateria está al { lv_bateria }, la carga actual es de { lv_carga_actual } y modo reserva { lv_modo_reserva }.\n | ).
    ENDDO.
    lo_dron->recargar( ).
    out->write( ' 3.- Vuela y entrega tras recargar.' ).
      IF lo_dron->volar_a_cliente( ).
        out->write( ' Vuela al cliente.' ).
      ELSE.
        out->write( ' No puede volar.' ).
      ENDIF.
      lo_dron->consultar_estado( IMPORTING e_bateria = lv_bateria
                                           e_carga_actual = lv_carga_actual
                                           e_modo_reserva = lv_modo_reserva ).
      out->write( | La bateria está al { lv_bateria }, la carga actual es de { lv_carga_actual } y modo reserva { lv_modo_reserva }.\n | ).
    out->write( | La bateria está al { lv_bateria }, la carga actual es de { lv_carga_actual } y modo reserva { lv_modo_reserva }.\n | ).
    out->write( ' 1.- Recoge paquete de 3 Kg.' ).
    IF lo_dron->recoger_paquete( 7 ).
      out->write( ' Paquete recogido.' ).
    ELSE.
      out->write( ' Paquete no recogido.' ).
    ENDIF.
    lo_dron->consultar_estado( IMPORTING e_bateria = lv_bateria
                                         e_carga_actual = lv_carga_actual
                                         e_modo_reserva = lv_modo_reserva ).
    out->write( | La bateria está al { lv_bateria }, la carga actual es de { lv_carga_actual } y modo reserva { lv_modo_reserva }.\n | ).
  ENDMETHOD.
ENDCLASS.
