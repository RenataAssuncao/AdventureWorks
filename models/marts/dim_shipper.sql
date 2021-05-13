with
    stateprovince as (
        select 
            stateprovinceid
            , territoryid
            , stateprovincecode
            , name as province_name
            , isonlystateprovinceflag
            , countryregioncode
        from {{ ref('stg_stateprovince')}}
    )
    , countryregion as (
        select
            countryregioncode
            , 'name' as country_name
        from {{ ref('stg_countryregion') }}
    )
    , address as (
        select distinct
            addressid
            , addressline1
            , addressline2
            , postalcode	
            , city
            , province_name
            , country_name
            from {{ ref('stg_address') }} as address
            left join stateprovince on address.stateprovinceid = stateprovince.stateprovinceid
            left join countryregion on stateprovince.countryregioncode = countryregion.countryregioncode
    )
    , address_transf as (
        select 
            row_number () over (order by addressid) as address_sk -- chave surrogate auto incremental
            , *
        from address
    )

select *
from address_transf