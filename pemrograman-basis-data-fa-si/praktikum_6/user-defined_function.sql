DELIMITER //

CREATE FUNCTION nama_fungsi(parameter1 tipe_data, parameter2 tipe_data) 
RETURNS tipe_data_hasil
DETERMINISTIC

BEGIN
    DECLARE variabel_internal tipe_data;
    
    -- Logika / Perhitungan
    SET variable_internal = "";    
    
    RETURN variabel_internal;
END //

DELIMITER ;



-- Latihan Praktikum 6 - User Defined Function --

/* 1. Tampilkan nama barang menggunakan fungsi bawaan agar jadi huruf kecil semua, lalu
buatlah UDF bernama fn_cek_stok untuk memberi keterangan: jika stok < 10 tulis 'Kritis',
jika tidak tulis 'Normal'.
*/

DELIMITER //

CREATE OR REPLACE FUNCTION fn_cek_stok(p_stok INT)
RETURNS VARCHAR(10)
DETERMINISTIC
BEGIN
    IF p_stok < 10 THEN
        RETURN 'KRITIS';
    ELSE
        RETURN 'NORMAL';
    END IF;
END //

DELIMITER ;


-- Pemanggilan
SELECT
	LOWER(nama_barang) AS nama_kecil,
	stok, fn_cek_stok(stok) AS status_stok
FROM barang;



/*2. Pihak gudang ingin menghitung Estimasi Keuntungan. Keuntungan diambil sebesar 20%
dari harga barang. Namun, hasil hitungannya harus dibulatkan ke atas agar tidak ada angka
receh.
*/

DELIMITER //

CREATE OR REPLACE FUNCTION fn_hitung_profit(p_harga DECIMAL(18,2))
RETURNS DECIMAL(18,2)
DETERMINISTIC
BEGIN
    DECLARE v_profit DECIMAL(18,2);
    SET v_profit = p_harga * 0.20;
    RETURN CEIL(v_profit);
END //

DELIMITER ;


-- Pemanggilan
SELECT nama_barang, harga, fn_hitung_profit(harga) AS Profit_Bersih FROM barang;




-- Kuis Praktikum 6 - User Defined Function --

/* 1. Menghitung Biaya Pengiriman (Ongkir). Ongkir dihitung berdasarkan jumlah barang yang
dibeli. Per unit barang kena biaya kirim Rp 2.000, tapi jika total unit > 50, ongkir dipotong
25% (diskon ongkir).
*/

DELIMITER //

CREATE FUNCTION fn_hitung_ongkir(p_jumlah INT)
RETURNS DECIMAL(18,2)
DETERMINISTIC
BEGIN
    DECLARE v_ongkir DECIMAL(18,2);
    SET v_ongkir = p_jumlah * 2000;
    
    IF p_jumlah > 50 THEN
        SET v_ongkir = v_ongkir * 0.75;
    END IF;
    
    RETURN v_ongkir;
END //

DELIMITER ;


/* 2. Buatlah fungsi untuk menentukan Bonus Poin untuk customer berdasarkan total belanja di
satu transaksi.
a. Jika jumlah_transaksi > 100, poin = jumlah x 10.
b. Jika jumlah_transaksi 50-100, poin = jumlah x 5.
c. Selain itu, poin = 0.

*/

DELIMITER //

CREATE FUNCTION fn_bonus_poin(p_jumlah INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE v_poin INT;

    IF p_jumlah > 100 THEN
        SET v_poin = p_jumlah * 10;
    ELSEIF p_jumlah >= 50 AND p_jumlah <= 100 THEN
        SET v_poin = p_jumlah * 5;
    ELSE
        SET v_poin = 0;
    END IF;

    RETURN v_poin;
END //

DELIMITER ;




-- Tugas Individu - Praktikum 6 User Defined Function

/* 1. Buatlah sebuah UDF bernama fn_cek_diskon. Fungsi ini menerima total_belanja.
a. Jika belanja > 500.000, diskon 10%.
b. Jika belanja 250.000 - 500.000, diskon 5%.
c. Jika < 250.000, tidak ada diskon (0).
*/

DELIMITER //

CREATE OR REPLACE FUNCTION fn_cek_diskon(p_total_belanja DECIMAL(18,2))
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE v_diskon INT;

    IF p_total_belanja > 500000 THEN
        SET v_diskon = 10;
    ELSEIF p_total_belanja >= 250000 AND p_total_belanja <= 500000 THEN
        SET v_diskon = 5;
    ELSE
        SET v_diskon = 0;
    END IF;

    RETURN v_diskon;
END //

DELIMITER ;

SELECT nama_barang, harga, fn_cek_diskon(harga) AS Persen_Diskon FROM barang;



/* 2. Buatlah fungsi fn_hitung_diskon_member untuk customer. Toko memberikan diskon
belanja berdasarkan lama kerja sama (diwakili jumlah transaksi yang pernah dilakukan).
a. Jika jumlah_transaksi > 50 unit dalam satu nota, berikan diskon 15%.
b. Jika jumlah_transaksi 20 - 50 unit, berikan diskon 5%.
c. Selain itu 0.
*/
DELIMITER //

CREATE OR REPLACE FUNCTION fn_hitung_diskon_member(p_jumlah_transaksi INT)
RETURNS INT
DETERMINISTIC
BEGIN
    IF p_jumlah_transaksi > 50 THEN
        RETURN 15;
    ELSEIF p_jumlah_transaksi >= 20 AND p_jumlah_transaksi <= 50 THEN
        RETURN 5;
    ELSE
        RETURN 0;
    END IF;
END //

DELIMITER ;


SELECT nama_barang, jumlah_terjual, fn_hitung_diskon_member(jumlah_terjual) AS Diskon_Member FROM barang;


/* 3. Membuat Fungsi Klasifikasi IPK, Jika IPK >= 3.5 maka Cumlaude, Jika IPK >= 3.0 maka
Sangat Memuaskan, Selain itu Memuaskan.
*/
DELIMITER //

CREATE OR REPLACE FUNCTION fn_klasifikasi_ipk(p_ipk DECIMAL(3,2))
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    DECLARE v_status VARCHAR(20);

    IF p_ipk >= 3.5 THEN
        SET v_status = 'Cumlaude';
    ELSEIF p_ipk >= 3.0 THEN
        SET v_status = 'Sangat Memuaskan';
    ELSE
        SET v_status = 'Memuaskan';
    END IF;

    RETURN v_status;
END //

DELIMITER ;


SELECT fn_klasifikasi_ipk(3.75) AS Predikat_Kelulusan;
