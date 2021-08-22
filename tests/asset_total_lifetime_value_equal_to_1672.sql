select * from (
    select sum(lifetime_value) total_lifetime_value from {{ref('dim_customer')}}
) 
where total_lifetime_value != 1672