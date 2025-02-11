select 
date_date,
sum(nb_trans) as nb_transactions,
sum(revenue) as total_revenue,
sum(revenue)/sum(nb_trans) as avg_basket,
sum(margin_op) as margin_op,
sum(purchase_cost) as total_purchase_cost,
sum(shipping_fee) as total_shipping_fee,
sum(logcost) as total_logcost,
sum(qty) as total_quantity_sold
from {{ref("int_sales_margin")}}
group by date_date