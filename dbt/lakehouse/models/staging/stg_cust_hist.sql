{{ config(materialized = 'incremental', incremental_strategy = 'insert_overwrite') }}

with source as (
    select
    customerid as customer_id,
    orderid as order_id,
    prod_id,
    partition_date
    from {{source('raw','cust_hist')}}
    where partition_date = (select max(partition_date) from {{ source('raw', 'cust_hist') }})
)
select * from source
