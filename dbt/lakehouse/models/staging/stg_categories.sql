with source as (
    select * from {{source('raw','categories')}}
),
rename as (
    select
    category as category_id,
    categoryname as category_name,
    partition_date
    from source
)
select * from rename
