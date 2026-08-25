{{ config(materialized = 'incremental', incremental_strategy = 'insert_overwrite') }}

with source as (
    select
    category as category_id,
    categoryname as category_name,
    partition_date
    from {{source('raw','categories')}}
    where partition_date = (select max(partition_date) from {{ source('raw', 'categories') }})
)
select * from source
