DELIMITER $$
CREATE OR REPLACE PROCEDURE sp_demo_kursor()
BEGIN
    DECLARE v_nama VARCHAR(50);
    DECLARE v_stok INT;
    DECLARE v_selesai INT DEFAULT 0;
    DECLARE v_hasil TEXT DEFAULT '';

    DECLARE cur_barang CURSOR FOR 
	SELECT nama_barang, stok FROM barang;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_selesai = 1;

    OPEN cur_barang;
    ambil_data: LOOP
        FETCH cur_barang INTO v_nama, v_stok;

        IF v_selesai = 1 THEN
            LEAVE ambil_data;
        END IF;

        SET v_hasil = CONCAT(v_hasil, v_nama, ' (', v_stok, '), ');
    END LOOP;

    CLOSE cur_barang;
    SELECT v_hasil AS Daftar_Stok_Barang;
END $$

DELIMITER;

CALL sp_demo_kursor();





--
DELIMITER $$
CREATE OR REPLACE PROCEDURE sp_praktikum_kursor()
BEGIN
    DECLARE v_kode VARCHAR(10);
    DECLARE v_stok INT;
    DECLARE v_selesai INT DEFAULT 0;

    DECLARE cur_diskon CURSOR FOR SELECT kode_barang, stok FROM barang;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_selesai = 1;

    OPEN cur_diskon;
    cek_loop: LOOP
        FETCH cur_diskon INTO v_kode, v_stok;
        IF v_selesai = 1 THEN 
            LEAVE cek_loop; 
        END IF;

        IF v_stok > 100 THEN
            UPDATE barang SET harga = harga * 0.8 WHERE kode_barang = v_kode;
        ELSE
            UPDATE barang SET harga = harga * 0.95 WHERE kode_barang = v_kode;
        END IF;
    END LOOP;

    CLOSE cur_diskon;
    SELECT 'Harga barang berhasil diperbarui!' AS STATUS;
END $$

DELIMITER ;

CALL sp_praktikum_kursor();

SELECT * FROM barang;
SELECT kode_barang, nama_barang, harga, stok FROM barang;











-- Kuis Praktikum 5 - PBD
/*
1. Manajemen Bonus Karyawan (atau Penyesuaian Harga Supplier).
Toko Anda memiliki kebijakan baru. Untuk setiap barang yang terjual lebih dari 50 kali
(asumsikan kolom jumlah_terjual ada di tabel barang), sistem harus otomatis
menambahkan "Poin Populer" ke kolom catatan pada tabel tersebut.
Ketentuan:
a. Gunakan Cursor untuk menelusuri data barang.
b. Gunakan IF untuk mengecek:
   1) Jika jumlah_terjual > 50: Update kolom catatan menjadi "BEST SELLER".
   2) Jika jumlah_terjual 20 - 50: Update kolom catatan menjadi "POTENSIAL".
   3) Selain itu: Update kolom catatan menjadi "NORMAL".
c. Tampilkan pesan: "Proses klasifikasi barang selesai".
*/

ALTER TABLE barang ADD COLUMN jumlah_terjual INT DEFAULT 0;
ALTER TABLE barang ADD COLUMN catatan VARCHAR(30) DEFAULT '';

DELIMITER $$
CREATE OR REPLACE PROCEDURE sp_klasifikasi_barang()
BEGIN
    DECLARE v_kode VARCHAR(10);
    DECLARE v_terjual INT;
    DECLARE v_selesai INT DEFAULT 0;

    DECLARE cur_barang CURSOR FOR 
        SELECT kode_barang, jumlah_terjual FROM barang;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_selesai = 1;

    OPEN cur_barang;
    proses_loop: LOOP
        FETCH cur_barang INTO v_kode, v_terjual;
        IF v_selesai = 1 THEN
            LEAVE proses_loop;
        END IF;

        IF v_terjual > 50 THEN
            UPDATE barang SET catatan = 'BEST SELLER' WHERE kode_barang = v_kode;
        ELSEIF v_terjual >= 20 AND v_terjual <= 50 THEN
            UPDATE barang SET catatan = 'POTENSIAL' WHERE kode_barang = v_kode;
        ELSE
            UPDATE barang SET catatan = 'NORMAL' WHERE kode_barang = v_kode;
        END IF;

    END LOOP;

    CLOSE cur_barang;
    SELECT 'Proses klasifikasi barang selesai' AS Pesan;
