CLASS zcl_test_instrumentos_12 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .


  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.


CLASS zcl_test_instrumentos_12 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
*1. Crear una guitarra marca 'Yamaha' con 6 cuerdas.
*2. Crear un piano marca 'Roland', eléctrico.
    out->write( '-> Se crea una guitarra y un piano.' ).
    DATA(lo_guitarra) = NEW zcl_guitarra_12( i_marca_guitarra = 'Yamaha' i_cuerdas = 6 ).
    out->write( 'Creada guitarra YAMAHA con 6 cuerdas.' ).
    DATA(lo_piano) = NEW zcl_piano_12( i_marca_piano = 'Roland' i_electrico = abap_true ).
    out->write( 'Creado piano ROLAND ELECTRICO.' ).

*3. Intentar afinar la cuerda número 8 de la guitarra (debería fallar, no existe esa cuerda).
*4. Afinar la cuerda número 3 de la guitarra (debería funcionar).
    out->write( '-> Intenta afinar 8 cuerdas.' ).
    IF lo_guitarra->afinar_cuerdas( 8 ).
      out->write( 'Se pueden afinar 8 cuerdas.' ).
    ELSE.
      out->write( 'No se pueden afinar 8 cuerdas.' ).
    ENDIF.
    out->write( '-> Intenta afinar 3 cuerdas.' ).
    IF lo_guitarra->afinar_cuerdas( 3 ).
      out->write( 'Se pueden afinar 3 cuerdas.' ).
    ELSE.
      out->write( 'No se pueden afinar 3 cuerdas.' ).
    ENDIF.
*5. Intentar pedalear en el piano *recién creado* (debería fallar, 0 horas de uso).
*6. Registrar 2 horas de práctica en el piano, usando el método heredado del padre.
*7. Volver a intentar pedalear en el piano (ahora debería funcionar).

    out->write( '-> Intenta pedalear el piano nuevo.' ).
    IF lo_piano->pedalear(  ).
      out->write( 'Se pedalea correctamente.' ).
    ELSE.
      out->write( 'Es nuevo. No se puede pedalear' ).
    ENDIF.
    out->write( '-> Registro 2 horas de piano.' ).
    lo_piano->registrar_practica( 2 ).
    IF lo_piano->pedalear(  ).
    out->write( '-> Intenta pedalear el piano otra vez.' ).
      out->write( 'Se pedalea correctamente.' ).
    ELSE.
      out->write( 'Es nuevo. No se puede pedalear' ).
    ENDIF.

*8. Registrar 1 hora de práctica en la guitarra, usando el mismo método heredado.
*9. Consultar y mostrar las horas de uso finales de ambos instrumentos, usando el método heredado consultar_horas_uso en los dos casos.
    out->write( '-> Registro 1 hora de guitarra.' ).
    lo_guitarra->registrar_practica( 1 ).
    out->write( '-> Muestra las horas de cada instrumento.' ).
    out->write( |El piano se ha usado { lo_piano->consultar_horas_uso( ) } horas y la guitarra { lo_guitarra->consultar_horas_uso( ) } horas.| ).
  ENDMETHOD.
ENDCLASS.
