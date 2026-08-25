{{ config(materialized = 'incremental', incremental_strategy = 'insert_overwrite') }}

with source as (
    select
    totalamount as total_amout,
    tax,
    netamount as net_amount,
    customerid as customer_id,
    orderdate as order_date,
    orderid as order_id,
    partition_date
    from {{source('raw','orders')}}
    where partition_date = (select max(partition_date) from {{ source('raw', 'orders') }})
)
select * from source
