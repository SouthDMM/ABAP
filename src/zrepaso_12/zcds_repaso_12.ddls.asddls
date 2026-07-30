@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS REPASO'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZCDS_REPASO_12 
   with parameters p_fecha: abap.dats
    as select from zpedido_12 as p
        inner join zcliente_12 as c on p.cliente_id = c.cliente_id
        
{
    c.nombre,
    sum ( p.importe ) as suma,
    avg ( p.importe as abap.dec( 10, 2 )) as media,
    max ( p.importe ) as maximo,
    min ( p.importe ) as minimo,
    count ( * ) as num_productos,
    
    case 
        when sum ( p.importe ) < 500 then 'Manta' 
        when sum ( p.importe ) < 1000 then 'Normal' 
        else 'Premium'
    end as tipo_cliente
}

where p.fecha > $parameters.p_fecha

group by c.nombre
