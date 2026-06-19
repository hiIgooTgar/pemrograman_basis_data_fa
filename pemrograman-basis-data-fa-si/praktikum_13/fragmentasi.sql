-- Fragmentasi

-- A. Fragmentasi Horisontal
-- Query Pembuatan Tabel Terfragmentasi Horisontal
CREATE OR REPLACE TABLE barang_frag_horizontal (
    kode_barang VARCHAR(10) NOT NULL,
    nama_barang VARCHAR(30),
    kode_kategori VARCHAR(10) NOT NULL, 
    kode_supplier VARCHAR(10),
    harga INT(10),
    stok INT(10),
    jumlah_terjual INT(11),
    catatan VARCHAR(20),
    PRIMARY KEY (kode_barang, kode_kategori) 
)
PARTITION BY LIST COLUMNS (kode_kategori) (
    PARTITION p_elektronik VALUES IN ('K01'),
    PARTITION p_makanan_minuman VALUES IN ('K02', 'K03'), -- K02 (Buku/Sembako) digabung ke sini
    PARTITION p_pakaian VALUES IN ('K04'),
    PARTITION p_otomotif_furniture VALUES IN ('K07'),
    PARTITION p_cadangan VALUES IN ('K05', 'K06', 'K09')  -- K05 (Vitamin C) didaftarkan di sini
);



SELECT * FROM kategori ORDER BY kode_kategori ASC;
SELECT COUNT(*) FROM kategori;
SELECT COUNT(*) FROM barang;
SELECT * FROM  barang_frag_horizontal ORDER BY kode_barang ASC;
DROP TABLE barang_frag_horizontal;





-- Query Migrasi Data Massal
INSERT INTO barang_frag_horizontal (
    kode_barang, nama_barang, kode_kategori, kode_supplier, harga, stok, jumlah_terjual, catatan
)
SELECT 
    kode_barang, nama_barang, kode_kategori, kode_supplier, harga, stok, jumlah_terjual, catatan 
FROM barang; -- Mengambil dari tabel master yang sudah ada isinya



-- Uji Coba EXPLAIN (Melihat Rencana Kerja Mesin)
EXPLAIN SELECT * FROM barang_frag_horizontal WHERE kode_kategori = "K01";



-- Query Menampilkan Data Per Laci Partisi Fisik
-- Membongkar isi laci elektronik saja
SELECT kode_barang, nama_barang, kode_kategori, stok 
FROM barang_frag_horizontal PARTITION (p_elektronik);

-- Membongkar isi laci makanan & minuman saja
SELECT kode_barang, nama_barang, kode_kategori, stok 
FROM barang_frag_horizontal PARTITION (p_makanan_minuman);


SELECT kode_barang, nama_barang, kode_kategori, stok 
FROM barang_frag_horizontal PARTITION (p_pakaian);


SELECT * FROM barang_frag_horizontal PARTITION (p_otomotif_furniture);













-- B. Fragmentasi Vertikal
-- Query Pembuatan Dua Tabel Pecahan (Fragmen Vertikal)
-- FRAGMEN 1: Khusus Operasional Kasir (Sering Diakses)
CREATE OR REPLACE TABLE barang_toko (
    kode_barang VARCHAR(10) NOT NULL,
    nama_barang VARCHAR(30),
    kode_kategori VARCHAR(10),
    harga INT(10),
    stok INT(10),
    PRIMARY KEY (kode_barang)
);

-- FRAGMEN 2: Khusus Audit & Internal Gudang (Jarang Diakses)
CREATE OR REPLACE TABLE barang_audit (
    kode_barang VARCHAR(10) NOT NULL,
    kode_supplier VARCHAR(10),
    jumlah_terjual INT(11),
    catatan VARCHAR(20),
    PRIMARY KEY (kode_barang),
    FOREIGN KEY (kode_barang) REFERENCES barang_toko (kode_barang) -- Terhubung ke tabel utama
);




-- Query Migrasi Data Vertikal
-- 1. Migrasi kolom kasir ke barang_toko
INSERT INTO barang_toko (kode_barang, nama_barang, kode_kategori, harga, stok)
SELECT kode_barang, nama_barang, kode_kategori, harga, stok 
FROM barang;

-- 2. Migrasi kolom audit ke barang_audit
INSERT INTO barang_audit (kode_barang, kode_supplier, jumlah_terjual, catatan)
SELECT kode_barang, kode_supplier, jumlah_terjual, catatan 
FROM barang;



-- Pembuktian Efisiensi Performa Lewat EXPLAIN
-- Kueri A: Cek Stok Kasir di Tabel Lama (Monolith)
EXPLAIN SELECT nama_barang, harga, stok FROM barang WHERE nama_barang LIKE "Laptop%";
SELECT * FROM barang;


