with source as(
    select distinct
        productid
        , productsubcategoryid
        , productmodelid
        , name
        , style
        , class
        , productnumber
        , productline
        , color
        , size
        , sizeunitmeasurecode
        , weight
        , weightunitmeasurecode
        , listprice
        , standardcost
        , daystomanufacture
        , safetystocklevel
        , reorderpoint
        , sellstartdate
        , sellenddate
        , makeflag
        , finishedgoodsflag
        , rowguid
        , modifieddate	
    from {{ source('adventureworkselt','product')}}
)
select *
from source