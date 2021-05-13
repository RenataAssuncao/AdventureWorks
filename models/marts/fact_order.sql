with 
    customer as (
        select *
        from {{ ref('dim_customer')}}
    )
    , employee as (
        select *
        from {{ ref ('dim_employee')}}
    )
    , product as (
        select *
        from {{ ref ('dim_product')}}
    )
    , shipper as (
        select *
        from {{ ref ('dim_shipper')}}
    )
    , salesreason as (
        select *
        from {{ ref ('dim_salesreason')}}
    )
    , specialoffer as (
        select *
        from {{ ref ('dim_specialoffer')}}
    )
    , orders as (
        select distinct
            orders_header.salesorderid
            , customer.customer_sk as customer_fk
            , employee.employee_sk as employee_fk
            , salesreason.salesreason_sk as salesreason_fk
            , shipper.address_sk as address_fk
            , orderdate
            , duedate
            , shipdate
            , status
            , purchaseordernumber
            , accountnumber
            , subtotal_USD
            , totaldue_USD
            , taxamt_USD
            , freight_USD
            , card_name
        from {{ ref('stg_salesorderheader') }} as orders_header
        left join customer on orders_header.customerid = customer.customerid
        left join employee on orders_header.salespersonid = employee.businessentityid
        left join shipper on orders_header.shiptoaddressid = shipper.addressid
        left join salesreason on orders_header.salesreasonid = salesreason.salesreasonid
        
    )
    , order_detail as (
        select distinct
            salesorderdetailid
            , salesorderid
            , product.product_sk as product_fk
            , specialoffer.specialoffer_sk as specialoffer_fk
            , unitprice
            , orderqty
            , unitpricediscount
            , carriertrackingnumber
        from {{ ref('stg_salesorderdetail') }} as orders_detail
        left join product on orders_detail.productid = product.productid
        left join specialoffer on orders_detail.specialofferid = specialoffer.specialofferid
    )
    , order_final as (
        select distinct
            orders.salesorderid
            , customer_fk
            , employee_fk
            , salesreason_fk
            , address_fk
            , product_fk
            , specialoffer_fk
            , orders.orderdate
            , orders.duedate
            , orders.shipdate
            , orders.status
            , orders.purchaseordernumber
            , orders.accountnumber
            , orders.subtotal_USD
            , orders.totaldue_USD
            , orders.taxamt_USD
            , orders.freight_USD
            , orders.card_name
            , order_detail.unitprice
            , order_detail.orderqty
            , order_detail.unitpricediscount
        from orders
        left join order_detail on orders.salesorderid = order_detail.salesorderid
    )
select *
from order_final