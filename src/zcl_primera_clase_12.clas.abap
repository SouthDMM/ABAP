CLASS zcl_primera_clase_12 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_primera_clase_12 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
**1. (Simple)*
*Define con TYPES una estructura ty_producto con los campos nombre (texto) y precio (decimal), y una tabla tt_productos de ese tipo. Declara las
*variables correspondientes con DATA. Añade 3 productos a la tabla con APPEND. Usando LOOP AT, recorre la tabla y muestra con out->write( ) el nombre de cada producto.
*    TYPES:
*      BEGIN OF ty_producto,
*        nombre TYPE string,
*        precio TYPE p LENGTH 5 DECIMALS 2,
*      END OF ty_producto.
*
*
*    DATA:
*      ls_producto  TYPE ty_producto,
*      lt_productos TYPE  TABLE OF ty_producto.
*
*    ls_producto-nombre = 'Teclado'.
*    ls_producto-precio = '10.50'.
*    APPEND ls_producto TO lt_productos.
*    ls_producto-nombre = 'Ratón'.
*    ls_producto-precio = '6.90'.
*    APPEND ls_producto TO lt_productos.
*    ls_producto-nombre = 'Monitor'.
*    ls_producto-precio = '35.60'.
*    APPEND ls_producto TO lt_productos.
*
*    LOOP AT lt_productos INTO ls_producto.
*      out->write( ls_producto-nombre ).
*    ENDLOOP.

*-------------------------------------------------------------------------------------------------------------------------------------------------

**2. (Intermedio)*
*Define con TYPES una estructura ty_empleado con los campos nombre (texto) y salario (decimal), y una tabla tt_empleados de ese tipo. Añade 4
*empleados a la tabla con salarios distintos. Usando LOOP AT, recorre la tabla y, con un IF dentro del bucle, muestra con out->write( ) únicamente
*el nombre de los empleados cuyo salario sea mayor que 2000.

*    TYPES:
*      BEGIN OF ty_empleado,
*        nombre  TYPE string,
*        salario TYPE p LENGTH 5 DECIMALS 2,
*      END OF ty_empleado.
*
*
*    DATA:
*      ls_empleado  TYPE ty_empleado,
*      lt_empleados TYPE  TABLE OF ty_empleado.
*
*    ls_empleado-nombre = 'Luis'.
*    ls_empleado-salario = '1900.00'.
*    APPEND ls_empleado TO lt_empleados.
*    ls_empleado-nombre = 'David'.
*    ls_empleado-salario = '2200.00'.
*    APPEND ls_empleado TO lt_empleados.
*    ls_empleado-nombre = 'Antonio'.
*    ls_empleado-salario = '1750.00'.
*    APPEND ls_empleado TO lt_empleados.
*    ls_empleado-nombre = 'Jose'.
*    ls_empleado-salario = '2300.00'.
*    APPEND ls_empleado TO lt_empleados.
*
*    LOOP AT lt_empleados INTO ls_empleado.
*      IF ls_empleado-salario > 2000.
*        out->write( ls_empleado-nombre ).
*      ENDIF.
*    ENDLOOP.

*-------------------------------------------------------------------------------------------------------------------------------------------------

