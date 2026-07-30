@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS conexiones avanzado'
@Metadata.ignorePropagatedAnnotations: true
define view entity zcds_conexiones_avanzado_12 
  with parameters p_distancia:abap.int4
    as select from /dmo/connection as con
        inner join /dmo/carrier as car 
            on con.carrier_id = car.carrier_id
{
    key con.airport_from_id as Aeropuerto,
    avg(con.distance as abap.dec( 10, 0 )) as Distancia_Media,
    count(*) as Num_conexiones,
    case
        when avg(con.distance as abap.dec( 10, 0 )) < 1000
            then 'Corta'
        when avg(con.distance as abap.dec( 10, 0 )) <= 5000
            then 'Media'
        else 'Larga'
    end as tipo_ruta
}

where con.distance > $parameters.p_distancia

group by
con.airport_from_id
