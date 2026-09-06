with source as (
    select * from {{source('raw','inventory')}}
),
rename as (
    select
    prod_id,
    quan_in_stock,
    sales,
    partition_date
    from source
)
select * from rename
