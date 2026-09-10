with orders as (select
order_id,
customer_id,
total_amout,
tax,
net_amount,
order_date
from {{ ref('fact_orders') }}
),
customers as (select
customer_id,
region,
address1,
address2,
username,
firstname,
gender,
email,
state,
country,
income,
creditcard,
lastname,
credit_card_expiration,
zip,
creditcardtype,
city,
password,
age,
phone
from {{ ref('dim_customers') }}
)

select 
customers.customer_id,
customers.region,
customers.address1,
customers.address2,
customers.username,
customers.firstname,
customers.gender,
customers.email,
customers.state,
customers.country,
customers.income,
customers.creditcard,
customers.lastname,
customers.credit_card_expiration,
customers.zip,
customers.creditcardtype,
customers.city,
customers.password,
customers.age,
customers.phone,
orders.order_id,
orders.total_amout,
orders.tax,
orders.net_amount,
orders.order_date
from orders
left join customers on orders.customer_id = customers.customer_id