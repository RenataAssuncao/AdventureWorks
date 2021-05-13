with source as(
    select distinct
        currencyrateid
        , fromcurrencycode
        , tocurrencycode
        , currencyratedate
        , averagerate
        , endofdayrate			
    from {{ source('adventureworkselt','currencyrate')}}
)
select *
from source