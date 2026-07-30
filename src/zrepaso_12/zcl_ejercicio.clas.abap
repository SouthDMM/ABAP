CLASS zcl_ejercicio DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_ejercicio IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

*  ### 1️⃣ "El cliente que cambia de ciudad"
*Recupera con SELECT SINGLE el registro completo del cliente 000555 de /DMO/CUSTOMER. Muéstralo con out->write().
*Después, modifica su campo city a 'SEVILLA' usando UPDATE ... SET. Vuelve a hacer el SELECT SINGLE y comprueba que el
*cambio se ha aplicado.
*
**Pasos:* 1) SELECT SINGLE + write · 2) UPDATE con SET · 3) comprobar sy-subrc · 4) SELECT SINGLE otra vez para verificar.

*    SELECT SINGLE FROM zcliente_12
*    FIELDS *
*    WHERE cliente_id = '0004'
*    INTO @DATA(ls_cliente).
*
*    out->write( ls_cliente ).
*
*    UPDATE zcliente_12
*    SET zcliente_12~nombre = 'Antonio Sanchez', zcliente_12~ciudad = 'Huelva'
*    WHERE zcliente_12~cliente_id = @ls_cliente-cliente_id.
*    IF sy-subrc = 0.
*      out->write( 'El cliente se ha actualizado correctamente.' ).
*    ELSE.
*      out->write( 'El cliente no se ha actualizado.' ).
*    ENDIF.
*
*    SELECT SINGLE FROM zcliente_12
*    FIELDS *
*    WHERE cliente_id = '0004'
*    INTO @ls_cliente.
*
*    out->write( ls_cliente ).
**********************************************************************

*### 2️⃣ "Pedido nuevo para un cliente existente"
*Elige un cliente_id que ya exista en ZCLIENTE_XX (compruébalo con Data Preview). Inserta una fila nueva en ZPEDIDO_XX con INSERT,
* usando ese cliente_id, un pedido_id que no exista todavía ('0016'), y datos inventados de producto e importe.
*Después haz un JOIN ZPEDIDO_XX + ZCLIENTE_XX filtrando por ese pedido_id para comprobar que aparece con el nombre del cliente correcto.
*
**Pasos:* 1) verificar cliente_id con Data Preview · 2) INSERT con VALUES · 3) comprobar sy-subrc · 4) SELECT con JOIN para verificar.

*    DATA ls_pedido TYPE zpedido_12.
*
*    ls_pedido = VALUE #( pedido_id = '0016' cliente_id = '0006' producto = 'Altavoces' importe = '45.00'  fecha = '20260228' ).
*    INSERT zpedido_12 FROM @ls_pedido.
*
*    IF sy-subrc = 0.
*      out->write( 'El pedido se ha añadido correctamente.' ).
*      SELECT FROM zpedido_12 AS ped
*         INNER JOIN zcliente_12 AS cli
*            ON ped~cliente_id = cli~cliente_id
*      FIELDS *
*      WHERE ped~pedido_id  = @ls_pedido-pedido_id
*      INTO TABLE @DATA(lt_pedidos).
*      out->write( lt_pedidos ).
*    ELSE.
*      out->write( 'El pedido no se ha añadido.' ).
*    ENDIF.
*

**********************************************************************
* ### 3️⃣ "El pedido que ya no existe"
*Elige un pedido_id de ZPEDIDO_XX cualquiera (por ejemplo '0015'). Bórralo con DELETE. Después,
*intenta hacer el mismo JOIN de ZPEDIDO_XX + ZCLIENTE_XX que hicisteis antes y comprueba que ese pedido
* ya no aparece en el resultado, aunque el cliente al que pertenecía sigue existiendo en ZCLIENTE_XX.
*
**Pasos:* 1) SELECT SINGLE antes de borrar · 2) DELETE · 3) comprobar sy-subrc · 4) JOIN para comprobar que el
*pedido desapareció pero el cliente sigue ahí.

*    SELECT SINGLE FROM zpedido_12
*    FIELDS *
*    WHERE pedido_id = '0015'
*    INTO @DATA(ls_pedido3).
*
*    IF sy-subrc = 0.
*      out->write( ls_pedido3 ).
*
*      DELETE FROM zpedido_12
*      WHERE zpedido_12~pedido_id = @ls_pedido3-pedido_id.
*      IF sy-subrc = 0.
*        out->write( 'El pedido se ha eliminado correctamente.' ).
*      ELSE.
*        out->write( 'El pedido no se ha eliminado.' ).
*      ENDIF.
*    ELSE.
*      out->write( 'El pedido no existe.' ).
*    ENDIF.
*
*    SELECT FROM zpedido_12 AS ped
*            INNER JOIN zcliente_12 AS cli
*                ON ped~cliente_id = cli~cliente_id
*        FIELDS *
*        INTO TABLE @DATA(lt_pedidos3).
*    out->write( lt_pedidos3 ).
**********************************************************************
*### 4️⃣ "Sube el importe a un cliente concreto"
*Usando UPDATE ... WHERE, sube un 10% el importe de todos los pedidos del cliente '0001'. Antes y después, haz un SELECT con
*SUM( importe ) filtrado por ese cliente_id para comprobar visualmente que el total ha subido.
*