-- Kueri B: Cek Stok Kasir di Tabel Terfragmentasi Vertikal
EXPLAIN SELECT nama_barang, harga, stok FROM barang_toko WHERE nama_barang LIKE "Laptop%";
SELECT * FROM barang;




-- Query Menyatukan Kembali Secara Logika (VIEW / Transparansi Fragmentasi)
CREATE OR REPLACE VIEW v_barang_monolith_transparan AS 
SELECT 
    t.kode_barang,
    t.nama_barang,
    t.kode_kategori,
    t.harga,
    t.stok,
    a.kode_supplier,
    a.jumlah_terjual,
    a.catatan
FROM barang_toko t
JOIN barang_audit a ON t.kode_barang = a.kode_barang;

-- Menguji hasil View
SELECT * FROM v_barang_monolith_transparan LIMIT 10;
SELECT * FROM v_barang_monolith_transparan LIMIT 5;









-- Latihan Praktikum 
-- A. Fragmentasi Horisontal
-- Kueri Pembuatan Tabel Terfragmentasi Horisontal

DROP TABLE transaksi_frag_horizontal;

CREATE OR REPLACE TABLE transaksi_frag_horizontal (
  kode_transaksi VARCHAR(10) NOT NULL,
  kode_customer VARCHAR(10) DEFAULT NULL,
  kode_barang VARCHAR(10) DEFAULT NULL,
  tanggal_transaksi DATE NOT NULL, -- Diubah ke NOT NULL untuk syarat partisi
  jumlah_transaksi INT(4) DEFAULT NULL,
  PRIMARY KEY (kode_transaksi, tanggal_transaksi) -- Kolom partisi wajib masuk composite PK
);

PARTITION BY RANGE (YEAR(tanggal_transaksi)) (
  PARTITION p_transaksi_2024 VALUES LESS THAN (2025),
  PARTITION p_transaksi_2025 VALUES LESS THAN (2026),
  PARTITION p_transaksi_2026 VALUES LESS THAN (2027),
  PARTITION p_transaksi_mendatang VALUES LESS THAN MAXVALUE -- Jaga-jaga agar tidak error 1526 di masa depan
);


-- Kueri Migrasi Data Massal
INSERT INTO transaksi_frag_horizontal (
    kode_transaksi, kode_customer, kode_barang, tanggal_transaksi, jumlah_transaksi
)
SELECT 
    kode_transaksi, kode_customer, kode_barang, tanggal_transaksi, jumlah_transaksi 
FROM transaksi;


-- Mengintip transaksi yang hanya terjadi di tahun 2024
SELECT * FROM transaksi_frag_horizontal PARTITION (p_transaksi_2024);

-- Mengintip transaksi yang hanya terjadi di tahun 2026
SELECT * FROM transaksi_frag_horizontal PARTITION (p_transaksi_2026);





-- B. Fragmentasi Vertikal (Berdasarkan Kolom)

-- FRAGMEN 1: Fokus ke Barang & Jumlah (Operasional Kasir)
DROP TABLE transaksi_toko;
DROP TABLE transaksi_analitik;

CREATE OR REPLACE TABLE transaksi_toko (
  kode_transaksi VARCHAR(10) NOT NULL,
  kode_barang VARCHAR(10) DEFAULT NULL,
  jumlah_transaksi INT(4) DEFAULT NULL,
  PRIMARY KEY (kode_transaksi)
);

-- FRAGMEN 2: Fokus ke Customer & Waktu (Administrasi/Audit)
CREATE TABLE transaksi_analitik (
  kode_transaksi VARCHAR(10) NOT NULL,
  kode_customer VARCHAR(10) DEFAULT NULL,
  tanggal_transaksi DATE DEFAULT NULL,
  PRIMARY KEY (kode_transaksi),
  FOREIGN KEY (kode_transaksi) REFERENCES transaksi_toko(kode_transaksi) 
) 


-- 1. Mengisi kolom ke fragmen toko
INSERT INTO transaksi_toko (kode_transaksi, kode_barang, jumlah_transaksi)
SELECT kode_transaksi, kode_barang, jumlah_transaksi 
FROM transaksi;

-- 2. Mengisi kolom ke fragmen analitik
INSERT INTO transaksi_analitik (kode_transaksi, kode_customer, tanggal_transaksi)
SELECT kode_transaksi, kode_customer, tanggal_transaksi 
FROM transaksi;



CREATE OR REPLACE VIEW v_transaksi_transparan AS
SELECT 
    t.kode_transaksi,
    a.kode_customer,
    t.kode_barang,
    a.tanggal_transaksi,
    t.jumlah_transaksi
FROM transaksi_toko t
JOIN transaksi_analitik a ON t.kode_transaksi = a.kode_transaksi;

-- Cara memanggil data gabungannya:
SELECT * FROM v_transaksi_transparan LIMIT 10;
SELECT * FROM v_transaksi_transparan LIMIT 5;