with source as(
    select distinct
        territoryid
        , name
        , countryregioncode
        , salesterritory.group
        , salesytd
        , saleslastyear
        , costytd
        , costlastyear
    from {{ source('adventureworkselt','salesterritory')}} as salesterritory
)
select *
from source