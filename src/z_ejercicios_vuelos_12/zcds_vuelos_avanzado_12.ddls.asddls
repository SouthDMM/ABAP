@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS Vuelos Avanzado'
@Metadata.ignorePropagatedAnnotations: true
define view entity zcds_vuelos_avanzado_12 
  with parameters p_fecha: abap.dats
    as select from /dmo/booking as b
        inner join /dmo/customer as c
            on b.customer_id = c.customer_id
{
    c.first_name,
    count(*) as Num_de_reservas,
    @Semantics.amount.currencyCode: 'Moneda'
    sum( b.flight_price) as Importe_Total,
    case 
        when sum( b.flight_price) < 1000 
            then 'Ocasional'
        when sum( b.flight_price) < 5000
            then 'Frecuente'
        else 'VIP'
    end as Tipo_Cliente,  
  b.currency_code as Moneda
}

where b.flight_date > $parameters.p_fecha

group by
c.first_name, b.currency_code
