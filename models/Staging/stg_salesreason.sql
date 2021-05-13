with source as(
    select distinct
        salesreasonid
        , name
        , reasontype
    from {{ source('adventureworkselt','salesreason')}}
)
select *
from source