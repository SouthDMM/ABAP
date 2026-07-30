@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS Vuelos'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZCDS_VUELOS_12 as select from /dmo/carrier
{
  carrier_id as id_compania,
  name as nombre,
  currency_code as moneda_local
}
