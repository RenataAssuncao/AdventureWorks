with source as(
    select distinct
        businessentityid
        , territoryid
        , salesquota
        , bonus
        , commissionpct
        , salesytd
        , saleslastyear
        , rowguid
        , modifieddate
    from {{ source('adventureworkselt','salesperson')}}
)
select *
from source