{{ config(materialized = 'incremental', incremental_strategy = 'insert_overwrite') }}

with source as (
    select
    prod_id,
    sales,
    quan_in_stock,
    partition_date
    from {{source('raw','inventory')}}
    where partition_date = (select max(partition_date) from {{ source('raw', 'inventory') }})
)
select * from source
