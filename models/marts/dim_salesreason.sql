with staging as (

    select distinct
        salesreasonid
        , name
        , reasontype
    from {{ ref('stg_salesreason') }}
)
, transformed as (
    select 
        row_number () over (order by salesreasonid) as salesreason_sk -- chave surrogate auto incremental
        , *
    from staging
)

select *
from transformed