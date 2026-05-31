COPY cafe_sales(transaction_id, item, quantity, price_per_unit, 
total_spent, payment_method, loc, transaction_date)
FROM 'C:\Users\Lenovo ThinkPad T480\Documents\[CAREER]\projects\cafe-sales\data\dirty_cafe_sales.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',');