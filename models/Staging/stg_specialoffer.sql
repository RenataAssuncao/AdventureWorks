with source as(
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
        , rowguid
    from {{ source('adventureworkselt','specialoffer')}}
)
select *
from source