with source as(
    select distinct
        shipmethodid
        , salesorderid
        , billtoaddressid
        , salespersonid
        , shiptoaddressid
        , currencyrateid
        , creditcardid
        , territoryid
        , customerid
        , purchaseordernumber
        , accountnumber
        , revisionnumber
        , creditcardapprovalcode
        , orderdate
        , shipdate
        , duedate
        , subtotal
        , totaldue
        , taxamt
        , freight
        , status
        , onlineorderflag
    from {{ source('adventureworkselt','salesorderheader')}}
)
, sales_reason as (
    select distinct
        source.*
        , salesreasonid
    from source
    left join {{ source('adventureworkselt','salesorderheadersalesreason')}} as sales_reason on source.salesorderid = sales_reason.salesorderid
)
, creditcard as (
    select 
        sales_reason.*
        , creditcard.cardtype as card_name
    from sales_reason
    left join {{ ref('stg_creditcard') }} as creditcard on sales_reason.creditcardid = creditcard.creditcardid
)
, currency_rate as (
    select distinct
        currencyrateid
        , fromcurrencycode
        , currencyratedate
        , tocurrencycode
        , averagerate
        , endofdayrate
    from {{ ref('stg_currencyrate') }} as currency_rate
)
, convertionUSD as (
    select creditcard.*
    , (subtotal/endofdayrate) as subtotal_USD
    , (totaldue/endofdayrate) as totaldue_USD
    , (taxamt/endofdayrate) as taxamt_USD
    , (freight/endofdayrate) as freight_USD
    from creditcard
    left join currency_rate 
        on creditcard.currencyrateid = currency_rate.currencyrateid
        and creditcard.orderdate = currency_rate.currencyratedate
)
select *
from convertionUSD