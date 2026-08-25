{{ config(materialized = 'incremental', incremental_strategy = 'insert_overwrite') }}

with source as (
    select
    prod_id,
    quantity,
    orderlineid as order_line_id,
    orderid as order_id,
    orderdate order_date,
    partition_date
    from {{source('raw','orderlines')}}
    where partition_date = (select max(partition_date) from {{ source('raw', 'orderlines') }})
)
select * from source
