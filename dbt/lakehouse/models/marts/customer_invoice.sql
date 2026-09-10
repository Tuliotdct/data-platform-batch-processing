with orders as (select
customer_id,
round(sum(total_amout), 2) as total_amout,
round(sum(tax), 2) as tax,
round(sum(net_amount), 2) as net_amount
from {{ ref('fact_orders') }}
group by 
customer_id
),

customers as (select
customer_id,
concat(firstname, ' ', lastname) as fullname,
email
from {{ ref('dim_customers') }}
)

select 
customers.customer_id,
customers.fullname,
customers.email,
orders.total_amout,
orders.tax,
orders.net_amount
from orders
left join customers on orders.customer_id = customers.customer_id