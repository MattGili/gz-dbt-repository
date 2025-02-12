SELECT 
finance.date_date,
round((finance.margin_op-c.ads_cost),0) as ads_margin,
round(finance.avg_basket,1) as avg_basket,
round(finance.margin_op,0) as margin_op,
c.ads_cost,
c.ads_impression,
c.ads_click,
finance.total_quantity_sold,
round(finance.total_revenue,1) as total_revenue,
round(finance.total_purchase_cost,1) as total_purchase_cost,
round(finance.total_shipping_fee,1) as total_shipping_fee,
round(finance.total_logcost,1) as total_logcost
FROM {{ref("finance_days")}} as finance
INNER JOIN {{ ref('int_campaigns_day') }} as c
USING (date_date)