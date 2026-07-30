CLASS zcl_test_bombilla_12 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_test_bombilla_12 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

*    " Declaracion + Constructor --> Forma Tradicional
*    DATA lo_bombilla TYPE REF TO zcl_bombilla_12.
*    CREATE OBJECT lo_bombilla EXPORTING i_potencia = 60.
*
    " Declaracion + Constructor --> Forma Moderna
    DATA(lo_bombilla_1) = NEW zcl_bombilla_12( 60 ).
    DATA(lo_bombilla_2) = NEW zcl_bombilla_12( 90 ).

    " Llama al metodo encender
    lo_bombilla_1->encender( ).

    " Recupera el valor del atributo y lo pinta
    out->write( |Bombilla 1 = { lo_bombilla_1->get_encendida( ) }| ).
    out->write( |Bombilla 2 = { lo_bombilla_2->get_encendida( ) }| ).

  ENDMETHOD.
ENDCLASS.
