with source as(
    select distinct
        customerid
        , personid
        , territoryid
        , storeid
        , rowguid	
        , modifieddate
    from {{ source('adventureworkselt','customer')}}
)
select *
from source