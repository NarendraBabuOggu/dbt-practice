select p.order_id, o.customer_id, p.amount as amount from {{ ref('stg_payments') }} p  
join {{ ref('stg_orders') }} o on o.order_id = p.order_id