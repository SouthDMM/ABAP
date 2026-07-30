@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS Vuelos Medio'
@Metadata.ignorePropagatedAnnotations: true

define view entity zcds_vuelos_medio_12 
  with parameters p_fecha: abap.dats
    as select from /dmo/flight as f
        inner join /dmo/carrier as c
            on f.carrier_id = c.carrier_id
{ 
    c.name,
    count(*) as Num_Vuelos,
    @Semantics.amount.currencyCode: 'Moneda'
    avg( f.price as abap.curr( 16, 2 )) as Media,
    @Semantics.amount.currencyCode: 'Moneda'
    max( f.price ) as Maximo,
    @Semantics.amount.currencyCode: 'Moneda'
    min( f.price ) as Minimo,
    f.currency_code as Moneda
}

where f.flight_date > $parameters.p_fecha

group by
c.name, f.currency_code
