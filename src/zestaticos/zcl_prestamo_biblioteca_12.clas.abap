CLASS zcl_prestamo_biblioteca_12 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    CLASS-DATA:
      total_prestamos_realizados TYPE i, " se incrementa cada vez que se crea un préstamo nuevo.
      prestamos_pendientes       TYPE i. " sube al crear un préstamo, y baja cuando se marca como devuelto.

    CLASS-METHODS:
        consultar_total_prestamos RETURNING VALUE(rv_total_prestamos_realizados) TYPE i,
        consultar_pendientes RETURNING VALUE(rv_prestamos_pendientes) TYPE i.

     METHODS:
        constructor IMPORTING i_nombre_socio TYPE string
                                     i_titulo_libro TYPE string,
        marcar_devueltos,
        consultar_datos EXPORTING e_nombre_socio TYPE string
                                  e_titulo_libro TYPE string
                                  e_devuelto TYPE abap_bool.
*- Atributos privados: nombre del socio (string), título del libro (string), y si ya ha sido devuelto (abap_bool).
*- Constructor: recibe nombre del socio y título del libro. El estado de devuelto arranca en abap_false. Aquí es donde tenéis que tocar también los dos contadores estáticos (sumar 1 a cada uno).

  PROTECTED SECTION.
  PRIVATE SECTION.
    data:
        nom_socio TYPE string,
        titulo_libro TYPE string,
        devuelto TYPE abap_bool.
ENDCLASS.



CLASS zcl_prestamo_biblioteca_12 IMPLEMENTATION.

  METHOD consultar_pendientes.
    rv_prestamos_pendientes = prestamos_pendientes.
  ENDMETHOD.

  METHOD consultar_total_prestamos.
    rv_total_prestamos_realizados = total_prestamos_realizados.
  ENDMETHOD.

  METHOD constructor.
    nom_socio = i_nombre_socio.
    titulo_libro = i_titulo_libro.
    devuelto = abap_false.
    total_prestamos_realizados += 1.
      prestamos_pendientes += 1.
  ENDMETHOD.

  METHOD consultar_datos.
*- Método consultar_datos: devuelve, por EXPORTING, el nombre del socio, el título y si está devuelto.
    e_nombre_socio = nom_socio.
    e_titulo_libro = titulo_libro.
    e_devuelto = devuelto.
  ENDMETHOD.

  METHOD marcar_devueltos.
*- Método marcar_devuelto: sin parámetros. Pone el atributo de devuelto a abap_true, y *resta 1* a prestamos_pendientes (el estático)
*  pero solo si antes no estaba ya devuelto (para no restar dos veces por error si alguien llama al método dos veces).
    if devuelto = abap_false.
      devuelto = abap_true.
      prestamos_pendientes -= 1.
    ENDIF.
  ENDMETHOD.

ENDCLASS.
