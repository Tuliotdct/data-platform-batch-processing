{{ config(materialized = 'incremental', incremental_strategy = 'insert_overwrite') }}

with source as (
    select
    title,
    actor,
    prod_id,
    category,
    special,
    price,
    common_prod_id,
    partition_date
    from {{source('raw','products')}}
    where partition_date = (select max(partition_date) from {{ source('raw', 'products') }})
)
select * from source
