with source as(
    select distinct
        countryregioncode
        , name
        , modifieddate
    from {{ source('adventureworkselt','countryregion')}}
)
select *
from source