CLASS zcl_test_ascensor_12 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_test_ascensor_12 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

*  *Clase de test:* cread un ascensor para un edificio de 10 plantas, peso máximo 400 kg, y probad esta secuencia
*   mostrando el estado tras cada paso:
*1. Entran 300 kg (debería aceptarse).
*2. Intentan entrar 150 kg más (superaría el máximo → debería bloquearse, sin sumar esos 150).
*3. Intentan subir a la planta 5 (debería fallar, está bloqueado).
*4. Se vacía el ascensor.
*5. Suben a la planta 5 (ahora sí debería funcionar).
*6. Intentan subir a la planta 15 (debería fallar, se sale del rango del edificio).

DATA:
    lv_planta_actual TYPE i,
    lv_peso_actual TYPE i,
    lv_bloqueado.

DATA(lo_ascensor) = NEW zcl_ascensor_12( i_peso_max = 400 i_planta_max = 10 ).

out->write( ' Crear un ascensor para un edificio de 10 plantas y peso máximo 400 kg. ' ).
out->write( ' ---------------------------------------------------------------------- ' ).
lo_ascensor->consultar_estado( IMPORTING e_planta_actual = lv_planta_actual e_peso_actual = lv_peso_actual e_bloqueado = lv_bloqueado  ).
out->write( | El ascensor se encuentra en la planta { lv_planta_actual }, sus ocupantes pesan { lv_peso_actual } kilos y { lo_ascensor->movimiento( ) }.\n| ).
out->write( ' 1. Entran 300 kg (debería aceptarse). ' ).
lo_ascensor->entrar_peso( 300 ).
lo_ascensor->consultar_estado( IMPORTING e_planta_actual = lv_planta_actual e_peso_actual = lv_peso_actual e_bloqueado = lv_bloqueado  ).
out->write( | El ascensor se encuentra en la planta { lv_planta_actual }, sus ocupantes pesan { lv_peso_actual } kilos y { lo_ascensor->movimiento( ) }.\n| ).
out->write( ' 2. Intentan entrar 150 kg más (superaría el máximo → debería bloquearse, sin sumar esos 150). ' ).
lo_ascensor->entrar_peso( 150 ).
lo_ascensor->consultar_estado( IMPORTING e_planta_actual = lv_planta_actual e_peso_actual = lv_peso_actual e_bloqueado = lv_bloqueado  ).
out->write( | El ascensor se encuentra en la planta { lv_planta_actual }, sus ocupantes pesan { lv_peso_actual } kilos y { lo_ascensor->movimiento( ) }.\n| ).
out->write( ' 3. Intentan subir a la planta 5 (debería fallar, está bloqueado). ' ).
lo_ascensor->subir_a_planta( 5 ).
lo_ascensor->consultar_estado( IMPORTING e_planta_actual = lv_planta_actual e_peso_actual = lv_peso_actual e_bloqueado = lv_bloqueado  ).
out->write( | El ascensor se encuentra en la planta { lv_planta_actual }, sus ocupantes pesan { lv_peso_actual } kilos y { lo_ascensor->movimiento( ) }.\n| ).
out->write( ' 4. Se vacía el ascensor. ' ).
lo_ascensor->vaciar(  ).
lo_ascensor->consultar_estado( IMPORTING e_planta_actual = lv_planta_actual e_peso_actual = lv_peso_actual e_bloqueado = lv_bloqueado  ).
out->write( | El ascensor se encuentra en la planta { lv_planta_actual }, sus ocupantes pesan { lv_peso_actual } kilos y { lo_ascensor->movimiento( ) }.\n| ).
out->write( ' 5. Suben a la planta 5 (ahora sí debería funcionar). ' ).
lo_ascensor->subir_a_planta( 5 ).
lo_ascensor->consultar_estado( IMPORTING e_planta_actual = lv_planta_actual e_peso_actual = lv_peso_actual e_bloqueado = lv_bloqueado  ).
out->write( | El ascensor se encuentra en la planta { lv_planta_actual }, sus ocupantes pesan { lv_peso_actual } kilos y { lo_ascensor->movimiento( ) }.\n| ).
out->write( ' 6. Intentan subir a la planta 15 (debería fallar, se sale del rango del edificio). ' ).
lo_ascensor->subir_a_planta( 15 ).
lo_ascensor->consultar_estado( IMPORTING e_planta_actual = lv_planta_actual e_peso_actual = lv_peso_actual e_bloqueado = lv_bloqueado  ).
out->write( | El ascensor se encuentra en la planta { lv_planta_actual }, sus ocupantes pesan { lv_peso_actual } kilos y { lo_ascensor->movimiento( ) }.\n| ).

  ENDMETHOD.
ENDCLASS.
