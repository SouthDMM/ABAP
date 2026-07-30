CLASS zcl_inner_join_12 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_inner_join_12 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
**********************************************************************
*    ## 📋 Ejercicio 1 — Guiado (como el anterior)
*
**"Vuelos con su avión y su aerolínea"*
*
*Con un único SELECT ... INNER JOIN entre /dmo/flight (alias f) y /dmo/carrier (alias c), muestra:
*nombre de la aerolínea, connection_id, flight_date, price, currency_code y plane_type_id. Empareja las tablas por carrier_id.
*Guarda el resultado en una tabla interna, comprueba sy-subrc y muéstralo con out->write( ).
*
*Reto extra: añade WHERE f~price > 5000 y ORDER BY f~price DESCENDING.
*
*SELECT
*from /dmo/flight AS f INNER JOIN /dmo/carrier as c
*on f~carrier_id = c~carrier_id
*fields c~name, f~connection_id, f~flight_date, f~price, f~currency_code, f~plane_type_id
*WHERE f~price > 5000
*ORDER BY f~price DESCENDING
*into table @DATA(lt_vuelos).
*
*if sy-subrc = 0.
*    out->write( lt_vuelos ).
*    out->write( |Nª de registros { lines( lt_vuelos ) }| ).
*else.
*    out->write( 'No hay registros.' ).
*endif.
*---
**********************************************************************
*## 📋 Ejercicio 2 — Semi-abierto
*
**"¿Quién reservó cada vuelo?"*
*
*Tienes las tablas /DMO/BOOKING y /DMO/CUSTOMER. Muestra, para cada reserva, el nombre y apellido del cliente junto con el travel_id, booking_id y booking_date.
*
*Tú decides: qué alias usar, qué campo es la clave de unión entre ambas tablas (pista: no es travel_id), y si necesitas algún WHERE para que el resultado tenga sentido.
*
*
*SELECT
*from /dmo/booking AS b INNER JOIN /dmo/customer as c
*on b~customer_id = c~customer_id
*fields c~first_name, c~last_name, b~travel_id, b~booking_id, b~booking_date
*into table @DATA(lt_booking).
*
*if sy-subrc = 0.
*    out->write( lt_booking ).
*    out->write( |Nª de registros { lines( lt_booking ) }| ).
*else.
*    out->write( 'No hay registros.' ).
*endif.

*---
**********************************************************************
*## 📋 Ejercicio 3 — Abierto
*
**"El itinerario completo de una reserva"*
*
*Un BOOKING no te dice directamente qué avión ni qué aerolínea vuela — solo tiene claves. Usando las tablas que hemos visto hoy (/DMO/BOOKING, /DMO/FLIGHT, /DMO/CARRIER),
*construye un SELECT con *dos JOIN encadenados* que muestre, para cada reserva: nombre de la aerolínea, connection_id, flight_date, plane_type_id y booking_id.
*
*No te doy los ON: tienes que averiguar tú qué campos conectan cada par de tablas mirando sus claves en Data Preview o en la definición de la tabla (pestaña Foreign Keys).


*SELECT
*from /dmo/booking AS b
*INNER JOIN /dmo/flight as f
*on b~carrier_id = f~carrier_id and b~connection_id = f~connection_id and b~flight_date = f~flight_date
*INNER JOIN /dmo/carrier as c
*on f~carrier_id = c~carrier_id
*fields c~name, f~connection_id, f~flight_date, f~plane_type_id, b~booking_id
*into table @DATA(lt_reserva).
*
*if sy-subrc = 0.
*    out->write( lt_reserva ).
*    out->write( |Nª de registros { lines( lt_reserva ) }| ).
*else.
*    out->write( 'No hay registros.' ).
*endif.
*
*---
*
**Nota para ti:* en el ejercicio 3, si algún grupo se atasca, la pista mínima que puedes soltar es "¿qué claves necesita FLIGHT para identificarse de forma única?
* Esas son las que tenéis que buscar en BOOKING". Eso ya les reconecta con el ejercicio manual (LOOP + READ TABLE) que hicisteis antes, y verán que el JOIN encadenado
*no es más que "lo mismo pero con dos ON en vez de dos READ TABLE".
*
**********************************************************************

