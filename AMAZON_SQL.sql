use amazons;
select * from mytable; 
select distinct category from mytable;
alter table mytable drop img_link; 

select count(product_id) as count_of_product,product_id,product_name from mytable group by product_id; 

/* Total Sales per Category */

select SUM(CAST(REPLACE(discounted_price, '₹', '') AS DECIMAL(10,2))) as total_sales_per_category, category from mytable group by category ORDER BY total_sales_per_category DESC;

/* Average discount percentage Category */
select avg(CAST(REPLACE(discount_percentage, '₹', '') AS DECIMAL(10,2))) as average_discount_per_category, category from mytable group by category ORDER BY average_sales_per_category DESC;

/* Highest rated products per category */

SELECT product_id, product_name, category, rating
FROM (
    SELECT product_id, 
           product_name, 
           category, 
           rating, 
           ROW_NUMBER() OVER (PARTITION BY category ORDER BY CAST(rating AS DECIMAL(3,1)) DESC) AS highest_ranking_product_in_its_category
    FROM mytable
) AS ranked_products
WHERE highest_ranking_product_in_its_category = 1;

/* Product Popularity Based on Ratings  */
select product_id,product_name ,rating , category from mytable order by rating desc limit 20; 

/* Average Rating per Category */
select avg(rating) as average_rating, category from mytable group by category; 

/* Products with the Highest Discounts */
select product_id,product_name,category,discount_percentage from mytable order by discount_percentage desc limit 10; 

/*  max rated Product  */
select product_id,product_name,category,rating_count from mytable order by rating_count desc limit 10; 

/* Top 5 Users Who Have Given the Most Reviews */
select user_id,user_name,count(rating) as count_rating from mytable group by user_id,user_name order by count_rating desc limit 5; 

/* Price Difference Between Actual and Discounted Price */
select product_id,product_name,CAST(REPLACE(REPLACE(actual_price, '₹', ''), ',', '') AS DECIMAL(10,2)) - 
       CAST(REPLACE(REPLACE(discounted_price, '₹', ''), ',', '') AS DECIMAL(10,2)) AS diff_price from mytable; 
       
       
/* Products with No Discounts */
select product_id,product_name,discount_percentage from mytable where discount_percentage=0; 

/* Products with Low Ratings and High Discounts */
select product_id,product_name,rating,discount_percentage from mytable order by discount_percentage desc,rating asc;

/*Price Distribution Across Categories: */
select min(discounted_price) as min,max(discounted_price) as max,avg(CAST(REPLACE(discount_percentage, '₹', '') AS DECIMAL(10,2))) as average ,category from mytable group by category;
