# 1
# list of customers with thier order
SELECT c.customer_id, o.order_id from customers c
JOIN orders o
ON c.customer_id = o.customer_id;

# 2
# List the product name (in english) each customers ordered
select c.customers, o.order_id, p.product_id,pt.product_category_name_english from customers c
JOIN orders o
ON c.customer_id = o.customer_id
JOIN order_items ot
ON o.order_id = ot.order_id
JOIN products p
ON p.product_id = ot.product_id
JOIN product_trans pt
ON p.product_category_name = pt.product_category_name;

# 3
# List the orders of the customers which are stated as delivered
select c.customer_id, o.order_id, o.order_status from customers c
JOIN orders o
ON c.customer_id = o.customer_id
WHERE o.order_status = "delivered";

# 4
# List the customers who are paying in installments
select c.customer_id, op.payment_installments from customers c
JOIN orders o
ON c.customer_id = o.customer_id
JOIN order_payment op
ON o.order_id = op.order_id
WHERE op.payment_installments > 0;

# 5 
# List the rating each customer gave on a product id
select c.customer_id, o.order_id, ore.review_score from customers c
JOIN orders o
ON c.customer_id = o.customer_id
JOIN order_review as ore
ON o.order_id = ore.order_id;

# 6
# List down the cities by number of seller
select seller_city, COUNT(seller_id) from sellers
group by seller_city;

# 7
# List the city from which the customer order has originated and the city from where the order will be delivered
select c.customer_id, c.customer_city, s.seller_city from customers c
JOIN orders o
ON c.customer_id = o.customer_id
JOIN order_items ot
ON o.order_id = ot.order_id
JOIN sellers s
ON ot.seller_id = s.seller_id;

# 8 
# city wise Number of customers 
select customer_city, COUNT(customer_id) as num_of_customer from customers
group by customer_city;

# 9 
# 