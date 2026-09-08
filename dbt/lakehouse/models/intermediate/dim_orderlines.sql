with deduped as (
    select
        *,
        row_number() over (partition by order_line_id order by partition_date desc) as row_num
    from {{ ref('stg_orderlines') }}
)

select 
    *
from deduped
where row_num = 1