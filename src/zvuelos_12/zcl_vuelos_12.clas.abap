CLASS zcl_vuelos_12 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_vuelos_12 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

*1️.- Selecciona todos los campos y todos los registros de la tabla /DMO/FLIGHT. Muéstralos por pantalla.

*    SELECT FROM /dmo/flight
*    FIELDS *
*    into table @DATA(lt_vuelos).

*2️.- Selecciona solo los campos CARRIER_ID, CONNECTION_ID y PRICE de todos los vuelos.

*    SELECT FROM /dmo/flight
*    FIELDS carrier_id, connection_id, price
*    INTO TABLE @DATA(lt_vuelos).

*3️.- Selecciona todos los vuelos de la compañía (CARRIER_ID) LH'. Muestra CARRIER_ID, CONNECTION_ID, FLIGHT_DATE y PRICE.

*    SELECT FROM /dmo/flight
*    FIELDS carrier_id, connection_id, flight_date, price
*    WHERE carrier_id = 'LH'
*    INTO TABLE @DATA(lt_vuelos).

*4️.- Selecciona los vuelos cuyo precio (PRICE) sea superior a 5000. Muestra CARRIER_ID, CONNECTION_ID y PRICE.

*    SELECT FROM /dmo/flight
*    FIELDS carrier_id, connection_id, price
*    WHERE price > 5000
*    INTO TABLE @DATA(lt_vuelos).

*5️.- Selecciona los vuelos que usen el avión (PLANE_TYPE_ID) 'A380-800'. Muestra CARRIER_ID, CONNECTION_ID, PLANE_TYPE_ID y SEATS_MAX.

*    SELECT FROM /dmo/flight
*    FIELDS CARRIER_ID, CONNECTION_ID, PLANE_TYPE_ID, SEATS_MAX
*    WHERE plane_type_id = 'A380-800'
*    INTO TABLE @DATA(lt_vuelos).

*6️.- Selecciona los vuelos de la compañía 'AA' cuyo precio sea inferior a 1000. Muestra todos los campos.

*    SELECT FROM /dmo/flight
*    FIELDS *
*    WHERE carrier_id = 'AA' and price < 1000
*    INTO TABLE @DATA(lt_vuelos).

*7️.- Selecciona los vuelos cuyo número de asientos ocupados (SEATS_OCCUPIED) sea superior al 90% de SEATS_MAX (pista:
*puedes comparar SEATS_OCCUPIED > SEATS_MAX * '0.9'). Muestra CARRIER_ID, CONNECTION_ID, SEATS_MAX y SEATS_OCCUPIED.

*    SELECT FROM /dmo/flight
*    FIELDS CARRIER_ID, CONNECTION_ID, SEATS_MAX, SEATS_OCCUPIED
**   WHERe seats_occupied > seats_max * 0,9
*    WHERe seats_occupied > ( seats_max * division( 9, 10, 1 ) )
*    INTO TABLE @DATA(lt_vuelos).

*8️.- Selecciona los vuelos cuya moneda (CURRENCY_CODE) sea 'EUR' o 'USD', ordenados de mayor a menor precio (ORDER BY PRICE DESCENDING).

*    SELECT FROM /dmo/flight
*    FIELDS *
*    WHERE currency_code IN ( 'EUR', 'USD' )
*    order by price descending
*    INTO TABLE @DATA(lt_vuelos).

*9️.- Selecciona los vuelos de las compañías 'SQ', 'UA' o 'LH' que vuelen con el avión '767-200', ordenados por CARRIER_ID
*ascendente y luego por PRICE descendente.

*    SELECT FROM /dmo/flight
*    FIELDS *
*    WHERE carrier_id IN ( 'SQ', 'UA', 'LH' ) AND plane_type_id = '767-200'
*    order by CARRIER_ID ASCENDING, PRICE DESCENDING
*    INTO TABLE @DATA(lt_vuelos).

*10.- Selecciona los vuelos cuyo precio esté entre 2000 y 6000 (BETWEEN), que no sean de la compañía 'AA', y que tengan más
*de 200 asientos máximos (SEATS_MAX). Muestra CARRIER_ID, CONNECTION_ID, FLIGHT_DATE, PRICE y SEATS_MAX, ordenados por
*PRICE ascendente.

    SELECT FROM /dmo/flight
    FIELDS *
    WHERE  ( price BETWEEN 2000 AND 6000 ) AND carrier_id <> 'AA' AND seats_max > 200
    ORDER BY price ASCENDING
    INTO TABLE @DATA(lt_vuelos).

*FINAL
    out->write( lt_vuelos ).

    IF sy-subrc = 0.
      out->write( lt_vuelos ).
    ELSE.
      out->write( 'Datos incorrectos.' ).
    ENDIF.

  ENDMETHOD.
ENDCLASS.
