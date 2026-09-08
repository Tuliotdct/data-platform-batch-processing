with deduped as (
    select
        *,
        row_number() over (partition by order_id order by partition_date desc) as row_num
    from {{ ref('stg_orders') }}
)

select 
    *
from deduped
where row_num = 1