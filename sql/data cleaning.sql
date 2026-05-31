SELECT * FROM cafe_sales;

/* 
Logs :
fitur quantity, price_per_unit, total_spent sekarang varchar -> harusnya int dan float
transaction_date sekarang varchar -> harusnya date

terdapat nilai [null], ERROR, dan UNKNOWN pada seluruh fitur kecuali transaction_id -> standarisasi ke ke "Unknown"

tidak akan dilakukan pengubahan tipe data karena tiap fitur bisa mengandung nilai "Unknown"

kolom price_per_unit dibiarkan mengandung 'Unknwon' karena ada beberapa item yang memiliki harga yang sama

akan dilakukan penghitungan ulang fitur total spent dimana jika fitur quantity dan price_per_unit tidak bernilai "Unknown" maka total_spent = quantity * price_per_unit

data akhir yang valid dan akan dianalisis dan divisualisasikan berjumlah 8596 baris karena sekitar 1404 data (14%) mengandung nilai 'Unknown' pada kolom quantity atau total_spent atau transaction_date

terakhir akan diperbarui tipe data pada kolom quantity, price_per_unit, total_spent menjadi tipe float dan kolom transaction_date menjadi tipe date 
*/

-- Standarisasi nilai [null], ERROR, dan UNKNOWN -> "Unknown"
UPDATE cafe_sales 
SET
item = CASE WHEN item IS NULL OR item IN ('ERROR', '[null]', 'UNKNOWN') THEN 'Unknown' ELSE item END,
quantity = CASE WHEN quantity IS NULL OR quantity IN ('ERROR', '[null]', 'UNKNOWN') THEN 'Unknown' ELSE quantity END,
price_per_unit = CASE WHEN price_per_unit IS NULL OR price_per_unit IN ('ERROR', '[null]', 'UNKNOWN') THEN 'Unknown' ELSE price_per_unit END,
total_spent = CASE WHEN total_spent IS NULL OR total_spent IN ('ERROR', '[null]', 'UNKNOWN') THEN 'Unknown' ELSE total_spent END,
payment_method = CASE WHEN payment_method IS NULL OR payment_method IN ('ERROR', '[null]', 'UNKNOWN') THEN 'Unknown' ELSE payment_method END,
loc = CASE WHEN loc IS NULL OR loc IN ('ERROR', '[null]', 'UNKNOWN') THEN 'Unknown' ELSE loc END,
transaction_date = CASE WHEN transaction_date IS NULL OR transaction_date IN ('ERROR', '[null]', 'UNKNOWN') THEN 'Unknown' ELSE transaction_date END;


-- hitung ulang total_spent
UPDATE cafe_sales
SET 
total_spent = CASE WHEN quantity = 'Unknown' OR price_per_unit = 'Unknown' THEN 'Unknown' 
ELSE (quantity::FLOAT * price_per_unit::FLOAT)::TEXT  END; 

-- ambil data dengan nilai quantity !='Unknown' AND total_spent != 'Unknown' AND transaction_date != 'Unknown' dengan simpan di tabel baru

-- agar bisa run script berulang-ulang 
DROP TABLE IF EXISTS cafe_sales_clean;

--buat tabel data bersih
CREATE TABLE cafe_sales_clean AS
SELECT * FROM cafe_sales 
WHERE quantity != 'Unknown' 
  AND total_spent != 'Unknown' 
  AND transaction_date != 'Unknown';

--update tipe data di tabel cafe_sales_clean
ALTER TABLE cafe_sales_clean
    ALTER COLUMN quantity TYPE FLOAT USING quantity::FLOAT,
    ALTER COLUMN price_per_unit TYPE FLOAT USING price_per_unit::FLOAT,
    ALTER COLUMN total_spent TYPE FLOAT USING total_spent::FLOAT,
    ALTER COLUMN transaction_date TYPE DATE USING transaction_date::DATE;
  
--cek
SELECT * FROM cafe_sales_clean;

