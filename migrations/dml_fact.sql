INSERT INTO fact_sales(customer_id, seller_id, product_id, store_id, supplier_id, pet_id, sale_date, quantity, total_price)
SELECT
    cust.customer_id,
    sell.seller_id,
    prod.product_id,
    stor.store_id,
    supp.supplier_id,
    pt.pet_id,
    mock.sale_date,
    mock.sale_quantity,
    mock.sale_total_price
FROM mock_data AS mock
JOIN dim_customers AS cust ON mock.customer_email = cust.email
JOIN dim_sellers AS sell ON mock.seller_email = sell.email
JOIN dim_products AS prod ON mock.product_name = prod.name
JOIN dim_stores AS stor ON mock.store_name = stor.name
JOIN dim_suppliers AS supp ON mock.supplier_email = supp.email
LEFT JOIN dim_pets AS pt ON mock.customer_pet_name = pt.name AND mock.customer_pet_type = pt.type;