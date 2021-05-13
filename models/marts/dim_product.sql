with staging as (

    select distinct
        productid
        , productsubcategoryid
        , productmodelid
        , name
        , style
        , class
        , productnumber
        , productline
        , color
        , size
        , sizeunitmeasurecode
        , weight
        , weightunitmeasurecode
        , listprice
        , standardcost
        , daystomanufacture
        , safetystocklevel
        , reorderpoint
        , sellstartdate
        , sellenddate
        , makeflag
        , finishedgoodsflag
        , modifieddate

    from {{ ref('stg_product') }}
)
, transformed as (
    select 
        row_number () over (order by productid) as product_sk -- chave surrogate auto incremental
        , *
    from staging
)

select *
from transformed