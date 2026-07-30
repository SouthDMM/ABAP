CLASS zcl_test_maquina_chicles_12 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_test_maquina_chicles_12 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA(lo_chicle) = NEW zcl_maquina_chicles_12( 2 ).

*    *Clase de test:* cread una máquina con 2 chicles, y probad: comprar con 25 (debe vender, cambio 0),
*    comprar con 50 (debe vender, cambio 25), comprar con 25 otra vez cuando ya no queda stock (no debe vender, cambio 25),
*     y comprar con 10 (moneda insuficiente, no vende, cambio 10). Mostrad en consola el resultado de cada intento y el stock final
    out->write( '    --> TIENE DOS CHICLES Y CUESTAN 25 CENTIMOS. <--' ).
    out->write( '    --> Comprar con 10 centimos. 1ª Vez <--' ).
    out->write( |'    Su cambio: { lo_chicle->vender_chicle( 10 ) }  centimos. Chicles restantes: { lo_chicle->consultar_stock( ) } chicles.'| ).
    out->write( '    --> Comprar con 25 centimos. 2ª Vez <--' ).
    out->write( |'    Su cambio: { lo_chicle->vender_chicle( 25 ) }  centimos. Chicles restantes: { lo_chicle->consultar_stock( ) } chicles.'| ).
    out->write( '    --> Comprar con 50 centimos. 3ª Vez <--' ).
    out->write( |'    Su cambio: { lo_chicle->vender_chicle( 50 ) }  centimos. Chicles restantes: { lo_chicle->consultar_stock( ) } chicles.'| ).
    out->write( '    --> Comprar con 25 centimos. 4ª Vez <--' ).
    out->write( |'    Su cambio: { lo_chicle->vender_chicle( 25 ) }  centimos. Chicles restantes: { lo_chicle->consultar_stock( ) } chicles.'| ).

  ENDMETHOD.
ENDCLASS.
