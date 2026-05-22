-- Latihan Praktikum 9 - Trigger

-- 1. Trigger untuk perubahan data alamat
CREATE TABLE log_customer (
    id INT AUTO_INCREMENT PRIMARY KEY,
    kode_customer VARCHAR(10),
    alamat_lama VARCHAR(100),
    alamat_baru VARCHAR(100),
    waktu DATETIME
);


DELIMITER $$
CREATE OR REPLACE TRIGGER update_alamat_customer
BEFORE UPDATE ON customer
FOR EACH ROW
BEGIN
        INSERT INTO log_customer 
        SET kode_customer = OLD.kode_customer,
        alamat_lama = OLD.alamat_customer, 
        alamat_baru = NEW.alamat_customer,
        waktu = NOW();
END $$

DELIMITER ;



UPDATE customer SET alamat_customer = "Jakarta" WHERE kode_customer = "C005";

SELECT * FROM customer;

SELECT * FROM log_customer;




-- 2. Trigger untuk Log Histori Hapus Data
CREATE TABLE log_barang_terhapus (
    id_log INT AUTO_INCREMENT PRIMARY KEY,
    kode_barang VARCHAR(10),
    nama_barang_lama VARCHAR(50),
    stok_terakhir INT,
    tanggal_dihapus DATETIME,
    user_pembatal VARCHAR(50)
);


DELIMITER $$
CREATE OR REPLACE TRIGGER trg_log_hapus_barang
AFTER DELETE ON barang
FOR EACH ROW
BEGIN
    INSERT INTO log_barang_terhapus 
        SET kode_barang = OLD.kode_barang,
        nama_barang_lama = OLD.nama_barang, 
        stok_terakhir = OLD.stok,
        tanggal_dihapus = NOW(), 
        user_pembatal = CURRENT_USER();
END $$
DELIMITER ;


DELETE FROM barang WHERE kode_barang = "B010";


SELECT * FROM barang;

SELECT * FROM log_barang_terhapus;





DELIMITER $$

CREATE OR REPLACE TRIGGER trg_validasi_stok_minimum
BEFORE UPDATE ON barang
FOR EACH ROW
BEGIN
    IF NEW.stok < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Gagal: Stok barang tidak boleh kurang dari 0!';
    END IF;
END $$

DELIMITER ;





-- No. 3 Validasi Batas Minimal Stok

DELIMITER $$
CREATE OR REPLACE TRIGGER trg_validasi_stok_minimum
BEFORE UPDATE ON barang
FOR EACH ROW
BEGIN
    IF NEW.stok < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Gagal: Stok barang tidak boleh kurang dari 0!';
    END IF;
END $$
DELIMITER ;






-- No. 4 Menghitung Akumulasi jumlah_terjual
DELIMITER $$
CREATE OR REPLACE TRIGGER trg_kurangi_stok_transaksi
AFTER INSERT ON transaksi
FOR EACH ROW
BEGIN
    UPDATE barang 
    SET stok = stok - NEW.jumlah_transaksi
    WHERE kode_barang = NEW.kode_barang;
END $$
DELIMITER ;






-- No.5 Manipulasi Catatan Barang Otomatis

ALTER TABLE barang ADD COLUMN catatan VARCHAR(30) DEFAULT 'Stok Aman';


DELIMITER $$
CREATE OR REPLACE TRIGGER trg_catatan_stok_otomatis
BEFORE UPDATE ON barang
FOR EACH ROW
BEGIN
    IF NEW.stok <= 5 THEN
        SET NEW.catatan = 'Stok Kritis';
    ELSE
        SET NEW.catatan = 'Stok Aman';
    END IF;
END $$
DELIMITER ;





-- No. 6 Auto-Capitalize Nama Barang
DELIMITER $$
CREATE OR REPLACE TRIGGER trg_kapitalisasi_nama_barang
BEFORE INSERT ON barang
FOR EACH ROW
BEGIN
    SET NEW.nama_barang = UPPER(NEW.nama_barang);
END $$
DELIMITER ;















/*

Cascade: Jika data di tabel utama dihapus atau diubah, sistem akan secara otomatis menghapus 
atau mengubah semua data terkait yang ada di tabel child.

Restrict: Sistem akan mencegah (menolak) proses penghapusan atau perubahan data di tabel utama jika masih 
ada data yang terhubung dengannya di tabel child. Anda harus menghapus data di tabel child terlebih dahulu.

*/
 