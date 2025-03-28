INSERT INTO emails(email)
SELECT DISTINCT customer_email FROM mock_data
UNION
SELECT DISTINCT seller_email FROM mock_data
UNION
SELECT DISTINCT store_email FROM mock_data
UNION
SELECT DISTINCT supplier_email FROM mock_data;

INSERT INTO phones(phone)
SELECT DISTINCT store_phone FROM mock_data
UNION
SELECT DISTINCT supplier_phone FROM mock_data;

INSERT INTO countries(country_name)
SELECT DISTINCT customer_country FROM mock_data
UNION
SELECT DISTINCT seller_country FROM mock_data
UNION
SELECT DISTINCT store_country FROM mock_data
UNION
SELECT DISTINCT supplier_country FROM mock_data;

INSERT INTO postal_codes(code)
SELECT DISTINCT customer_postal_code FROM mock_data
UNION
SELECT DISTINCT seller_postal_code FROM mock_data;

INSERT INTO cities(city_name)
SELECT DISTINCT store_city FROM mock_data
UNION
SELECT DISTINCT supplier_city FROM mock_data;

INSERT INTO states(state_name)
SELECT DISTINCT store_state FROM mock_data;

INSERT INTO pet_categories(category)
SELECT DISTINCT pet_category FROM mock_data;

INSERT INTO pet_types(type)
SELECT DISTINCT customer_pet_type FROM mock_data;

INSERT INTO product_brands(brand_name)
SELECT DISTINCT product_brand FROM mock_data;

INSERT INTO product_materials(material)
SELECT DISTINCT product_material FROM mock_data;

INSERT INTO product_colors(color)
SELECT DISTINCT product_color FROM mock_data;

INSERT INTO product_categories(category)
SELECT DISTINCT product_category FROM mock_data;


INSERT INTO dim_customers(first_name, last_name, age, email_id, country_id, postal_code_id)
SELECT DISTINCT customer_first_name, customer_last_name, customer_age, em.email_id, c.country_id, pc.code_id
FROM mock_data AS mock
JOIN emails AS em ON mock.customer_email = em.email
JOIN postal_codes as pc ON mock.customer_postal_code = pc.code
JOIN countries as c on mock.customer_country = c.country_name;

INSERT INTO dim_sellers(first_name, last_name, email_id, country_id, postal_code_id)
SELECT DISTINCT seller_first_name, seller_last_name, em.email_id, c.country_id, pc.code_id
FROM mock_data as mock
JOIN emails as em ON mock.seller_email = em.email
JOIN countries as c ON mock.seller_country = c.country_name
JOIN postal_codes as pc ON mock.seller_postal_code = pc.code;

INSERT INTO dim_products(name, category_id, price, quantity, weight, color_id, size, brand_id, material_id, description, rating, reviews, release_date, expiry_date)
SELECT DISTINCT product_name, ct.category_id, product_price, product_quantity, product_weight, cl.color_id, product_size, br.brand_id, mt.material_id, product_description, product_rating, product_reviews, product_release_date, product_expiry_date
FROM mock_data as mock
JOIN product_brands AS br ON mock.product_brand = br.brand_name
JOIN product_materials AS mt ON mock.product_material = mt.material
JOIN product_colors AS cl ON mock.product_color = cl.color
JOIN product_categories AS ct ON mock.product_category = ct.category;

INSERT INTO dim_stores(name, location, city_id, state_id, country_id, phone_id, email_id)
SELECT DISTINCT store_name, store_location, city.city_id, st.state_id, c.country_id, ph.phone_id, em.email_id
FROM mock_data as mock
JOIN emails as em on mock.store_email = em.email
JOIN countries as c on mock.store_country = c.country_name
JOIN phones as ph ON mock.store_phone = ph.phone
JOIN cities as city ON mock.store_city = city.city_name
JOIN states as st ON mock.store_state = st.state_name;

INSERT INTO dim_suppliers(name, contact, email_id, phone_id, address, city_id, country_id)
SELECT DISTINCT supplier_name, supplier_contact, em.email_id, ph.phone_id, supplier_address, city.city_id, c.country_id
FROM mock_data as mock
JOIN emails as em on mock.supplier_email = em.email
JOIN phones as ph on mock.supplier_phone = ph.phone
JOIN countries as c on mock.supplier_country = c.country_name
JOIN cities as city ON mock.supplier_city = city.city_name;

INSERT INTO dim_pets(category_id, type_id, name, breed)
SELECT DISTINCT ct.category_id, type_id, customer_pet_name, customer_pet_breed
FROM mock_data as mock
JOIN pet_categories AS ct ON mock.pet_category = ct.category
JOIN pet_types as tp ON mock.customer_pet_type = tp.type;


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
JOIN dim_customers AS cust ON mock.id = cust.customer_id
JOIN dim_sellers AS sell ON mock.id = sell.seller_id
JOIN dim_products AS prod ON mock.id = prod.product_id
JOIN dim_stores AS stor ON mock.id = stor.store_id
JOIN dim_suppliers AS supp ON mock.id = supp.supplier_id
LEFT JOIN dim_pets AS pt ON mock.id = pt.pet_id;