**3. (Difícil)*
*Define con TYPES una estructura ty_pedido con los campos id_pedido (entero), importe (decimal) y estado (texto), y una tabla tt_pedidos de ese tipo.
*Usando un DO 6 TIMES, genera pedidos donde id_pedido sea el número de vuelta, importe sea el resultado de multiplicar el número de vuelta por 45.30, y
*estado se calcule con CASE sobre el resto de dividir el número de vuelta entre 3: si el resto es 0, 'ENVIADO'; si es 1, 'PENDIENTE'; si es 2, 'CANCELADO'.
*Añade cada pedido a la tabla con APPEND. Después, usando LOOP AT, recorre toda la tabla y muestra con out->write( ) solo los pedidos cuyo estado sea 'PENDIENTE',
*junto con su importe. Al terminar el bucle, muestra también con out->write( ) cuántos pedidos en total quedaron 'PENDIENTE' (usa un contador que incrementes dentro del IF).
*    TYPES:
*      BEGIN OF ty_pedido,
*        id_pedido TYPE i,
*        importe   TYPE p LENGTH 5 DECIMALS 2,
*        estado    TYPE string,
*      END OF ty_pedido.
*
*
*    DATA:
*      ls_pedido   TYPE ty_pedido,
*      lt_pedidos  TYPE  TABLE OF ty_pedido,
*      lv_contador TYPE i.
*
*    DO 6 TIMES.
*      ls_pedido-id_pedido = sy-index.
*      ls_pedido-importe = sy-index * '45.30'.
*      DATA(aux) = ls_pedido-id_pedido MOD 3.
*      CASE aux.
*        WHEN 0.
*          ls_pedido-estado = 'ENVIADO'.
*        WHEN 1.
*          ls_pedido-estado = 'PENDIENTE'.
*        WHEN 2.
*          ls_pedido-estado = 'CANCELADO'.
*      ENDCASE.
*      APPEND ls_pedido TO lt_pedidos.
*    ENDDO.
*
*    LOOP AT lt_pedidos INTO ls_pedido.
*      IF ls_pedido-estado = 'PENDIENTE'.
*        out->write( | El ID es { ls_pedido-id_pedido }  y su importe es { ls_pedido-importe } | ).
*        lv_contador += 1.
*      ENDIF.
*    ENDLOOP.
*    out->write( | El número de pedidos pendientes es { lv_contador }| ).

*-------------------------------------------------------------------------------------------------------------------------------------------------

**1. (Fácil)*
*Declara con TYPES/DATA una estructura ty_producto con los campos nombre (texto) y precio (decimal), y su correspondiente tabla lt_producto. Añade 4 productos
*con APPEND. Usando READ TABLE, busca el producto que ocupa la *posición 2* de la tabla (INDEX). Comprueba sy-subrc y, si lo encuentra, muestra con out->write( )
*y pipes su nombre y precio; si no lo encuentra, muestra un mensaje indicándolo.
*
*    TYPES:
*      BEGIN OF ty_producto,
*        nombre TYPE string,
*        precio TYPE p LENGTH 5 DECIMALS 2,
*      END OF ty_producto.
*    DATA:
*      ls_producto TYPE ty_producto,
*      lt_producto TYPE TABLE OF ty_producto.
*
*    ls_producto-nombre = 'Teclado'.
*    ls_producto-precio = '10.50'.
*    APPEND ls_producto TO lt_producto.
*    ls_producto-nombre = 'Ratón'.
*    ls_producto-precio = '6.90'.
*    APPEND ls_producto TO lt_producto.
*    ls_producto-nombre = 'Monitor'.
*    ls_producto-precio = '35.60'.
*    APPEND ls_producto TO lt_producto.
*    ls_producto-nombre = 'Router'.
*    ls_producto-precio = '27.20'.
*    APPEND ls_producto TO lt_producto.
*
*    READ TABLE lt_producto INTO ls_producto INDEX 2.
*    IF sy-subrc = 0.
*      out->write( |El nombre del producto es { ls_producto-nombre } y su precio es { ls_producto-precio }| ).
*    ELSE.
*      out->write( 'No se ha encontrado el producto' ).
*    ENDIF.
*

*-------------------------------------------------------------------------------------------------------------------------------------------------

