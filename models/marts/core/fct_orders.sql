with orders as (
    select * from {{ ref('stg_orders') }}
), payments as (
    select * from {{ ref('stg_payments') }}
), order_payments as (
    select o.order_id, p.amount
    from orders o 
    left join payments p on o.order_id = p.order_id
), final as (
    select o.order_id, o.customer_id, o.order_date, coalesce(op.amount, 0) as amount
    from orders o
    left join order_payments op on o.order_id = op.order_id
)

select * from final