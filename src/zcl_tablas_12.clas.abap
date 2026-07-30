CLASS zcl_tablas_12 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_tablas_12 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
*    DATA ls_persona TYPE ZALUMNOS_12.
*
*    ls_persona-id_curso = 1.
*    ls_persona-dni = '12345678L'.
*    ls_persona-edad = 21.
*    ls_persona-nombre = 'Pepe'.
*    ls_persona-nivel = 'ME'.
*
*    INSERT zalumnos_12 from @ls_persona.
*    if sy-subrc = 0.
*      out->write( 'Se ha insertado correctamente' ).
*    else.
*      out->write( 'Error al insertar' ).
*    endif.

**********************************************************************

    "DADO UN travel_id OBTENER NOMBRE DE LA AGENCIA
*    SELECT SINGLE FROM /dmo/travel_m
*    FIELDS agency_id
*    WHERE travel_id = '00000014'
*    INTO @DATA(lv_agency).
*
*    IF sy-subrc = 0.
*      SELECT SINGLE FROM /dmo/agency
*      FIELDS name
*      WHERE agency_id = @lv_agency
*      INTO @DATA(lv_nombre).
*      IF sy-subrc = 0.
*        out->write( | El nombre de la agencia es { lv_nombre } | ).
*      ELSE.
*        out->write( 'No se ha encontrado ningúna agencia.' ).
*      ENDIF.
*    ELSE.
*      out->write( 'No se ha encontrado ningún viaje.' ).
*    ENDIF.

**********************************************************************

    "Tablas  /DMO/TRAVEL y /DMO/CUSTOMER
*    ## 📋 Enunciado: "De cada viaje, el nombre del cliente"
*
**Contexto:* la tabla /DMO/TRAVEL guarda los viajes reservados, pero solo tiene el CUSTOMER_ID (un código numérico), no el nombre del cliente.
*El nombre completo está en la tabla /DMO/CUSTOMER.
*
**Objetivo:* monta una tabla de salida que combine, para cada viaje, el nombre del cliente que lo reservó.
*
**Pasos a seguir (misma estructura que el ejercicio de FLIGHT + CARRIER):*
*
*1. Define un tipo de salida ty_salida con estos campos:
*   - first_name (de /dmo/customer-first_name)
*   - last_name (de /dmo/customer-last_name)
*   - travel_id (de /dmo/travel-travel_id)
*   - begin_date (de /dmo/travel-begin_date)
*   - total_price (de /dmo/travel-total_price)
*   - currency_code (de /dmo/travel-currency_code)

    TYPES:
      BEGIN OF ty_salida,
        first_name    TYPE /dmo/customer-first_name,
        last_name     TYPE /dmo/customer-last_name,
        travel_id     TYPE /dmo/travel-travel_id,
        begin_date    TYPE /dmo/travel-begin_date,
        total_price   TYPE /dmo/travel-total_price,
        currency_code TYPE /dmo/travel-currency_code,
      END OF ty_salida.

    DATA:
      ls_salida TYPE ty_salida,
      lt_salida TYPE TABLE OF ty_salida.
      clear lt_salida.
*
*2. Recupera *todos* los viajes de /DMO/TRAVEL (campos: customer_id, travel_id, begin_date, total_price, currency_code) en una tabla interna lt_travel.

    SELECT FROM /dmo/travel
    FIELDS customer_id, travel_id, begin_date, total_price, currency_code
    INTO TABLE @DATA(lt_travel).
*
*3. Recupera *todos* los clientes de /DMO/CUSTOMER (campos: customer_id, first_name, last_name) en una tabla interna lt_customer.

    SELECT FROM /dmo/customer
    FIELDS customer_id, first_name, last_name
    INTO TABLE @DATA(lt_customer).
*
*4. Recorre lt_travel con un LOOP, y por cada viaje busca (READ TABLE ... WITH KEY) el cliente correspondiente en lt_customer usando customer_id.
*5. Si lo encuentra (sy-subrc = 0), monta la fila de salida y añádela a la tabla final con APPEND.
*

    LOOP AT lt_travel INTO DATA(lt_travel_aux).

      READ TABLE lt_customer INTO DATA(lt_customer_aux) WITH KEY customer_id = lt_travel_aux-customer_id.

      IF sy-subrc = 0.
        ls_salida-first_name = lt_customer_aux-first_name.
        ls_salida-last_name = lt_customer_aux-last_name.
        ls_salida-travel_id = lt_travel_aux-travel_id.
        ls_salida-begin_date = lt_travel_aux-begin_date.
        ls_salida-total_price = lt_travel_aux-total_price.
        ls_salida-currency_code = lt_travel_aux-currency_code.
        APPEND ls_salida TO lt_salida.
      ELSE.
        out->write( 'No se encuentran datos.' ).
      ENDIF.

    ENDLOOP.
*

*6. Muestra el resultado con out->write( ).

    out->write( lt_salida ).
    out->write( | Nº de registros: { lines( lt_salida ) } | ).

  ENDMETHOD.
ENDCLASS.
