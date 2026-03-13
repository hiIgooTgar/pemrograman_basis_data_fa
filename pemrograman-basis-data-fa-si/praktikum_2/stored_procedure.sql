DELIMITER $$
CREATE PROCEDURE NamaProcedure;
BEGIN 
	kode SQL;
END$$
DELIMITER;

CALL NamaProcedure;

DROP PROCEDURE NamaProcedure;



CREATE PROCEDURE nama_procedure
(MODE nama_parameter tipe_data_parameter (panjang_parameter));


DECLARE nama_variable tipedata(panjang) DEFAULT nilai;;


DECLARE angka INT DEFAULT 0;

DECLARE angka, hasil, sisa INT DEFAULT 0;

SET nama_variablenilai_baru;


DECLARE angka INT DEFAULT 0;
SET angka = 10;

DECLARE angka INT DEFAULT 0;
SET angka := 10;




-- Latihan - Praktikum 2
/* 1. Buatlah Stored Procedure tanpa parameter menggunakan database inventory dengan
nama “TampilCustomer” untuk mendapatkan seluruh data customer (nama, alamat,
dan telepon)! */

DELIMITER $$
CREATE PROCEDURE OR REPLACE TampilCustomer()
BEGIN 
	SELECT nama_customer, alamat_customer, telepon_customer FROM customer;
END$$
DELIMITER;

CALL TampilCustomer();



/* 2. Setiap ada penjualan barang ke customer, admin harus melakukan dua hal : mengurangi
jumlah stok di tabel barang dan mencatat detailnya ke tabel transaksi. Agar pekerjaan lebih
efisien dan meminimalisir kesalahan input manual, buatlah sebuah Stored Procedure.
Buatlah Stored Procedure dengan nama jual_barang_simpel yang memiliki 4 parameter
input:
a. p_kode_tr (Kode Transaksi)
b. p_kode_cus (Kode Customer)
c. p_kode_brg (Kode Barang)
d. p_jumlah (Jumlah yang dibeli) 

Instruksi Query:
Di dalam prosedur tersebut, susunlah perintah SQL untuk:
a. Update: Mengurangi kolom stok pada tabel barang berdasarkan p_kode_brg.
b. Insert: Menambah baris baru ke tabel transaksi menggunakan semua parameter di atas
dan fungsi CURDATE() untuk tanggalnya.

Uji Coba:
Panggilah prosedur tersebut untuk mencatat transaksi baru dengan data berikut:
a. Kode Transaksi: 'T011'
b. Customer: 'C001'
c. Barang: 'B001' (Laptop)
d. Jumlah: 2 unit.
*/


DELIMITER $$
CREATE OR REPLACE PROCEDURE jual_barang_simpel(
    IN p_kode_tr VARCHAR(10),
    IN p_kode_cus VARCHAR(10),
    IN p_kode_brg VARCHAR(10),
    IN p_jumlah INT
)
BEGIN
    UPDATE barang SET stok = stok - p_jumlah WHERE kode_barang = p_kode_brg;

    INSERT INTO transaksi (kode_transaksi, kode_customer, kode_barang, tanggal_transaksi, jumlah_transaksi)
    VALUES (p_kode_tr, p_kode_cus, p_kode_brg, CURDATE(), p_jumlah);
END $$
DELIMITER ;


CALL jual_barang_simpel('T011', 'C001', 'B001', 2);

SELECT * FROM barang WHERE kode_barang = 'B001';
SELECT * FROM transaksi WHERE kode_transaksi = 'T011';



/* 3. Buatlah Stored Procedure menggunakan database inventory dengan nama 
“AlamatCustomer” untuk menampilkan alamat tertentu dari customer!*/

DELIMITER $$
CREATE PROCEDURE AlamatCustomer(IN p_alamat VARCHAR(30))
BEGIN
    -- SELECT *
    SELECT kode_customer, nama_customer, alamat_customer, telepon_customer
    FROM customer WHERE alamat_customer = p_alamat;
END $$
DELIMITER;

