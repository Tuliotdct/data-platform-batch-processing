with source as (
    select * from {{source('raw','products')}}
),
rename as (
    select
    title,
    actor,
    prod_id,
    category,
    special,
    price,
    common_prod_id,
    partition_date
    from source
)
select * from rename
