CLASS zcl_taquerias_12 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_taquerias_12 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA:
      ls_taqueria  TYPE ztaquerias_12,
      lt_taquerias TYPE TABLE OF ztaquerias_12.

*| id_taqueria | nombre | estado | especialidad | nivel_picante | precio_taco |
*|---|---|---|---|---|---|
*| TAQ001 | El Pastor de Jalisco | JA | PA | 3 | 15.00 |
*| TAQ002 | Barbacoa Doña Yuya | OA | BA | 4 | 20.00 |
*| TAQ003 | Cochinita Pibil Express | YU | CO | 2 | 18.00 |

*### Bloque 1 — CREATE: Insertar taquerías
*Comentario: " === 1. CREATE: Insertando taquerias ===
*Rellenad la work area y haced INSERT de *al menos 3 taquerías* distintas (podéis usar los datos de la Parte 6).
*Mostrad por consola si cada inserción ha ido bien.
    ls_taqueria-id_taqueria = 'TAQ001'.
    ls_taqueria-nombre = 'El Pastor de Jalisco'.
    ls_taqueria-estado = 'JA'.
    ls_taqueria-especialidad = 'PA'.
    ls_taqueria-nivel_picante = '3'.
    ls_taqueria-precio_taco = '15.00'.
    ls_taqueria-moneda = 'MXN'.
    INSERT ztaquerias_12 FROM @lS_taqueria.

    IF sy-subrc = 0.
      out->write( | La taqueria { ls_taqueria-nombre } ha sido añadida| ).
    ELSE.
      out->write( | La taqueria { ls_taqueria-nombre } no se ha añadido correctamente.| ).
    ENDIF.

    ls_taqueria-id_taqueria = 'TAQ002'.
    ls_taqueria-nombre = 'Barbacoa Doña Yuya'.
    ls_taqueria-estado = 'OA'.
    ls_taqueria-especialidad = 'BA'.
    ls_taqueria-nivel_picante = '4'.
    ls_taqueria-precio_taco = '20.00'.
    ls_taqueria-moneda = 'MXN'.

    INSERT ztaquerias_12 FROM @lS_taqueria.

    IF sy-subrc = 0.
      out->write( | La taqueria { ls_taqueria-nombre } ha sido añadida| ).
    ELSE.
      out->write( | La taqueria { ls_taqueria-nombre } no se ha añadido correctamente.| ).
    ENDIF.

    ls_taqueria-id_taqueria = 'TAQ003'.
    ls_taqueria-nombre = 'Cochinita Pibil Express'.
    ls_taqueria-estado = 'YU'.
    ls_taqueria-especialidad = 'CO'.
    ls_taqueria-nivel_picante = '2'.
    ls_taqueria-precio_taco = '18.00'.
    ls_taqueria-moneda = 'MXN'.

    INSERT ztaquerias_12 FROM @lS_taqueria.

    IF sy-subrc = 0.
      out->write( | La taqueria { ls_taqueria-nombre } ha sido añadida| ).
    ELSE.
      out->write( | La taqueria { ls_taqueria-nombre } no se ha añadido correctamente.| ).
    ENDIF.
*### Bloque 3 — READ: Leer una taquería que existe
*Comentario: " === 3. READ: Leer una taqueria por su ID ===
*Haced un SELECT SINGLE de una taquería que sí existe y mostrad sus datos (nombre, estado, precio...) por consola.

    SELECT SINGLE * FROM ztaquerias_12
    WHERE id_taqueria = 'TAQ002'
    INTO @ls_taqueria.

    out->write( |Se ha encontrado la taqueria con ID { ls_taqueria-id_taqueria }, nombre { ls_taqueria-nombre }, estado { ls_taqueria-estado }, precio { ls_taqueria-precio_taco }| ).

*### Bloque 5 — READ: Listar taquerías de un estado
*Comentario: " === 5. READ: Listar taquerias por estado ===
*Haced un SELECT (sin SINGLE) filtrando por un estado concreto, guardando el resultado en la tabla interna.
*Mostrad cuántos registros ha devuelto y recorredla para listarlos uno a uno.

    SELECT * FROM ztaquerias_12
    WHERE estado = 'YU'
    INTO TABLE @lt_taquerias.

    out->write( lt_taquerias ).
*### Bloque 6 — UPDATE: Actualizar el precio de un taco
*Comentario: " === 6. UPDATE: Actualizar precio ===
*Modificad el precio_taco de una taquería existente con UPDATE. Comprobad y mostrad el resultado.
    UPDATE ztaquerias_12
    SET precio_taco = '18.50'
    WHERE id_taqueria = 'TAQ002'.

    SELECT * FROM ztaquerias_12
    WHERE id_taqueria = 'TAQ002'
    INTO TABLE @lt_taquerias.

    out->write( lt_taquerias ).
*### Bloque 8 — DELETE: Borrar una taquería
*Comentario: " === 8. DELETE: Borrar taqueria ===
*Borrad una de las taquerías creadas en el Bloque 1. Comprobad y mostrad el resultado.
    DELETE FROM ztaquerias_12
    WHERE id_taqueria = 'TAQ001'.

    SELECT * FROM ztaquerias_12
    INTO TABLE @lt_taquerias.

    out->write( lt_taquerias ).

  ENDMETHOD.
ENDCLASS.