**Pasos:* 1) SELECT con SUM antes · 2) UPDATE con cálculo importe = importe * '1.1' · 3) SELECT con SUM después · 4) comparar.4

*-----------OPCION PARA IMPORTE-------------------
* DATA lv_mult TYPE p DECIMALS 4.
*    lv_mult = 1 / '1.10'.
*
*    UPDATE zpedido_12
*    SET importe = division( importe, @lv_mult, 2 )
*    WHERE cliente_id = '0001'.
*------------------------------------------------------
*    SELECT SINGLE FROM zpedido_12
*    FIELDS SUM( importe )
*    WHERE cliente_id = '0001'
*    INTO @DATA(lv_suma).
*
*    IF sy-subrc = 0.
*      out->write( |La suma es { lv_suma }| ).
*
*      " 1. Selección con declaración de tabla interna en línea
*      SELECT * FROM zpedido_12
*        WHERE cliente_id = '0001'
*        INTO TABLE @DATA(lt_pedidos).
*
*      IF sy-subrc = 0.
*
*        " 2. Modificación usando asignación por referencia (FIELD-SYMBOL en línea)
*        LOOP AT lt_pedidos ASSIGNING FIELD-SYMBOL(<fs_importe>).
*          <fs_importe>-importe = <fs_importe>-importe * '1.1'.
*        ENDLOOP.
*
*        " 3. Actualización masiva en la base de datos
*        UPDATE zpedido_12 FROM TABLE @lt_pedidos.
*
*        IF sy-subrc = 0.
*          out->write( 'Registros actualizados con éxito.' ).
*          SELECT SINGLE FROM zpedido_12
*            FIELDS SUM( importe )
*            WHERE cliente_id = '0001'
*            INTO @DATA(lv_suma2).
*          out->write( |Importe inicial: { lv_suma } Importe final (+ 10%):{ lv_suma2 }| ).
*        ELSE.
*          out->write( 'El importe no se ha incrementado.' ).
*        ENDIF.
*
*      ENDIF.
*    ELSE.
*      out->write( 'El cliente no existe.' ).
*    ENDIF.
**********************************************************************
*### 5️⃣ "El cliente fantasma"
*Intenta insertar un pedido en ZPEDIDO_XX con un cliente_id que *no exista* en ZCLIENTE_XX (por ejemplo '9999').
*Comprueba con un SELECT SINGLE sobre ZCLIENTE_XX que ese código no existe, y razona (sin necesidad de código extra)
*qué pasaría luego con un JOIN ZPEDIDO_XX + ZCLIENTE_XX con esa fila — ¿en qué tipo de JOIN desaparecería y en cuál se
*quedaría con huecos vacíos?

*Pasos:* 1) SELECT SINGLE cliente_id inventado → comprobar que no existe ·
*2) INSERT pedido igualmente ·
*3) responder la pregunta de INNER vs LEFT OUTER JOIN.

*    DATA ls_pedido TYPE zpedido_12.
*
*    ls_pedido = VALUE #( pedido_id = '0017' cliente_id = '0100' producto = 'Router'
*    importe = '175.00'  fecha = '20260119' ).
*
*    INSERT zpedido_12 FROM @ls_pedido.

*    SELECT SINGLE
*    FROM zcliente_12
*    FIELDS *
*    WHERE cliente_id = '0100'
*    INTO @DATA(aux).
*
*    IF sy-subrc <> 0.
*      out->write( 'Cliente no encontrado.' ).
*      out->write( '' ).
*      out->write( 'INNER JOIN' ).
*
*      SELECT FROM zpedido_12 AS ped
*        INNER JOIN zcliente_12 AS cli
*            ON ped~cliente_id = cli~cliente_id
*      FIELDS *
*      WHERE ped~cliente_id  = '0100'
*      INTO TABLE @DATA(lt_tabla1).
*
*      out->write( lt_tabla1 ).
*
*      out->write( 'LEFT OUTER JOIN' ).
*      SELECT FROM zpedido_12 AS ped
*        LEFT OUTER JOIN zcliente_12 AS cli
*            ON ped~cliente_id = cli~cliente_id
*      FIELDS *
*      WHERE ped~cliente_id  = '0100'
*      INTO TABLE @DATA(lt_tabla2).
*
*      out->write( lt_tabla2 ).
*
*    ELSE.
*      out->write( 'Se ha encontrado el cliente.' ).
*    ENDIF.
**********************************************************************

