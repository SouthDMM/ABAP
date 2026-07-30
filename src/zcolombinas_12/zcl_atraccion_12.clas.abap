CLASS zcl_atraccion_12 DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.
*   - *recibir_visitante*: sin parámetros de entrada, suma 1 al contador de visitantes de hoy.
*  - *calcular_precio_entrada: sin parámetros, devuelve (RETURNING) un importe. Comportamiento del padre: **entrada gratuita (0€)*, por defecto.
*  - *consultar_visitantes*: devuelve (RETURNING) el número de visitantes de hoy.
    METHODS:
        constructor,
        recibir_visitante,
        calcular_precio_entrada RETURNING VALUE(rv_importe) TYPE zdecimals2,
        consultar_visitante RETURNING VALUE(rv_num_vis) TYPE i.

  PROTECTED SECTION.
    DATA:
      nombre  TYPE string,
      num_vis TYPE i.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_atraccion_12 IMPLEMENTATION.
  METHOD calcular_precio_entrada.
    rv_importe = 0.
  ENDMETHOD.

  METHOD constructor.
    nombre = 'Atraccion'.
    num_vis = 0.
  ENDMETHOD.

  METHOD consultar_visitante.
    rv_num_vis = num_vis.
  ENDMETHOD.

  METHOD recibir_visitante.
    num_vis += 1.
  ENDMETHOD.

ENDCLASS.
