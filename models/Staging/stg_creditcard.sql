with source as(
    select distinct
        creditcardid
        , cardtype
        , cardnumber
        , expyear
        , expmonth
        , modifieddate
    from {{ source('adventureworkselt','creditcard')}}
)
select *
from source