***2. (Intermedio)*
**Declara con TYPES/DATA una estructura ty_empleado con los campos id_empleado (entero), nombre (texto) y departamento (texto), y su tabla lt_empleado. Añade 5 empleados
**con distintos id_empleado y departamento (por ejemplo 'VENTAS', 'IT', etc.). Usando READ TABLE con WITH KEY, busca el empleado cuyo id_empleado sea 3.
**Comprueba sy-subrc: si lo encuentra, muestra su nombre y departamento con out->write( ); si no lo encuentra, muestra un aviso de que no existe ese empleado.
*
*    TYPES:
*      BEGIN OF ty_empleado,
*        id_empleado  TYPE i,
*        nombre       TYPE string,
*        departamento TYPE string,
*      END OF ty_empleado.
*    DATA:
*      ls_empleado  TYPE ty_empleado,
*      lt_empleados TYPE TABLE OF ty_empleado.
*
*    ls_empleado-id_empleado = 10.
*    ls_empleado-nombre = 'Luis'.
*    ls_empleado-departamento = 'VENTAS'.
*    APPEND ls_empleado TO lt_empleados.
*    ls_empleado-id_empleado = 20.
*    ls_empleado-nombre = 'David'.
*    ls_empleado-departamento = 'IT'.
*    APPEND ls_empleado TO lt_empleados.
*    ls_empleado-id_empleado = 30.
*    ls_empleado-nombre = 'Antonio'.
*    ls_empleado-departamento = 'FINANZAS'.
*    APPEND ls_empleado TO lt_empleados.
*    ls_empleado-id_empleado = 40.
*    ls_empleado-nombre = 'Jose'.
*    ls_empleado-departamento = 'MARKETING'.
*    APPEND ls_empleado TO lt_empleados.
*    ls_empleado-id_empleado = 50.
*    ls_empleado-nombre = 'Juan'.
*    ls_empleado-departamento = 'PRODUCTION'.
*    APPEND ls_empleado TO lt_empleados.
*
*    READ TABLE lt_empleados INTO ls_empleado WITH KEY id_empleado = 30.
*    IF sy-subrc = 0.
*      out->write( |El nombre del empleado es { ls_empleado-nombre } y su departamento es { ls_empleado-departamento }| ).
*    ELSE.
*      out->write( 'No existe el empleado' ).
*    ENDIF.
*
*-------------------------------------------------------------------------------------------------------------------------------------------------

***3. (Difícil)*
**Declara con TYPES/DATA una estructura ty_pedido con los campos id_pedido (entero), importe (decimal) y estado (texto), y su tabla lt_pedido. Usando un DO 6 TIMES,
**genera pedidos donde id_pedido sea el número de vuelta, importe sea el número de vuelta multiplicado por 50.25, y estado se calcule con CASE sobre el resto de dividir
**el número de vuelta entre 2: 'ENVIADO' si es par, 'PENDIENTE' si es impar. Añade cada uno con APPEND. Después, declara una variable entera lv_id_buscado con el valor 4,
**y usando READ TABLE con WITH KEY, busca el pedido cuyo id_pedido coincida con lv_id_buscado *y además* cuyo estado sea 'PENDIENTE' (combina ambas condiciones en la misma
**cláusula WITH KEY). Comprueba sy-subrc: si lo encuentra, muestra su importe con out->write( ); si no lo encuentra, muestra un mensaje indicando que no hay ningún pedido
** pendiente con ese ID.
*
*    TYPES:
*      BEGIN OF ty_pedido,
*        id_pedido TYPE i,
*        importe   TYPE p LENGTH 5 DECIMALS 2,
*        estado    TYPE string,
*      END OF ty_pedido.
*    DATA:
*      ls_pedido  TYPE ty_pedido,
*      lt_pedidos TYPE TABLE OF ty_pedido.
*
*    DO 6 TIMES.
*      ls_pedido-id_pedido = sy-index.
*      ls_pedido-importe = sy-index * '50.25'.
*      DATA(aux) = ls_pedido-id_pedido MOD 2.
*      CASE aux.
*        WHEN 0.
*          ls_pedido-estado = 'ENVIADO'.
*        WHEN 1.
*          ls_pedido-estado = 'PENDIENTE'.
*      ENDCASE.
*      APPEND ls_pedido TO lt_pedidos.
*    ENDDO.
*
*    DATA(lv_id_buscado) = 4.
*
*    READ TABLE lt_pedidos INTO ls_pedido WITH KEY id_pedido = lv_id_buscado estado = 'PENDIENTE'.
*    IF sy-subrc = 0.
*      out->write( |El importe del pedido es { ls_pedido-importe }| ).
*    ELSE.
*      out->write( 'No hay ningún pendiente con ese ID' ).
*    ENDIF.

*-------------------------------------------------------------------------------------------------------------------------------------------------

*1. (Simple) — La tienda de videojuegos
*Declara con TYPES/DATA una estructura ty_videojuego con los campos titulo (texto) y precio (decimal), y su tabla lt_videojuego. Añade 4 videojuegos con APPEND.
*Usando LOOP AT ... ASSIGNING, recorre la tabla y aplica una rebaja del 20% al precio de cada videojuego directamente sobre la fila original (sin usar INTO). Al
*terminar, usando un segundo LOOP AT (esta vez con INTO o declaración inline), muestra con out->write( ) y pipes el título y el nuevo precio de cada uno.

