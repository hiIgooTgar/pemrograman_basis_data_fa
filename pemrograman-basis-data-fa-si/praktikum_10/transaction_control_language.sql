-- Latihan Praktikum Transaction Control Language - Praktikum 10

-- 1. Rollback

-- 1. Mulai sesi transaksi
START TRANSACTION;

-- 2. Cek Data Transaksi
SELECT * FROM transaksi;

-- 3. Hapus data transaksi
DELETE FROM transaksi WHERE kode_transaksi = 'T007';

-- 4. Cek Data Transaksi
SELECT * FROM transaksi;

-- 5. Batalkan operasi karena kasir salah tekan!
ROLLBACK;

-- 6. Cek kembali tabelnya
SELECT * FROM transaksi WHERE kode_transaksi = 'T007';
SELECT * FROM transaksi;



-- 2. COMMIT

-- 1. Mulai sesi transaksi baru
START TRANSACTION;

-- 2. Cek Data Transaksi
SELECT * FROM transaksi;

-- 3. Masukkan data transaksi baru
INSERT INTO transaksi (kode_transaksi, kode_customer, kode_barang, tanggal_transaksi, jumlah_transaksi)
VALUES ('T011', 'C002', 'B004', '2026-05-05', 5);

-- 4. Cek tabel
SELECT * FROM transaksi;

-- 5. Kunci data secara permanen karena pelanggan sudah bayar sah
COMMIT;

-- 6. Iseng lakukan ROLLBACK untuk menguji kekuatan COMMIT
ROLLBACK;

-- 7. Cek hasil akhirnya
SELECT * FROM transaksi WHERE kode_transaksi = 'T011';
SELECT * FROM transaksi;






-- 3. Savepoint

-- 1. Mulai sesi transaksi baru
START TRANSACTION;

-- 2. Cek Data Transaksi
SELECT * FROM transaksi;

-- 3. LANGKAH A: Ubah jumlah transaksi TR-11 menjadi 5
UPDATE transaksi SET jumlah_transaksi = 10 WHERE kode_transaksi = 'T001';

-- 4. Cek Data Transaksi
SELECT * FROM transaksi;

-- 5. Buat Checkpoint/Penanda Pertama
SAVEPOINT setelah_update_tr11;

-- 6. LANGKAH B (Sengaja ERROR/SALAH) : Hapus semua transaksi tahun 2024
DELETE FROM transaksi WHERE tanggal_transaksi LIKE '2023%';

-- 7. Cek tabel sementara (Data 2024 hilang, TR-11 sukses berubah jadi 5)
SELECT * FROM transaksi;

-- 8. Waduh salah! Data 2024 harusnya jangan dihapus!
-- Mari kita mundur HANYA sampai ke checkpoint tadi
ROLLBACK TO setelah_update_tr11;
ROLLBACK;

-- 9. Simpan hasil perbaikan
COMMIT;

-- 10. Cek hasil akhir akhir tabel transaksi
SELECT * FROM transaksi;



-- 4 Prosedur Kasir Sukses (tambah_transaksi)

DELIMITER $$
CREATE OR REPLACE PROCEDURE tambah_transaksi(
    IN p_kode_tr VARCHAR(10),
    IN p_kode_ct VARCHAR(10),
    IN p_kode_br VARCHAR(10),
    IN p_tgl DATE,
    IN p_jumlah INT)
BEGIN
    -- PENGAMAN: Jika terjadi error SQL, langsung lakukan ROLLBACK otomatis
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'Terjadi Kesalahan! Transaksi otomatis dibatalkan (Rollback).' AS STATUS;
    END;

    -- 1. Mulai Transaksi
    START TRANSACTION;

    -- 2. Langkah A: Catat ke tabel transaksi
    INSERT INTO transaksi (kode_transaksi, kode_customer, kode_barang, tanggal_transaksi, jumlah_transaksi)
    VALUES (p_kode_tr, p_kode_ct, p_kode_br, p_tgl, p_jumlah);

    -- 3. Langkah B: Potong stok di tabel barang secara manual (Sudah bersih dari kata Ahad)
    UPDATE barang
    SET stok = stok - p_jumlah
    WHERE kode_barang = p_kode_br;

    -- 4. Jika kedua langkah di atas sukses tanpa error, KUNCI PERMANEN
    COMMIT;

    SELECT 'Transaksi Berhasil! Data disimpan dan stok dipotong (Commit).' AS STATUS;
END$$
DELIMITER ;


-- Panggil prosedur kasir
CALL tambah_transaksi('T014', 'C003', 'B007', '2025-05-05', 5);

-- Cek apakah transaksi TR-03 sudah masuk
SELECT * FROM transaksi WHERE kode_transaksi = "T003";
SELECT * FROM transaksi WHERE kode_transaksi = 'T014';

-- Cek apakah stok BR-03 otomatis berkurang.. misal 2 (Dari 12 menjadi 10)
SELECT * FROM barang WHERE kode_barang = "B007";