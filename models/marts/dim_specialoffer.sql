with staging as (

    select distinct
        specialofferid
        , type
        , category
        , discountpct
        , startdate
        , enddate
        , minqty
        , maxqty
        , description
        , modifieddate

    from {{ ref('stg_specialoffer') }}
)
, transformed as (
    select 
        row_number () over (order by specialofferid) as specialoffer_sk -- chave surrogate auto incremental
        , *
    from staging
)

select *
from transformed