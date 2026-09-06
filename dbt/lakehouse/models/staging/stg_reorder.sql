with source as (
    select * from {{source('raw','reorder')}}
),
rename as (
    select
    prod_id,
    date_reordered,
    quan_reordered,
    date_low,
    date_expected,
    quan_low,
    partition_date
    from source
)
select * from rename
