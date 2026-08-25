{{ config(materialized = 'incremental', incremental_strategy = 'insert_overwrite') }}

with source as (
    select
    region,
    address1,
    address2,
    customerid as customer_id,
    username,
    firstname,
    gender,
    email,
    state,
    country,
    income,
    creditcard,
    lastname,
    creditcardexpiration as credit_card_expiration,
    zip,
    creditcardtype,
    city,
    password,
    age,
    phone,
    partition_date
    from {{source('raw','customers')}}
    where partition_date = (select max(partition_date) from {{ source('raw', 'customers') }})
)
select * from source
