with source as(
    select distinct
        addressid
        , stateprovinceid
        , addressline1
        , addressline2
        , postalcode	
        , city
        , spatiallocation
        , rowguid
        , modifieddate
    from {{ source('adventureworkselt','address')}}
)
select *
from source