# Cafe Sales Dashboard

---

## Data Cleaning & Quality Log
* **Inisialisasi & Impor Data:** Pada tahap awal, seluruh kolom di dalam dataset didefinisikan dengan tipe data `TEXT` (`VARCHAR`). Pendekatan ini diambil sebagai strategi preventif karena terdeteksi adanya nilai-nilai anomali seperti `UNKNOWN`, `ERROR`, dan `[null]` pada data mentah.
* **Standarisasi Nilai Anomali:** Ditemukan nilai anomali (`[null]`, `ERROR`, dan `UNKNOWN`) yang tersebar di seluruh fitur, kecuali pada kolom `transaction_id`. Langkah penanganan yang dilakukan adalah melakukan standardisasi seluruh nilai anomali tersebut menjadi satu nilai seragam, yaitu **"Unknown"**.
* **Strategi Tipe Data & Rekayasa Nilai (Imputation):** * Untuk mempertahankan integritas data pada tahap awal, perubahan tipe data tidak langsung dilakukan karena kolom-kolom kritikal masih mengandung nilai string `"Unknown"`.
  * Kolom `price_per_unit` tetap dibiarkan mengandung nilai `"Unknown"` pada beberapa baris khusus, dengan pertimbangan bahwa item tersebut memiliki nilai harga yang identik/sama pada transaksi lain.
  * Dilakukan kalkulasi ulang (*re-computation*) untuk fitur `total_spent`. Jika fitur `quantity` dan `price_per_unit` valid (tidak bernilai `"Unknown"`), maka nilai diperbarui menggunakan rumus: `total_spent = quantity * price_per_unit`.
* **Filtrasi Akhir & Konversi Tipe Data:**
  * Tahap pembersihan akhir menyaring data yang tidak dapat dianalisis. Sekitar **1.404 baris data (14%)** yang mengandung nilai `"Unknown"` pada kolom vital (`quantity`, `total_spent`, atau `transaction_date`) diputuskan untuk **dieksklusi**.
  * Setelah proses filtrasi selesai, kolom `quantity`, `price_per_unit`, dan `total_spent` berhasil dikonversi ke tipe data `FLOAT`, serta kolom `transaction_date` dikonversi ke tipe data `DATE`.
* **Volume Data Akhir:** Setelah melalui seluruh rangkaian *pipeline* pembersihan di atas, diperoleh total **8.596 baris data valid** yang siap digunakan untuk proses analisis mendalam dan visualisasi pada dashboard.

---

##  Dashboard
![Dashboard Overview](images/preview.png)
![Dashboard Overview](images/customers.png)

---

## Business Insights
* **Insight 1:** xxxx
* **Insight 2:** xxxx
* **Insight 1:** xxxx

---

## Struktur Repositori
* `data/` : Berisi file data mentah (*raw data*).
* `dashboard/` : File dashboard Power BI (`.xlsx`)
* `sql/` : Berisi file sql yang dijalankan untuk cleaning data
* `images/` : Dokumentasi visual atau gambar dashboard untuk keperluan operasional.

## Tools
* PostgreSQL
* PowerBI
