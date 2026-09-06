with source as (
    select * from {{source('raw','customers')}}
),
rename as (
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
    from source
)
select * from rename
