CLASS zcl_test_chiringuito_12 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_test_chiringuito_12 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
*1. Crear un chiringuito de bebidas.
    out->write( '1. Crear un chiringuito de bebidas "Punta Beach".' ).
    DATA(lo_bebidas) = NEW zcl_chiringuito_bebidas_12( 'Punta Beach' ).
*2. Intentar vender por 1,00€ (debería rechazarse, por debajo del mínimo).
    out->write( '2. Intentar vender por 1,00€ (debería rechazarse, por debajo del mínimo).' ).
    DATA(lv_venta) = lo_bebidas->vender( '1.00' ).
    IF lv_venta.
        out->write( '-->Se ha realizado la venta.' ).
    ELSE.
        out->write( '-->No se ha realizado la venta. Importe demasiado bajo.' ).
    ENDIF.
*3. Vender por 3,50€ (debería aceptarse).
    out->write( '3. Vender por 3,50€ (debería aceptarse).' ).
    lv_venta = lo_bebidas->vender( '3.50' ).
    IF lv_venta.
        out->write( '-->Se ha realizado la venta.' ).
    ELSE.
        out->write( '-->No se ha realizado la venta. Importe demasiado bajo.' ).
    ENDIF.
*4. Consultar y mostrar su recaudación y su comisión (debería salir el 10%, heredado sin cambios).
    out->write( '4. Consultar y mostrar su recaudación y su comisión (debería salir el 10%, heredado sin cambios).' ).
    data(lv_recaudacion) = lo_bebidas->consultar_recaudacion(  ).
    data(lv_comision) = lo_bebidas->calcular_comision_ayuntamiento( ).
    out->write( |-->La recaudación del día es { lv_recaudacion } € y la comision del ayuntamiento es { lv_comision } €.| ).
*5. Crear un alquiler de hamacas.
    out->write( '5. Crear un alquiler de hamacas "Aloha Maca".' ).
    DATA(lo_hamaca) = new zcl_alquiler_hamacas_12( 'Aloha Maca' ).
*6. Vender (alquilar) por 8,00€ (usando el método heredado sin redefinir, debería aceptarse sin ninguna condición especial de mínimo).
    out->write( '6. Vender (alquilar) por 8,00€.' ).
    lo_hamaca->vender( '8.00' ).
*7. Consultar y mostrar su recaudación y su comisión — aquí debería verse claramente que sale el *20%*, distinto al chiringuito de bebidas, a pesar de ser el mismo método heredado del mismo padre.
    out->write( '7. Consultar y mostrar su recaudación y su comisión.' ).
    lv_recaudacion = lo_hamaca->consultar_recaudacion(  ).
    lv_comision = lo_hamaca->calcular_comision_ayuntamiento( ).
    out->write( |-->La recaudación del día es { lv_recaudacion } € y la comision del ayuntamiento es { lv_comision } €.| ).
  ENDMETHOD.
ENDCLASS.
