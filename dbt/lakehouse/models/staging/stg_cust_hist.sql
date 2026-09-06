with source as (
    select * from {{source('raw','cust_hist')}}
),
rename as (
    select
    customerid as customer_id,
    orderid as order_id,
    prod_id,
    partition_date
    from source
)
select * from rename
