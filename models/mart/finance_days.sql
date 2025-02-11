select 
date_date,

sum(revenue) as total_revenue,
sum(revenue)/sum(qty) as avg_basket,
sum(margin_op) as margin_op,
sum(purchase_cost) as total_purchase_cost,
sum(margin),
sum(qty) as total_quantity_sold
from {{ref("int_sales_margin")}}
group by date_date