*    TYPES:
*      BEGIN OF ty_videojuego,
*        titulo TYPE string,
*        precio TYPE p LENGTH 5 DECIMALS 2,
*      END OF ty_videojuego.
*
*    DATA:
*      ls_videojuego  TYPE ty_videojuego,
*      lt_videojuegos TYPE TABLE OF  ty_videojuego.
*
*    ls_videojuego-titulo = 'Resident Evil 4'.
*    ls_videojuego-precio = '25.50'.
*    APPEND ls_videojuego TO lt_videojuegos.
*    ls_videojuego-titulo = 'The Evil Within'.
*    ls_videojuego-precio = '22.99'.
*    APPEND ls_videojuego TO lt_videojuegos.
*    ls_videojuego-titulo = 'Elden Ring'.
*    ls_videojuego-precio = '59.99'.
*    APPEND ls_videojuego TO lt_videojuegos.
*    ls_videojuego-titulo = 'God of War'.
*    ls_videojuego-precio = '40.60'.
*    APPEND ls_videojuego TO lt_videojuegos.
*
*    LOOP AT lt_videojuegos ASSIGNING FIELD-SYMBOL(<fs_videojuego>).
*      <fs_videojuego>-precio *= '0.8'.
*    ENDLOOP.
*
*    LOOP AT lt_videojuegos INTO ls_videojuego.
*      out->write( | El juego '{ ls_videojuego-titulo }' tiene un precio actual de { ls_videojuego-precio } | ).
*    ENDLOOP.

*-------------------------------------------------------------------------------------------------------------------------------------------------

*2. (Intermedio) — El equipo de una expedición
*Declara con TYPES/DATA una estructura ty_expedicionario con los campos nombre (texto), oxigeno_restante (entero) y estado (texto), y su tabla lt_expedicion.
*Añade 5 miembros del equipo con distintos niveles de oxigeno_restante (algunos altos, otros bajos), dejando estado vacío de momento. Usando LOOP AT ... ASSIGNING,
*recorre la tabla y, con un IF, actualiza el campo estado directamente sobre la fila original: si oxigeno_restante es menor que 20, asigna 'RETIRADA INMEDIATA'; en
*caso contrario, asigna 'CONTINUA'. Después, usando READ TABLE con declaración inline, busca si existe algún expedicionario concreto por nombre y muestra su estado
*actualizado con pipes.

*    TYPES:
*      BEGIN OF ty_expedicionario,
*        nombre           TYPE string,
*        oxigeno_restante TYPE i,
*        estado           TYPE string,
*      END OF ty_expedicionario.
*
*    DATA:
*      ls_expedicion   TYPE ty_expedicionario,
*      lt_expediciones TYPE TABLE OF ty_expedicionario.
*
*    ls_expedicion-nombre = 'Tanque 1'.
*    ls_expedicion-oxigeno_restante = 40.
*    APPEND ls_expedicion TO lt_expediciones.
*    ls_expedicion-nombre = 'Tanque 2'.
*    ls_expedicion-oxigeno_restante = 50.
*    APPEND ls_expedicion TO lt_expediciones.
*    ls_expedicion-nombre = 'Tanque 3'.
*    ls_expedicion-oxigeno_restante = 70.
*    APPEND ls_expedicion TO lt_expediciones.
*    ls_expedicion-nombre = 'Tanque 4'.
*    ls_expedicion-oxigeno_restante = 10.
*    APPEND ls_expedicion TO lt_expediciones.
*    ls_expedicion-nombre = 'Tanque 5'.
*    ls_expedicion-oxigeno_restante = 90.
*    APPEND ls_expedicion TO lt_expediciones.
*
*    LOOP AT lt_expediciones ASSIGNING FIELD-SYMBOL(<fs_exp_aux>).
*      IF <fs_exp_aux>-oxigeno_restante < 20.
*        <fs_exp_aux>-estado = 'RETIRADA INMEDIATA'.
*      ELSE.
*        <fs_exp_aux>-estado = 'CONTINUA'.
*      ENDIF.
*    ENDLOOP.
*
*    READ TABLE lt_expediciones INTO ls_expedicion WITH KEY nombre = 'Tanque 4'.
*    IF sy-subrc = 0.
*      out->write( |El '{ ls_expedicion-nombre }' tiene estado de '{ ls_expedicion-estado }'. | ).
*    ELSE.
*      out->write( 'No hay ningún tanque con ese nombre.' ).
*    ENDIF.