END $$

DELIMITER ;

CALL sp_klasifikasi_barang();

SELECT * FROM barang;
SELECT kode_barang, nama_barang, jumlah_terjual, catatan FROM barang;



/* 2. Perusahaan ingin melakukan pemutakhiran data keuangan secara massal. Bagian HRD
memutuskan untuk memberikan bonus sebesar 10% dari Gaji Pokok kepada seluruh
pegawai tanpa terkecuali. Karena jumlah pegawai yang sangat banyak dan adanya
kebutuhan pengolahan data baris demi baris di masa depan, Anda diminta menggunakan
Cursor dalam Stored Procedure untuk menyelesaikan tugas ini. */

CREATE TABLE pegawai (
    id_pegawai INT PRIMARY KEY AUTO_INCREMENT,
    nama_pegawai VARCHAR(50),
    gaji_pokok INT DEFAULT 0,
    bonus INT DEFAULT 0
);

INSERT INTO pegawai (nama_pegawai, gaji_pokok) VALUES
('Budi Sunandar', 5000000),
('Siti Aminah', 7500000),
('Agus Pratama', 4000000),
('Rina Septiani', 6000000),
('Dedi Kurniawan', 5500000);


DELIMITER $$
CREATE OR REPLACE PROCEDURE sp_update_bonus_massal()
BEGIN
    DECLARE v_id INT;
    DECLARE v_gaji INT;
    DECLARE v_bonus_hitung INT;
    DECLARE v_selesai INT DEFAULT 0;

    DECLARE cur_pegawai CURSOR FOR 
        SELECT id_pegawai, gaji_pokok FROM pegawai;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_selesai = 1;

    OPEN cur_pegawai;
    ambil_data: LOOP
        FETCH cur_pegawai INTO v_id, v_gaji;
        IF v_selesai = 1 THEN
            LEAVE ambil_data;
        END IF;

        SET v_bonus_hitung = v_gaji * 0.10;
        UPDATE pegawai 
        SET bonus = v_bonus_hitung 
        WHERE id_pegawai = v_id;

    END LOOP;

    CLOSE cur_pegawai;
    SELECT 'Pemutakhiran bonus 10% berhasil dilakukan secara massal' AS STATUS;

END $$

DELIMITER ;

CALL sp_update_bonus_massal();

SELECT * FROM pegawai;



/*
3. Bagian Inventori ingin mengetahui total nilai aset seluruh barang yang tersimpan di
gudang. Total aset dihitung dengan menjumlahkan hasil perkalian antara Harga dan Stok
untuk setiap baris barang. Karena kalkulasi ini dilakukan secara menyeluruh (baris demi
baris), kita akan menggunakan Cursor untuk menjumlahkan nilai tersebut ke dalam satu
variabel akumulator.
*/

DELIMITER $$
CREATE OR REPLACE PROCEDURE sp_hitung_aset_inventori()
BEGIN
    DECLARE v_harga INT;
    DECLARE v_stok INT;
    DECLARE v_total_aset DECIMAL(20,2) DEFAULT 0;
    DECLARE v_selesai INT DEFAULT 0;

    DECLARE cur_aset CURSOR FOR 
        SELECT harga, stok FROM barang;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_selesai = 1;

    OPEN cur_aset;
    hitung_loop: LOOP
        FETCH cur_aset INTO v_harga, v_stok;
        IF v_selesai = 1 THEN
            LEAVE hitung_loop;
        END IF;

        SET v_total_aset = v_total_aset + (v_harga * v_stok);
    END LOOP;

    CLOSE cur_aset;
    SELECT v_total_aset AS Total_Nilai_Aset_Gudang;

END $$

DELIMITER ;

CALL sp_hitung_aset_inventori();

SELECT harga, stok FROM barang;