CALL AlamatCustomer('Purwokerto');



/* 4. Buatlah Stored Procedure menggunakan database inventory dengan nama 
“insertCustomer” untuk menambah data customer! */

DELIMITER $$
CREATE OR REPLACE PROCEDURE insertCustomer
(
    IN kode_customer VARCHAR(10),
    IN nama_customer VARCHAR(30),
    IN alamat_customer VARCHAR(30),
    IN telepon_customer VARCHAR(15)
)
BEGIN
    INSERT INTO customer (kode_customer, nama_customer, alamat_customer, telepon_customer)
    VALUES (kode_customer, nama_customer, alamat_customer, telepon_customer);
END $$

DELIMITER ;

CALL insertCustomer('C011', 'Rahmat Hidayat', 'Purwokerto', '085747189391');
SELECT * FROM customer;



/* 5. Buatlah Stored Procedure menggunakan database inventory untuk mengubah data
customer! */

DELIMITER $$
CREATE OR REPLACE PROCEDURE updateCustomer(
    IN p_kode_cus VARCHAR(10),
    IN p_nama_baru VARCHAR(30),
    IN p_alamat_baru VARCHAR(30),
    IN p_telepon_baru VARCHAR(15)
)
BEGIN
    UPDATE customer  SET nama_customer = p_nama_baru, alamat_customer = p_alamat_baru,
    telepon_customer = p_telepon_baru WHERE kode_customer = p_kode_cus;
END $$
DELIMITER ;

CALL updateCustomer('C001', 'Andi Wijaya Saputra', 'Jl. Baru No. 1', '081122334455');



/* 6. Buatlah Stored Procedure menggunakan database inventory untuk menghapus data
customer! */


DELIMITER $$
CREATE OR REPLACE PROCEDURE deleteCustomer(IN p_kode_cus VARCHAR(10))
BEGIN
    DELETE FROM customer WHERE kode_customer = p_kode_cus;
END $$
DELIMITER ;

CALL deleteCustomer('C010');



DROP PROCEDURE TampilCustomer;
DROP PROCEDURE jual_barang_simpel;
DROP PROCEDURE AlamatCustomer;
DROP PROCEDURE insertCustomer;
DROP PROCEDURE updateCustomer;
DROP PROCEDURE deleteCustomer;








-- Quis - Praktikum 2
/* 1. Buatlah Stored Procedure tanpa parameter IN untuk menghitung luas persegi!
Panggil Stored Procedure yang telah dibuat sehingga menampilkan hasilnya!*/
DELIMITER $$
CREATE PROCEDURE hitungLuasTanpaParam()
BEGIN
    DECLARE sisi INT;
    SET sisi = 7;
    SELECT (sisi * sisi) AS `sisi * sisi`;
END $$
DELIMITER ;

CALL hitungLuasTanpaParam();


/* 2. Buatlah Stored Procedure menggunakan parameter IN untuk menghitung luas persegi!*/
DELIMITER $$
CREATE PROCEDURE luasPersegi(IN sisi INT)
BEGIN
    SELECT (sisi * sisi) AS `sisi * sisi`;
END $$
DELIMITER ;

CALL luasPersegi(7);


/* 3. Buatlah Stored Procedure menggunakan parameter OUT untuk menghitung luas persegi!*/
DELIMITER $$
CREATE PROCEDURE hitungLuasOUT(IN sisi INT, OUT hasil INT)
BEGIN
    SET hasil = sisi * sisi;
END $$
DELIMITER ;

CALL hitungLuasOUT(7, @luas);
SELECT @luas;


/* 4. Buatlah Stored Procedure menggunakan parameter INOUT untuk menghitung bilangan
kuadrat!*/
DELIMITER $$
CREATE PROCEDURE hitungKuadrat(INOUT angka INT)
BEGIN
    SET angka = angka * angka;
END $$
DELIMITER ;

SET @angka = 7;
CALL hitungKuadrat(@angka);
SELECT @angka;


