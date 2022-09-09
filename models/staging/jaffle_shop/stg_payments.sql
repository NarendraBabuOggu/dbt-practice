select 
    id as payment_id, 
    order_id as order_id, 
    payment_method as payment_method, 
    amount/100 as amount
from {{ source('dbt_input', 'payments') }}