*-------------------------------------------------------------------------------------------------------------------------------------------------

*3. (Difícil) — El sistema de facturación de un taller mecánico
*Declara con TYPES/DATA u-na estructura ty_reparacion con los campos id_reparacion (entero), coste (decimal) y prioridad (texto), y su tabla lt_reparaciones.
*Usando DO 8 TIMES, genera reparaciones donde id_reparacion sea el número de vuelta, coste sea el número de vuelta multiplicado por 35.80, y prioridad se calcule
*con CASE sobre el resto de dividir el número de vuelta entre 3: 'URGENTE' si el resto es 0, 'NORMAL' si es 1, 'BAJA' si es 2. Añade cada una con APPEND. Después,
*usando LOOP AT ... ASSIGNING con WHERE prioridad = 'URGENTE', aplica un recargo del 15% al coste de cada reparación urgente directamente sobre la fila original.
*Finalmente, recorre toda la tabla con un LOOP AT normal y muestra con pipes un resumen de cada reparación (id, coste final, prioridad), y al terminar, muestra
*cuántas reparaciones en total quedaron con prioridad 'URGENTE'.

*    TYPES:
*      BEGIN OF ty_reparacion,
*        id_reparacion TYPE i,
*        coste         TYPE p LENGTH 10 DECIMALS 2,
*        prioridad     TYPE string,
*      END OF ty_reparacion.
*
*    DATA:
*      ls_reparacion   TYPE ty_reparacion,
*      lt_reparaciones TYPE TABLE OF ty_reparacion,
*      lv_aux_cuenta_1 TYPE p LENGTH 10 DECIMALS 2, "Precio inicial
*      lv_aux_cuenta_2 TYPE p LENGTH 10 DECIMALS 2. " Aumento
*
*    DO 8 TIMES.
*      ls_reparacion-id_reparacion = sy-index.
*      ls_reparacion-coste = sy-index * '35.80'.
*      CASE sy-index MOD 3.
*        WHEN 0.
*          ls_reparacion-prioridad = 'URGENTE'.
*        WHEN 1.
*          ls_reparacion-prioridad = 'NORMAL'.
*        WHEN 2.
*          ls_reparacion-prioridad = 'BAJA'.
*      ENDCASE.
*      APPEND ls_reparacion TO lt_reparaciones.
*    ENDDO.
*
*    LOOP AT lt_reparaciones ASSIGNING FIELD-SYMBOL(<fs_reparacion>) WHERE prioridad = 'URGENTE'.
*      <fs_reparacion>-coste *= '1.15'.
*    ENDLOOP.
*
*    DATA(aux_urgente) = 0.
*    LOOP AT lt_reparaciones INTO ls_reparacion.
*      lv_aux_cuenta_1 = ls_reparacion-coste / '1.15'. "Precio inicial
*      lv_aux_cuenta_2 = lv_aux_cuenta_1 * '0.15'. "Aumento
*      IF ls_reparacion-prioridad = 'URGENTE'.
*        aux_urgente += 1.
*        out->write( | La reparacaton con Nº ID.{ ls_reparacion-id_reparacion } tiene un coste de { ls_reparacion-coste } ({ lv_aux_cuenta_1 } + { lv_aux_cuenta_2 } ) y su estado es { ls_reparacion-prioridad }.| ).
*      ELSE.
*        out->write( | La reparacaton con Nº ID.{ ls_reparacion-id_reparacion } tiene un coste de { ls_reparacion-coste } y su estado es { ls_reparacion-prioridad }.| ).
*      ENDIF.
*    ENDLOOP.
*    out->write( | El total de vehiculos con estado 'URGENTE' es { aux_urgente }.| ).

*-------------------------------------------------------------------------------------------------------------------------------------------------