*Partiendo de ID de reserva y del ID de aerolinea
*Dime que agencia de viaje vendió esa reserva
*Tablas implicadas, /dmo/agency /dmo/booking /dmo/travel

* travel - Agencia = agency_id        booking - travel = travel_id

*SELECT
*from /dmo/travel AS t
*INNER JOIN /dmo/agency as a
*on t~agency_id = a~agency_id
*INNER JOIN /dmo/booking as b
*on t~travel_id = b~travel_id
*fields a~name
**where b~booking_id = '0001' and b~customer_id = '000555' and b~carrier_id = 'AA'
*WHERE b~customer_id = '000555' and b~connection_id = '0322'
*into table @DATA(lt_reserva).
*
*if sy-subrc = 0.
*    out->write( lt_reserva ).
*    out->write( |Nª de registros { lines( lt_reserva ) }| ).
*else.
*    out->write( 'No hay registros.' ).
*endif.
**********************************************************************
*## 📋 Ejercicio 1 — Dificultad baja
*
**"¿Quién gestionó cada viaje?"*
*
*Muestra, para cada viaje registrado, el nombre de la agencia que lo gestionó junto con el travel_id, begin_date y overall_status.
*
*SELECT
*from /dmo/travel AS t
*INNER JOIN /dmo/agency as a
*on t~agency_id = a~agency_id
*fields a~name, t~travel_id, t~begin_date, t~status
*into table @DATA(lt_reserva).
*
*if sy-subrc = 0.
*    out->write( lt_reserva ).
*    out->write( |Nª de registros { lines( lt_reserva ) }| ).
*else.
*    out->write( 'No hay registros.' ).
*endif.
*---
*
*
*## 📋 Ejercicio 2 — Dificultad media
*
**"Ruta completa de cada vuelo"*
*
*Muestra, para cada vuelo, el nombre y ciudad del aeropuerto de origen y el nombre y ciudad del aeropuerto de destino, junto con
*el connection_id, flight_date y price.
*

*SELECT
*from /dmo/flight AS f
*INNER JOIN /dmo/connection as c
*on f~connection_id = c~connection_id
*inner JOIN /dmo/airport as afi
*on c~airport_from_id = afi~airport_id
*inner JOIN /dmo/airport as ati
*on c~airport_to_id = ati~airport_id
*fields afi~name as aeropuerto_origen, afi~city as ciudad_origen ,
*    ati~name as aropuerto_destino, ati~city as ciudad_destino, c~connection_id, f~flight_date, f~price
*into table @DATA(lt_reserva).
*
*if sy-subrc = 0.
*    out->write( lt_reserva ).
*    out->write( |Nª de registros { lines( lt_reserva ) }| ).
*else.
*    out->write( 'No hay registros.' ).
*endif.
*---
*
**********************************************************************
*## 📋 Ejercicio 3 — Dificultad alta
*
**"El extra que pidió cada cliente"*
*
*Muestra, para cada suplemento reservado (booking supplement), el nombre y apellido del cliente que lo pidió, el nombre de la
*categoría/tipo de suplemento, su precio, y el travel_id y booking_id correspondientes.

    SELECT FROM /dmo/booking AS boo
    INNER JOIN /dmo/travel AS tra
        ON boo~travel_id = tra~travel_id
    INNER JOIN /dmo/book_suppl AS sup
        ON boo~booking_id = sup~booking_id AND boo~travel_id = sup~travel_id
    INNER JOIN /dmo/customer AS cus
        ON tra~customer_id = cus~customer_id
    FIELDS
        cus~first_name,
        cus~last_name,
        sup~supplement_id,
        sup~price,
        boo~booking_id,
        tra~travel_id
    INTO TABLE @DATA(lt_reserva).

    IF sy-subrc = 0.
      out->write( lt_reserva ).
      out->write( |Nª de registros { lines( lt_reserva ) }| ).
      CLEAR lt_reserva.
    ELSE.
      out->write( 'No hay registros.' ).
    ENDIF.

  ENDMETHOD.
ENDCLASS.
