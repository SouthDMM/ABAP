@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS cliente básico'
@Metadata.ignorePropagatedAnnotations: true
define view entity zcds_clientes_basico_12 
    as select from /dmo/customer as c
        inner join I_CountryText as t
            on c.country_code = t.Country
{
    key c.customer_id as ID_Cliente,
    concat_with_space(c.first_name,c.last_name,1) as Nombre,
    c.city as Ciudad,
    c.country_code as Codigo_Pais,
    t.CountryName as Nombre_Pais
}
where t.Language = 'S'