*4. (Muy muy muy difícil) — El centro de control de una carrera de relevos
*Declara con TYPES/DATA una estructura ty_corredor con los campos dorsal (entero), tiempo_vuelta (decimal), equipo (texto) y estado (texto), y su tabla lt_corredores.
*Usando DO 10 TIMES, genera corredores donde dorsal sea el número de vuelta, tiempo_vuelta sea el resultado de 50 menos el número de vuelta multiplicado
*por 1.25 (para que varíen los tiempos), equipo se calcule con CASE sobre el resto de dividir el dorsal entre 2 ('ROJO' si es par, 'AZUL' si es impar), y
*estado se deje inicialmente vacío. Añade cada corredor con APPEND. Después, usando loop at ... assigning sin filtro, recorre toda la tabla y, con un if anidado
*combinando condiciones lógicas, actualiza estado directamente sobre la fila original: si tiempo_vuelta es menor que 40 Y el equipo es 'ROJO', asigna 'CLASIFICADO';
*si tiempo_vuelta es menor que 40 Y el equipo es 'AZUL', asigna 'CLASIFICADO' también, pero antes de asignarlo comprueba con un READ TABLE (por dorsal, usando
*declaración inline) si ya existe un corredor del equipo 'ROJO' con un tiempo_vuelta mejor (menor); si es así, asigna en su lugar 'DESCALIFICADO POR EQUIPO'.
*Para cualquier otro caso, asigna 'ELIMINADO'. Al terminar, recorre la tabla de nuevo con LOOP AT ... WHERE estado = 'CLASIFICADO' y muestra con pipes el resumen
*de los clasificados, junto con un contador final de cuántos corredores de cada equipo ('ROJO' y 'AZUL') lograron clasificarse.

    TYPES:
      BEGIN OF ty_corredor,
        dorsal        TYPE i,
        tiempo_vuelta TYPE p LENGTH 10 DECIMALS 2,
        equipo        TYPE string,
        estado        TYPE string,
      END OF ty_corredor.

    DATA:
      lv_rojo         TYPE i,
      lv_azul         TYPE i,
      ls_corredor     TYPE ty_corredor,
      lt_corredores   TYPE TABLE OF ty_corredor.


    DO 10 TIMES.
      ls_corredor-dorsal = sy-index.
      ls_corredor-tiempo_vuelta = 50 - ( sy-index  * '1.25' ).

      CASE ls_corredor-dorsal MOD 2.
        WHEN 0.
          ls_corredor-equipo = 'ROJO'.
        WHEN 1.
          ls_corredor-equipo = 'AZUL'.
      ENDCASE.

      APPEND ls_corredor TO lt_corredores.
    ENDDO.

    LOOP AT lt_corredores ASSIGNING FIELD-SYMBOL(<fs_corredor>).
      IF <fs_corredor>-tiempo_vuelta < 40.
        READ TABLE lt_corredores INTO DATA(ls_corredor_aux) WITH KEY dorsal = <fs_corredor>-dorsal.
        IF sy-subrc = 0 AND ls_corredor-equipo = 'ROJO' AND ls_corredor-tiempo_vuelta < <fs_corredor>-tiempo_vuelta.
            <fs_corredor>-estado = 'DESCALIFICADO POR EQUIPO'.
        ELSE.
            <fs_corredor>-estado = 'CLASIFICADO'.
        ENDIF.
      ELSE.
        <fs_corredor>-estado = 'ELIMINADO'.
      ENDIF.
    ENDLOOP.

    LOOP AT lt_corredores INTO ls_corredor WHERE estado = 'CLASIFICADO'.
      out->write( | El dorsal { ls_corredor-dorsal } del equipo { ls_corredor-equipo } con un tiempo de { ls_corredor-tiempo_vuelta } esta { ls_corredor-estado }.| ).
      IF ls_corredor-equipo = 'ROJO'.
        lv_rojo += 1.
      ELSE.
        lv_azul += 1.
      ENDIF.
    ENDLOOP.
    out->write( | El numero de corredores clasificados es de ROJOS: { lv_rojo } y AZULES: { lv_azul } .| ).
  ENDMETHOD.
ENDCLASS.








