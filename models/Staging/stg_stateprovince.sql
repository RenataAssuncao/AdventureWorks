with source as(
    select distinct
        stateprovinceid
        , territoryid
        , stateprovincecode
        , name
        , isonlystateprovinceflag
        , countryregioncode
        , modifieddate
        , rowguid
    from {{ source('adventureworkselt','stateprovince')}}
)
select *
from source