/* 
Manajemen ingin menampilkan daftar nama barang, nama kategori, dan nama supplier khusus
untuk barang-barang yang masuk dalam kategori 'Elektronik'.
*/ 

	EXPLAIN SELECT b.nama_barang, k.nama_kategori, s.nama_supplier
	FROM barang b
	JOIN kategori k ON b.kode_kategori = k.kode_kategori
	JOIN supplier s ON b.kode_supplier = s.kode_supplier
	WHERE k.nama_kategori = 'Elektronik';


-- Membuat Index pada kolom jembatan JOIN di tabel utama
CREATE INDEX idx_fk_kategori ON barang(kode_kategori);
CREATE INDEX idx_fk_supplier ON barang(kode_supplier);





EXPLAIN SELECT b.nama_barang, k.nama_kategori, s.nama_supplier
FROM barang b FORCE INDEX (idx_fk_kategori) -- <-- KITA PAKSA DI SINI
JOIN kategori k ON b.kode_kategori = k.kode_kategori
JOIN supplier s ON b.kode_supplier = s.kode_supplier
WHERE k.nama_kategori = 'Elektronik';


-- Kita ubah WHERE-nya langsung menembak kode_kategori di barang
EXPLAIN SELECT b.nama_barang, k.nama_kategori
FROM barang b
JOIN kategori k ON b.kode_kategori = k.kode_kategori
WHERE b.kode_kategori = 'K01'; -- <-- Tembak langsung kolom yang punya index









-- Soal 2: Analisis Performa Pencarian Harga di atas Rp 1.000.000
EXPLAIN SELECT kode_barang, nama_barang, harga FROM barang WHERE harga > 1000000;

CREATE INDEX idx_harga ON barang(harga);



-- Soal 3: Kategori 'Makanan' dan Stok Kritis di bawah 5 Unit
EXPLAIN SELECT b.nama_barang, b.stok, k.nama_kategori 
FROM barang b
JOIN kategori k ON b.kode_kategori = k.kode_kategori
WHERE k.nama_kategori = 'Alat Tulis' AND b.stok < 5;


CREATE INDEX idx_nama_kategori ON kategori(nama_kategori);
CREATE INDEX idx_kategori_stok ON barang(kode_kategori, stok);



-- Soal 4: Laporan per Supplier Diurutkan dari Harga Termahal
EXPLAIN SELECT kode_barang, nama_barang, harga 
FROM barang 
WHERE kode_supplier = 'SP001' 
ORDER BY harga DESC;


CREATE INDEX idx_supplier_harga ON barang(kode_supplier, harga);


-- Soal 5: Laporan Macet (Nama Barang, Supplier, Stok < 10, Urut Harga Termahal)
EXPLAIN SELECT b.nama_barang, s.nama_supplier, b.harga, b.stok
FROM barang b
JOIN supplier s ON b.kode_supplier = s.kode_supplier
WHERE b.stok < 10
ORDER BY b.harga DESC;

-- Indeks untuk mempercepat jembatan JOIN ke tabel supplier
CREATE INDEX idx_fk_supplier ON barang(kode_supplier);

-- Composite Index untuk menyembuhkan filter WHERE dan ORDER BY secara instan
CREATE INDEX idx_stok_harga ON barang(stok, harga);










-- Melanjutkan data transaksi T001 sampai T010 yang sudah ada, 
-- Berikut adalah tambahan data transaksi dari T011 hingga T050 (Total menjadi 50 data):

INSERT INTO transaksi (kode_transaksi, kode_customer, kode_barang, tanggal_transaksi, jumlah_transaksi) VALUES
('T011', 'C001', 'B002', '2026-03-05', 2),
('T012', 'C002', 'B006', '2026-03-05', 10),
('T013', 'C003', 'B005', '2026-03-06', 3),
('T014', 'C004', 'B008', '2026-03-06', 1),
('T015', 'C005', 'B001', '2026-03-07', 1),
('T016', 'C006', 'B003', '2026-03-08', 12),
('T017', 'C007', 'B004', '2026-03-09', 4),
('T018', 'C008', 'B007', '2026-03-10', 2),
('T019', 'C009', 'B008', '2026-03-11', 1),
('T020', 'C010', 'B009', '2026-03-12', 5),
('T021', 'C001', 'B004', '2026-03-15', 2),
('T022', 'C003', 'B002', '2026-03-15', 1),
('T023', 'C005', 'B003', '2026-03-16', 6),
('T024', 'C007', 'B008', '2026-03-17', 2),
('T025', 'C009', 'B006', '2026-03-18', 20),
('T026', 'C002', 'B001', '2026-03-20', 1),
('T027', 'C004', 'B009', '2026-03-22', 3),
('T028', 'C006', 'B005', '2026-03-24', 2),
('T029', 'C008', 'B009', '2026-03-25', 4),
('T030', 'C010', 'B007', '2026-03-27', 1),
('T031', 'C002', 'B002', '2026-04-01', 3),
('T032', 'C004', 'B004', '2026-04-01', 1),
('T033', 'C006', 'B006', '2026-04-02', 15),
('T034', 'C008', 'B008', '2026-04-03', 2),
('T035', 'C010', 'B007', '2026-04-05', 3),
('T036', 'C001', 'B003', '2026-04-06', 10),
('T037', 'C003', 'B005', '2026-04-07', 4),
('T038', 'C005', 'B007', '2026-04-08', 2),
('T039', 'C007', 'B009', '2026-04-09', 5),
('T040', 'C009', 'B001', '2026-04-10', 1),
('T041', 'C001', 'B006', '2026-04-12', 8),
('T042', 'C002', 'B004', '2026-04-14', 2),
('T043', 'C003', 'B009', '2026-04-15', 3),
('T044', 'C004', 'B003', '2026-04-16', 20),
('T045', 'C005', 'B002', '2026-04-18', 2),
('T046', 'C006', 'B008', '2026-04-20', 1),
('T047', 'C007', 'B002', '2026-04-22', 2),
('T048', 'C008', 'B001', '2026-04-25', 1),
('T049', 'C009', 'B005', '2026-04-26', 5),
('T050', 'C010', 'B007', '2026-04-28', 2);

-- Cek hasil akhir tabel transaksi setelah datanya berjumlah 50 baris
SELECT * FROM transaksi;