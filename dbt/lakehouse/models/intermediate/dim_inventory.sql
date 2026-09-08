with deduped as (
    select
        *,
        row_number() over (partition by prod_id order by partition_date desc) as row_num
    from {{ ref('stg_inventory') }}
)

select 
    *
from deduped
where row_num = 1