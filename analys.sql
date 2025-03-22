SELECT COUNT(*) FROM mock_data; 10000

SELECT id, COUNT(*) FROM mock_data GROUP BY id HAVING COUNT(*) > 1; Нет

SELECT DISTINCT customer_pet_type FROM mock_data; 3 типа животных
