with
    validation as (
        select sum (unitprice) as sum_price
        from {{ ref('fact_order') }}
        where orderdate between '2012-01-01' and '2012-06-30'
    )

select * from validation where sum_price != 10926897.5227