DROP TABLE IF EXISTS cafe_sales;

CREATE TABLE cafe_sales (
    transaction_id   VARCHAR(50),
    item             VARCHAR(100),
    quantity         VARCHAR(50),
    price_per_unit   VARCHAR(50),
    total_spent      VARCHAR(50),
    payment_method   VARCHAR(50),
    loc              VARCHAR(100),
    transaction_date VARCHAR(50)
);

SELECT* FROM cafe_sales