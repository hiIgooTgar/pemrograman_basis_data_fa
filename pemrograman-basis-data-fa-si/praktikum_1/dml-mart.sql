INSERT INTO supplier (kode_supplier, nama_supplier) VALUES
('S001', 'PT Maju Jaya'),
('S002', 'CV Sumber Makmur'),
('S003', 'PT Elektronik Utama'),
('S004', 'Distributor Sejahtera'),
('S005', 'Grosir Sembako Rejeki'),
('S006', 'PT Tekno Global'),
('S007', 'CV Alam Sari'),
('S008', 'Supplier Utama Mandiri'),
('S009', 'PT Citra Perkasa'),
('S010', 'Indo Logistic Group');


INSERT INTO customer (kode_customer, nama_customer, alamat_customer, telepon_customer) VALUES
('C001', 'Andi Wijaya', 'Jl. Merdeka No. 10', '081234567890'),
('C002', 'Budi Santoso', 'Jl. Mawar No. 5', '081234567891'),
('C003', 'Citra Lestari', 'Jl. Melati No. 22', '081234567892'),
('C004', 'Deni Pratama', 'Jl. Anggrek No. 15', '081234567893'),
('C005', 'Eka Putri', 'Jl. Kenanga No. 8', '081234567894'),
('C006', 'Fajar Ramadhan', 'Jl. Dahlia No. 3', '081234567895'),
('C007', 'Gita Permata', 'Jl. Kamboja No. 12', '081234567896'),
('C008', 'Hadi Sucipto', 'Jl. Teratai No. 7', '081234567897'),
('C009', 'Indah Sari', 'Jl. Tulip No. 9', '081234567898'),
('C010', 'Joko Susilo', 'Jl. Sakura No. 11', '081234567899');


INSERT INTO kategori (kode_kategori, nama_kategori) VALUES
('K01', 'Elektronik'),
('K02', 'Alat Tulis'),
('K03', 'Sembako'),
('K04', 'Pakaian'),
('K05', 'Kesehatan'),
('K06', 'Olahraga'),
('K07', 'Otomotif'),
('K08', 'Mainan Anak'),
('K09', 'Perabot Rumah'),
('K10', 'Kecantikan');


INSERT INTO barang (kode_barang, nama_barang, kode_kategori, kode_supplier, harga, stok) VALUES
('B001', 'Laptop Asus', 'K01', 'S003', 8500000, 10),
('B002', 'Mouse Logitech', 'K01', 'S006', 150000, 50),
('B003', 'Buku Tulis 58lbr', 'K02', 'S002', 4500, 100),
('B004', 'Beras Premium 5kg', 'K03', 'S005', 75000, 30),
('B005', 'Kaos Polos', 'K04', 'S009', 50000, 40),
('B006', 'Vitamin C 500mg', 'K05', 'S008', 25000, 200),
('B007', 'Bola Basket', 'K06', 'S004', 120000, 15),
('B008', 'Oli Mesin 1L', 'K07', 'S001', 65000, 25),
('B009', 'Lampu LED 10W', 'K09', 'S007', 35000, 60),
('B010', 'Lipstick Matte', 'K10', 'S010', 45000, 35);


INSERT INTO pembelian (kode_pembelian, kode_barang, jumlah_beli) VALUES
('P001', 'B001', 5),
('P002', 'B002', 20),
('P003', 'B003', 50),
('P004', 'B004', 15),
('P005', 'B005', 10),
('P006', 'B006', 100),
('P007', 'B007', 5),
('P008', 'B008', 12),
('P009', 'B009', 30),
('P010', 'B010', 20);

INSERT INTO transaksi (kode_transaksi, kode_customer, kode_barang, tanggal_transaksi, jumlah_transaksi) VALUES
('T001', 'C001', 'B001', '2026-03-01', 1),
('T002', 'C002', 'B003', '2026-03-01', 5),
('T003', 'C003', 'B004', '2026-03-02', 2),
('T004', 'C004', 'B002', '2026-03-02', 1),
('T005', 'C005', 'B006', '2026-03-03', 3),
('T006', 'C006', 'B010', '2026-03-03', 2),
('T007', 'C007', 'B005', '2026-03-04', 1),
('T008', 'C008', 'B009', '2026-03-04', 4),
('T009', 'C009', 'B008', '2026-03-04', 1),
('T010', 'C010', 'B007', '2026-03-04', 1);


SELECT * FROM supplier;
SELECT * FROM customer;
SELECT * FROM kategori;
SELECT * FROM barang;
SELECT * FROM pembelian;
SELECT * FROM transaksi;