/*
4. Toko ingin memberikan apresiasi khusus untuk produk dengan harga ekonomis. Anda
diminta membuat prosedur untuk memberikan bonus stok sebanyak 5 unit secara otomatis,
namun terbatas hanya untuk barang-barang yang harganya di bawah rata-rata harga seluruh
produk yang ada di tabel.

Alur Logika (Langkah Kerja):
 a. Kalkulasi Awal: Menghitung nilai rata-rata (average) harga dari seluruh tabel barang.
 b. Iterasi Data: Menggunakan Cursor untuk menelusuri setiap baris barang satu per satu.
 c. Evaluasi Kondisi: Menggunakan percabangan IF di dalam perulangan untuk
    membandingkan harga barang saat ini dengan nilai rata-rata.
 d. Eksekusi: Melakukan update stok jika kondisi terpenuhi.

*/

DELIMITER $$
CREATE OR REPLACE PROCEDURE sp_bonus_ekonomis_aman()
BEGIN
    DECLARE v_kode VARCHAR(10);
    DECLARE v_harga INT;
    DECLARE v_rata_rata FLOAT;
    DECLARE v_selesai INT DEFAULT 0;

    DECLARE cur_barang CURSOR FOR 
        SELECT kode_barang, harga FROM barang 
        WHERE kode_barang IS NOT NULL; 

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_selesai = 1;

    SELECT AVG(harga) INTO v_rata_rata FROM barang WHERE harga IS NOT NULL;

    OPEN cur_barang;
    ambil_data: LOOP
        FETCH cur_barang INTO v_kode, v_harga;
        IF v_selesai = 1 THEN
            LEAVE ambil_data;
        END IF;

        IF IFNULL(v_harga, 0) < v_rata_rata THEN
            UPDATE barang 
            SET stok = IFNULL(stok, 0) + 5 
            WHERE kode_barang = v_kode;
        END IF;

    END LOOP;

    CLOSE cur_barang;
    SELECT CONCAT('Bonus stok diberikan. Rata-rata harga adalah: ', v_rata_rata) AS Info;

END $$

DELIMITER ;

DELETE FROM barang WHERE kode_barang IS NULL;

CALL sp_bonus_ekonomis_aman();
SELECT * FROM barang;


/*
5. Sistem Penyesuaian Harga Akibat Inflasi Toko "Amikom Jaya" ingin melakukan
pembaruan harga barang secara selektif untuk menjaga profitabilitas di tengah inflasi.
Anda diminta untuk membangun sebuah Stored Procedure yang mampu menelusuri
seluruh stok barang dan melakukan penyesuaian harga dengan kriteria sebagai berikut:

Ketentuan Logika:
 a. Gunakan Cursor untuk menelusuri data kode_barang dan stok dari tabel barang.
 b. Kondisi A: Jika stok barang lebih dari 50 unit, naikkan harganya sebesar 5%.
 c. Kondisi B: Jika stok barang 50 unit atau kurang, naikkan harganya sebesar 10%.
 d. Setelah semua data berhasil diproses, tampilkan pesan: "Update harga inflasi selesai
    dilakukan".
*/

DELIMITER $$
CREATE OR REPLACE PROCEDURE sp_penyesuaian_harga_inflasi()
BEGIN
    DECLARE v_kode VARCHAR(10);
    DECLARE v_stok INT;
    DECLARE v_selesai INT DEFAULT 0;

    DECLARE cur_inflasi CURSOR FOR 
        SELECT kode_barang, stok FROM barang;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_selesai = 1;

    OPEN cur_inflasi;
    proses_loop: LOOP
        FETCH cur_inflasi INTO v_kode, v_stok;
        IF v_selesai = 1 THEN
            LEAVE proses_loop;
        END IF;

        IF v_stok > 50 THEN
            UPDATE barang SET harga = harga * 1.05 WHERE kode_barang = v_kode;
        ELSE
            UPDATE barang SET harga = harga * 1.10 WHERE kode_barang = v_kode;
        END IF;

    END LOOP;

    CLOSE cur_inflasi;
    SELECT 'Update harga inflasi selesai dilakukan' AS Pesan;

END $$

DELIMITER ;

CALL sp_penyesuaian_harga_inflasi();

SELECT kode_barang, nama_barang, stok, harga FROM barang;
SELECT * FROM barang;


