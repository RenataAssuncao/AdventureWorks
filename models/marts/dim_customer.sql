with
    person as (
        select 
            businessentityid
            , firstname
            , middlename
            , lastname
            , title
        from {{ ref('stg_person')}}
    )
    , territory as (
        select
            territoryid
            , 'name' as region_name
            , countryregioncode
            , 'salesterritory.group' as group_region_name
        from {{ ref('stg_salesterritory') }} as territory
    )
    , customer as (
        select distinct
            customerid
            , firstname
            , middlename
            , lastname
            , title
            , region_name
            , countryregioncode
            , group_region_name
		    , modifieddate
            from {{ ref('stg_customer') }} as customer
            left join person on customer.personid = person.businessentityid
            left join territory on customer.territoryid = territory.territoryid
    )
    , customer_transf as (
        select 
            row_number () over (order by customerid) as customer_sk -- chave surrogate auto incremental
            , *
        from customer
    )

select *
from customer_transf