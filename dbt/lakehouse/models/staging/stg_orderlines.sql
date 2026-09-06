with source as (
    select * from {{source('raw','orderlines')}}
),
rename as (
    select
    prod_id,
    quantity,
    orderlineid as order_line_id,
    orderid as order_id,
    orderdate order_date,
    partition_date
    from source
)
select * from rename
