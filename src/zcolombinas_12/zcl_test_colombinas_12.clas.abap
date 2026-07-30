CLASS zcl_test_colombinas_12 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_test_colombinas_12 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

*1. Crear una caseta, una atracción de feria (con precio 3€) y un concierto.
    data(lo_caseta) = new zcl_caseta_12( i_nombre = 'Caseta' ).
    data(lo_atraccion) = new zcl_atraccion_feria_12( i_nom_atraccion = 'Atraccion' i_precio = '3' ).
    data(lo_concierto) = new zcl_concierto_12( i_nombre = 'Concierto' ).

*2. Meter los tres objetos en *una única tabla interna* del tipo del padre (TABLE OF REF TO zcl_atraccion_00).

    DATA lt_atracciones TYPE TABLE OF REF TO zcl_atraccion_12.
    APPEND lo_caseta to lt_atracciones.
    APPEND lo_atraccion to lt_atracciones.
    APPEND lo_concierto to lt_atracciones.
*3. Recorrer la tabla con un LOOP, y para cada elemento: llamar a recibir_visitante( ) una vez, y mostrar por consola el
*   nombre (si lo tenéis como atributo) junto con el resultado de calcular_precio_entrada( ).

    LOOP AT lt_atracciones into data(ls_atraccion).
        ls_atraccion->recibir_visitante(  ).
        out->write( |Nombre: { ls_atraccion->mostrar_nombre( ) } -> Precio:{ ls_atraccion->calcular_precio_entrada( ) } | ).
    ENDLOOP.
*4. Fuera del LOOP, forzar que el concierto reciba 500 visitantes de golpe (con un bucle simple llamando 500 veces a
*   recibir_visitante( ) sobre el objeto concierto directamente, no a través de la tabla), y volver a consultar su
*   precio — comprobad que ahora sale el precio reducido.
    do 500 TIMES.
        lo_concierto->recibir_visitante( ).
    ENDDO.
    out->write( |Nombre: { lo_concierto->mostrar_nombre( ) } -> Precio:{ lo_concierto->calcular_precio_entrada( ) } -> Visitantes: { lo_concierto->consultar_visitante( ) } | ).


  ENDMETHOD.
ENDCLASS.
