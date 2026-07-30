CLASS zcl_test_prestamos_12 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_test_prestamos_12 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

DATA:
    lv_nombre TYPE string,
    lv_titulo TYPE string,
    lv_devuelto type abap_bool.

out->write( '1. Antes de crear ningún préstamo, consultar y mostrar consultar_total_prestamos y consultar_pendientes (deberían salir ambos a 0).' ).
out->write( |-> consultar_total_prestamos es { zcl_prestamo_biblioteca_12=>consultar_total_prestamos( ) } y consultar_pendientes es { zcl_prestamo_biblioteca_12=>consultar_pendientes( ) }| ).
out->write( '2. Crear 3 préstamos distintos (socios y libros diferentes).' ).
data(lo_prestamo_01) = new zcl_prestamo_biblioteca_12( i_nombre_socio = 'David' i_titulo_libro = 'Caballo de troya'  ).
data(lo_prestamo_02) = new zcl_prestamo_biblioteca_12( i_nombre_socio = 'Manuel' i_titulo_libro = 'Mundo disco'  ).
data(lo_prestamo_03) = new zcl_prestamo_biblioteca_12( i_nombre_socio = 'Francisco' i_titulo_libro = 'La odisea'  ).
out->write( '3. Mostrar los datos de uno de ellos en concreto, usando consultar_datos (acceso de instancia, con ->).' ).
lo_prestamo_01->consultar_datos( IMPORTING e_nombre_socio = lv_nombre
                                           e_titulo_libro = lv_titulo
                                           e_devuelto = lv_devuelto ).
out->write( |Nombre socio: { lv_nombre } \nTitulo libro: { lv_titulo } \nDevuelto { lv_devuelto } |  ).
out->write( '4. Mostrar consultar_total_prestamos y consultar_pendientes (deberían salir ambos a 3, sin haber devuelto nada aún).' ).
out->write( |-> consultar_total_prestamos es { zcl_prestamo_biblioteca_12=>consultar_total_prestamos( ) } y consultar_pendientes es { zcl_prestamo_biblioteca_12=>consultar_pendientes( ) }| ).
out->write( '5. Marcar como devuelto uno de los tres préstamos.' ).
lo_prestamo_03->marcar_devueltos( ).
out->write( '6. Volver a mostrar consultar_total_prestamos (sigue en 3, nunca baja) y consultar_pendientes (ahora debería bajar a 2).' ).
out->write( |-> consultar_total_prestamos es { zcl_prestamo_biblioteca_12=>consultar_total_prestamos( ) } y consultar_pendientes es { zcl_prestamo_biblioteca_12=>consultar_pendientes( ) }| ).
out->write( '-------------------------------------------------------------------------------------------' ).
lo_prestamo_01->consultar_datos( IMPORTING e_nombre_socio = lv_nombre
                                           e_titulo_libro = lv_titulo
                                           e_devuelto = lv_devuelto ).
out->write( |Nombre socio: { lv_nombre } \nTitulo libro: { lv_titulo } \nDevuelto { lv_devuelto } |  ).
lo_prestamo_02->consultar_datos( IMPORTING e_nombre_socio = lv_nombre
                                           e_titulo_libro = lv_titulo
                                           e_devuelto = lv_devuelto ).
out->write( |Nombre socio: { lv_nombre } \nTitulo libro: { lv_titulo } \nDevuelto { lv_devuelto } |  ).
lo_prestamo_03->consultar_datos( IMPORTING e_nombre_socio = lv_nombre
                                           e_titulo_libro = lv_titulo
                                           e_devuelto = lv_devuelto ).
out->write( |Nombre socio: { lv_nombre } \nTitulo libro: { lv_titulo } \nDevuelto { lv_devuelto } |  ).
  ENDMETHOD.
ENDCLASS.
