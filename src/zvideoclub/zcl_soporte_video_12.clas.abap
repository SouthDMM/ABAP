CLASS zcl_soporte_video_12 DEFINITION
  PUBLIC
**********************************************************************
*Clase padre ZCL_SOPORTE_VIDEO_XX
*
*Debe llevar INHERITING-compatible, es decir, sin FINAL, porque va a tener dos hijas.
*
*Atributos, con la visibilidad correcta:
*titulo (string) y precio_alquiler (p decimals 2) → visibles para las hijas.
*veces_alquilado (i) → exclusivo del padre, ni siquiera las hijas deben poder tocarlo directamente
*(repasad el ejemplo de la cuenta bancaria si tenéis dudas de por qué).

*Estático:
*CLASS-DATA total_soportes_creados (i).
*CLASS-METHODS consultar_total_soportes, RETURNING ese contador.

*Constructor: recibe titulo y precio_alquiler. Inicializa veces_alquilado a 0, y suma 1 a total_soportes_creados.
*Método calcular_precio_final: sin parámetros, RETURNING un importe. Comportamiento del padre: el precio final
*es, sencillamente, igual al precio_alquiler sin ningún añadido.
*Método registrar_alquiler: sin parámetros. Suma 1 a veces_alquilado (es el único sitio de todo el código donde se toca ese dato).
*Método consultar_veces_alquilado: RETURNING el valor de veces_alquilado.
**********************************************************************
  CREATE PUBLIC .

  PUBLIC SECTION.

    CLASS-METHODS consultar_total_soportes RETURNING VALUE(rv_total_soportes) TYPE i.

    METHODS:
        constructor IMPORTING i_titulo TYPE string
                              i_precio_alquiler TYPE zdecimals2,
        calcular_precio_final RETURNING VALUE(rv_importe) TYPE zdecimals2,
        registrar_alquiler,
        consultar_veces_alquilado RETURNING VALUE(rv_veces_alquilado) TYPE i.


  PROTECTED SECTION.

    CLASS-DATA total_soportes_creados TYPE i.



    DATA:
       titulo type string,
       precio_alquiler type zdecimals2.

  PRIVATE SECTION.

    DATA veces_alquilado TYPE i.

ENDCLASS.



CLASS zcl_soporte_video_12 IMPLEMENTATION.

  METHOD constructor.
    titulo = i_titulo.
    precio_alquiler = i_precio_alquiler.
    veces_alquilado = 0.
    total_soportes_creados += 1.
  ENDMETHOD.

  METHOD consultar_total_soportes.
    rv_total_soportes = total_soportes_creados.
  ENDMETHOD.

  METHOD calcular_precio_final.
    rv_importe = precio_alquiler.
  ENDMETHOD.

  METHOD consultar_veces_alquilado.
    rv_veces_alquilado = veces_alquilado.
  ENDMETHOD.

  METHOD registrar_alquiler.
    veces_alquilado += 1.
  ENDMETHOD.

ENDCLASS.
