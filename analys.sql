SELECT COUNT(*) FROM mock_data;

SELECT id, COUNT(*) FROM mock_data GROUP BY id HAVING COUNT(*) > 1;

SELECT DISTINCT customer_pet_type FROM mock_data; 

SELECT release_date , COUNT(*)
FROM dim_products
GROUP BY release_date 
HAVING COUNT(*) > 1
ORDER BY COUNT(*) DESC;

select customer_email, count(customer_email) as count
from mock_data md 
group by customer_email
order by count desc

SELECT AVG(sale_total_price) FROM mock_data;