*### 6️⃣ "El cliente que más ha gastado"
*Averigua qué cliente ha gastado más dinero en total sumando el importe de todos sus pedidos en ZPEDIDO_XX, y
*muestra su nombre completo (no solo el cliente_id).

    SELECT FROM zpedido_12 AS ped
        INNER JOIN zcliente_12 AS cli
            ON ped~cliente_id = cli~cliente_id
    FIELDS cli~nombre, SUM( ped~importe ) AS Total
    GROUP BY cli~nombre
    ORDER BY total DESCENDING
    INTO TABLE @DATA(lt_mas_gastado).

    READ TABLE lt_mas_gastado INTO DATA(aux) INDEX 1.
    if sy-subrc = 0.
        out->write( aux ).
    else.
        out->write( 'No se han encontrado registros.' ).
    endif.

**********************************************************************
*### 7️⃣ "Cambia de ciudad a todos los clientes de Huelva"
*Actualiza el campo ciudad de todos los clientes que vivan actualmente en 'Huelva' para que pasen a 'Sevilla'.
*Después, comprueba con una consulta que combine ZCLIENTE_XX + ZPEDIDO_XX que esos clientes siguen teniendo todos sus
*pedidos intactos (que el UPDATE no ha tocado nada que no debía).

*      UPDATE zcliente_12
*      SET ciudad = 'Huelva'
*      WHERE ciudad = 'Sevilla'.
*      if sy-subrc = 0.
*        out->write( 'Datos actualizados.' ).
*        SELECT FROM zpedido_12 AS ped
*            inner JOIN zcliente_12 AS cli
*            ON ped~cliente_id = cli~cliente_id
*        FIELDS *
*        INTO table @DATA(lt_onuba).
*        out->write( lt_onuba ).
*      else.
*        out->write( 'No se ha actualizado ningún dato.' ).
*      endif.

**********************************************************************
*### 8️⃣ "El producto más pedido"
*Sin darte más pistas: dinos cuál es el producto que más veces aparece en ZPEDIDO_XX, y cuántas veces se ha pedido.

* SELECT FROM zpedido_12 AS ped
*        INNER JOIN zcliente_12 AS cli
*            ON ped~cliente_id = cli~cliente_id
*    FIELDS ped~producto, count( ped~producto ) AS Total
*    GROUP BY ped~producto
*    ORDER BY total DESCENDING
*    INTO TABLE @DATA(lt_mas_consumido).
*
*      READ TABLE lt_mas_consumido INTO DATA(aux) INDEX 1.
*      out->write( aux ).
*      out->write( lt_mas_consumido ).

**********************************************************************

*### 9️⃣ "Borra un pedido y comprueba el rastro"
*Elige un pedido_id de ZPEDIDO_XX, bórralo, y luego construye una consulta que demuestre que el cliente al que pertenecía
*ese pedido sigue existiendo en ZCLIENTE_XX, aunque ese pedido concreto ya no esté. Piensa bien qué tablas necesitas relacionar
*y con qué claves.

*    DELETE FROM zpedido_12
*    WHERE pedido_id = '0004'.

**********************************************************************
*### 🔟 "El resumen completo de un cliente"
*Elige un cliente cualquiera y construye, tú solo, la consulta que junte: nombre del cliente, ciudad, todos sus
*pedidos (producto, importe, fecha), y el total gastado. Tienes que decidir si necesitas uno o varios pasos, y
*con qué claves relacionar las tablas.

*    SELECT FROM zpedido_12 AS ped
*           INNER JOIN zcliente_12 AS cli
*               ON ped~cliente_id = cli~cliente_id
*           INNER JOIN zpedido_12 AS ped2
*               ON ped~cliente_id = ped2~cliente_id
*       FIELDS cli~nombre, cli~ciudad, ped~producto, ped~importe, ped~fecha, SUM( ped2~importe ) AS Total
*       WHERE cli~cliente_id = '0001'
*       GROUP BY cli~nombre, cli~ciudad, ped~producto, ped~importe, ped~fecha
*       INTO TABLE @DATA(lt_resumen).
*    if sy-subrc = 0.
*        out->write( lt_resumen ).
*    else.
*        out->write( 'No se ha encontrado el historial de este cliente.' ).
*    ENDIF.

  ENDMETHOD.
ENDCLASS.
