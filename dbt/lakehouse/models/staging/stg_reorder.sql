{{ config(materialized = 'incremental', incremental_strategy = 'insert_overwrite') }}

with source as (
    select
    prod_id,
    date_reordered,
    quan_reordered,
    date_low,
    date_expected,
    quan_low,
    partition_date
    from {{source('raw','reorder')}}
    where partition_date = (select max(partition_date) from {{ source('raw', 'reorder') }})
)
select * from source
