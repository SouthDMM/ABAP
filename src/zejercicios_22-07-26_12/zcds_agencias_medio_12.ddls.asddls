@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS agencia medio'
@Metadata.ignorePropagatedAnnotations: true
define view entity zcds_agencias_medio_12 
  with parameters p_pais:abap.char( 3 )
    as select from /dmo/agency as a
        inner join /dmo/travel as t
            on t.agency_id = a.agency_id
        inner join /dmo/booking as b 
            on t.travel_id = b.travel_id
{
    a.name,
    count(*) as Num_total_reservas,
    @Semantics.amount.currencyCode: 'Moneda'
    avg(b.flight_price as abap.curr( 16, 2 )) as Media,
    @Semantics.amount.currencyCode: 'Moneda'
    sum(b.flight_price) as Suma,
    b.currency_code as Moneda 
}

where a.country_code =$parameters.p_pais
group by
a.name, b.currency_code
