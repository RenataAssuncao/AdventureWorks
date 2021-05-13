with source as(
    select distinct
        salesorderdetailid
        , salesorderid
        , specialofferid
        , productid
        , unitprice
        , orderqty
        , unitpricediscount
        , carriertrackingnumber
        , rowguid
        , modifieddate
    from {{ source('adventureworkselt','salesorderdetail')}}
)
select *
from source