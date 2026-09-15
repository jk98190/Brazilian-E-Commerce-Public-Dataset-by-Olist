#Core SQL — the master joined view

CREATE VIEW order_master AS
SELECT
    o.order_id,
    o.order_status,
    o.order_purchase_timestamp,
    o.order_delivered_customer_date,
    o.order_estimated_delivery_date,
    c.customer_unique_id,
    c.customer_state,
    c.customer_city,
    oi.product_id,
    oi.seller_id,
    s.seller_state,
    oi.price,
    oi.freight_value,
    p.payment_type,
    p.payment_installments,
    p.payment_value
FROM olist_orders_dataset o
JOIN olist_customers_dataset   c  ON c.customer_id = o.customer_id
JOIN olist_order_items_dataset oi ON oi.order_id   = o.order_id
JOIN olist_sellers_dataset     s  ON s.seller_id   = oi.seller_id
LEFT JOIN olist_order_payments_dataset p ON p.order_id = o.order_id;

#Key analysis queries (run against your data — results below)# 

#--1. Order status funnel: 
SELECT order_status, COUNT(*) AS n
FROM olist_orders_dataset
GROUP BY order_status ORDER BY n DESC;

-- 2. Delivery performance: 
SELECT
  ROUND(AVG(DATEDIFF(order_delivered_customer_date, order_purchase_timestamp)),1) AS avg_delivery_days,
  ROUND(AVG(DATEDIFF(order_delivered_customer_date, order_estimated_delivery_date)),1) AS avg_days_vs_estimate,
  ROUND(100.0*SUM(order_delivered_customer_date > order_estimated_delivery_date)/COUNT(*),1) AS pct_late
FROM olist_orders_dataset
WHERE order_status = 'delivered'; 

-- 3. Revenue by customer state
SELECT c.customer_state, COUNT(DISTINCT o.order_id) AS orders,
       ROUND(SUM(oi.price+oi.freight_value),2) AS revenue
FROM olist_orders_dataset o
JOIN olist_customers_dataset c ON c.customer_id=o.customer_id
JOIN olist_order_items_dataset oi ON oi.order_id=o.order_id
GROUP BY c.customer_state ORDER BY revenue DESC LIMIT 10; 

-- 4. Payment behavior 
SELECT payment_type, COUNT(*) n, ROUND(AVG(payment_value),2) avg_value,
       ROUND(AVG(payment_installments),1) avg_installments
FROM olist_order_payments_dataset
GROUP BY payment_type ORDER BY n DESC; 

-- 5. Seller concentration 
SELECT s.seller_id, s.seller_state, COUNT(DISTINCT oi.order_id) orders,
       ROUND(SUM(oi.price),2) revenue
FROM olist_order_items_dataset oi
JOIN olist_sellers_dataset s ON s.seller_id = oi.seller_id
GROUP BY s.seller_id, s.seller_state
ORDER BY revenue DESC
LIMIT 5;

-- 6. Freight cost burden 
SELECT ROUND(AVG(freight_value),2) avg_freight, ROUND(AVG(price),2) avg_price,
       ROUND(100.0*AVG(freight_value)/AVG(price),1) freight_pct_of_price
FROM olist_order_items_dataset; 

-- 7. True repeat purchase rate (customer_unique_id, not customer_id)
SELECT COUNT(*) unique_customers,
       SUM(order_count>1) repeat_customers,
       ROUND(100.0*SUM(order_count>1)/COUNT(*),2) repeat_pct
FROM (
  SELECT c.customer_unique_id, COUNT(DISTINCT o.order_id) order_count
  FROM olist_customers_dataset c
  JOIN olist_orders_dataset o ON o.customer_id = c.customer_id
  GROUP BY c.customer_unique_id
) t;
 
 -- 8. Cross-state vs same-state shipping cost
SELECT CASE WHEN c.customer_state=s.seller_state THEN 'same_state' ELSE 'cross_state' END grp,
       COUNT(*) n, ROUND(AVG(oi.freight_value),2) avg_freight
FROM olist_order_items_dataset oi
JOIN olist_orders_dataset o ON o.order_id=oi.order_id
JOIN olist_customers_dataset c ON c.customer_id=o.customer_id
JOIN olist_sellers_dataset s ON s.seller_id=oi.seller_id
GROUP BY grp;



