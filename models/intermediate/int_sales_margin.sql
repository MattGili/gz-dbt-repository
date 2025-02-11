WITH sub1 AS(
SELECT
date_date,
orders_id,
sum(quantity) as qty,
sum(revenue) as revenue
from {{ref("stg_gz_raw_data__sales")}}
group by date_date,orders_id
),
sub2 AS(
SELECT 
date_date,
orders_id,
sum(product.purchase_price*sales.quantity) as purchase_cost
FROM {{ref("stg_gz_raw_data__sales")}} AS sales
JOIN {{ref("stg_gz_raw_data__product")}} AS product
on product.products_id = sales.products_id
group by date_date, orders_id
), 
sub3 AS(
SELECT
sub1.date_date,
sub1.orders_id,
sub2.purchase_cost,
sub1.revenue,
sub1.qty,
sub1.revenue-sub2.purchase_cost as margin,
ship.shipping_fee,
ship.logcost,
ship.ship_cost
FROM sub1 
JOIN sub2 on sub1.orders_id = sub2.orders_id
JOIN {{ref("stg_gz_raw_data__ship")}} AS ship on sub1.orders_id = ship.orders_id
)
SELECT
orders_id,
date_date,
round(revenue+shipping_fee-(logcost+ship_cost+purchase_cost),2) as margin_op,
round(revenue,2) as revenue,
qty,
round(purchase_cost,2) as purchase_cost,
round(margin,2) as margin
from sub3


