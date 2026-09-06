with source as (
    select * from {{source('raw','orders')}}
),
rename as (
    select
    totalamount as total_amout,
    tax,
    netamount as net_amount,
    customerid as customer_id,
    orderdate as order_date,
    orderid as order_id,
    partition_date
    from source
)
select * from rename
