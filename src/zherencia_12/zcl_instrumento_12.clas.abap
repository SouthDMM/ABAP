CLASS zcl_instrumento_12 DEFINITION
  PUBLIC
  CREATE PUBLIC .
*- Atributos, con la visibilidad que corresponda para que las clases hijas puedan acceder:
*  - Marca (tipo string).
*  - Horas de uso acumuladas (tipo I).
*- Constructor: recibe la marca. Las horas de uso siempre arrancan en 0, no se piden por parámetro.
*- Método registrar_practica: recibe (IMPORTING) las horas practicadas, y las suma a las horas de uso acumuladas.
*- Método consultar_horas_uso: devuelve (RETURNING) las horas de uso acumuladas.
  PUBLIC SECTION.
    METHODS:
      constructor IMPORTING i_marca TYPE string,
      registrar_practica IMPORTING i_horas TYPE i,
      consultar_horas_uso RETURNING VALUE(rv_horas) TYPE i.
  PROTECTED SECTION.
    DATA:
      marca TYPE string,
      horas TYPE i.
  PRIVATE SECTION.

ENDCLASS.

CLASS zcl_instrumento_12 IMPLEMENTATION.
  METHOD constructor.
    horas = 0.
    marca = i_marca.
  ENDMETHOD.

  METHOD consultar_horas_uso.
    rv_horas = horas.
  ENDMETHOD.

  METHOD registrar_practica.
    horas += i_horas.
  ENDMETHOD.

ENDCLASS.
