with source as(
    select distinct
        currencycode
        , name
        , modifieddate
    from {{ source('adventureworkselt','currency')}}
)
select *
from source