/* 5. Buatlah Stored Procedure menggunakan lebih dari satu parameter untuk menghitung luas
persegi panjang!*/
DELIMITER $$
CREATE PROCEDURE luasPersegiPanjang(IN panjang INT, IN lebar INT, OUT hasil INT)
BEGIN
    SET hasil = panjang * lebar;
END $$
DELIMITER;

CALL luasPersegiPanjang(7, 3, @luas);
SELECT @luas;



DROP PROCEDURE hitungLuasTanpaParam;
DROP PROCEDURE luasPersegi;
DROP PROCEDURE hitungLuasOUT;
DROP PROCEDURE hitungKuadrat;
DROP PROCEDURE luasPersegiPanjang;






-- Tugas Individu - Praktikum 2
-- 1. Buatlah database dengan nama “universitas”.
CREATE DATABASE universitas;
USE universitas;

-- 2. Buatlah tabel dengan nama “mahasiswa” yang terdiri dari 3 kolom yaitu nim (PK), nama, dan alamat, seperti berikut 
CREATE TABLE mahasiswa (
    nim INT(10) PRIMARY KEY,
    nama VARCHAR(100),
    alamat VARCHAR(100)
);

-- 3. Buatlah isian data minimal 10 data pada tabel “mahasiswa”!
INSERT INTO mahasiswa (nim, nama, alamat) VALUES
(2024001, 'Budi Santoso', 'Jakarta'),
(2024002, 'Siti Aminah', 'Bandung'),
(2024003, 'Andi Wijaya', 'Surabaya'),
(2024004, 'Rina Permata', 'Bandung'),
(2024005, 'Fajar Ramadhan', 'Semarang'),
(2024006, 'Dewi Lestari', 'Yogyakarta'),
(2024007, 'Eko Prasetyo', 'Bandung'),
(2024008, 'Maya Indah', 'Malang'),
(2024009, 'Gita Gutawa', 'Bandung'),
(2024010, 'Hadi Sucipto', 'Medan');

-- 4. Buatlah stored procedure menggunakan database universitas untuk menampilkan data NIM dan NAMA mahasiswa!

DELIMITER $$
CREATE PROCEDURE tampilkanMhs()
BEGIN
    SELECT nim, nama FROM mahasiswa;
END $$
DELIMITER;


-- 5. Buatlah Stored Procedure menggunakan database universitas untuk menambahkan data mahasiswa ke table mahasiswa!
DELIMITER $$
CREATE PROCEDURE tambahMhs(
    IN p_nim INT(10),
    IN p_nama VARCHAR(100),
    IN p_alamat VARCHAR(100)
)
BEGIN
    INSERT INTO mahasiswa (nim, nama, alamat) VALUES (p_nim, p_nama, p_alamat);
END $$
DELIMITER;


/* 6. Buatlah Stored Procedure menggunakan database universitas dengan nama
“alamatMahasiswa” untuk mencari data mahasiswa berdasarkan alamat “Bandung”
dengan parameter “alamatMhs”! */
DELIMITER $$
CREATE PROCEDURE alamatMahasiswa(IN alamatMhs VARCHAR(100))
BEGIN
    SELECT * FROM mahasiswa WHERE alamat = alamatMhs;
END $$
DELIMITER;

-- 7. Buatlah Stored Procedure menggunakan database universitas untuk mengubah data mahasiswa!
DELIMITER $$
CREATE PROCEDURE updateMhs(
    IN p_nim INT(10),
    IN p_nama_baru VARCHAR(100),
    IN p_alamat_baru VARCHAR(100)
)
BEGIN
    UPDATE mahasiswa  SET nama = p_nama_baru, alamat = p_alamat_baru 
    WHERE nim = p_nim;
END $$

-- 8. Buatlah Stored Procedure menggunakan database universitas untuk menghapus data mahasiswa!
DELIMITER $$
CREATE PROCEDURE hapusMhs(IN p_nim INT(10))
BEGIN
    DELETE FROM mahasiswa WHERE nim = p_nim;
END $$
DELIMITER;