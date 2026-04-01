-- IF Statement
DELIMITER $$
CREATE OR REPLACE PROCEDURE IF1B(IN input INT(3))
BEGIN
 DECLARE hasil VARCHAR(15);
 IF(input > 10) THEN 
	SET hasil = "Angka lebih dari 10";
 END IF;
 SELECT hasil;
END $$
 
DELIMITER;




-- Latihan Praktikum 3 - Struktur Control Percabangan dan Perulangan
DELIMITER $$
CREATE OR REPLACE PROCEDURE IF2A(IN input INT(3))
BEGIN
 DECLARE hasil VARCHAR(20);
 IF(input >= 85) THEN 
	SET hasil = "Nilai A";
 ELSE 
	SET hasil = "Nilai B";
 END IF;
 SELECT hasil;
END $$
 
DELIMITER;


CALL IF2A(90);
CALL IF2A(80);




-- 2. Buatlah Query dengan IF – ELSEIF - ELSE menggunakan range nilai untuk menampilkan nilai.
DELIMITER $$
CREATE OR REPLACE PROCEDURE IF3A(IN input INT(3))
BEGIN
    DECLARE hasil VARCHAR(20);
    
    -- IF (input BETWEEN 85 AND 100) THEN
    IF (input >= 85 AND input <= 100) THEN 
        SET hasil = "Nilai A";
    ELSEIF (input >= 80) THEN 
        SET hasil = "Nilai A -";
    ELSEIF (input >= 75) THEN 
        SET hasil = "Nilai B +";
    ELSEIF (input >= 70) THEN 
        SET hasil = "Nilai B";
    ELSEIF (input >= 65) THEN 
        SET hasil = "Nilai B -";
    ELSEIF (input >= 60) THEN 
        SET hasil = "Nilai C +";
    ELSEIF (input >= 55) THEN 
        SET hasil = "Nilai C";
    ELSEIF (input >= 50) THEN 
        SET hasil = "Nilai C -";
    ELSEIF (input >= 45) THEN 
        SET hasil = "Nilai D";
    ELSE 
        SET hasil = "Nilai E";
    END IF;
    
    SELECT hasil;
END $$

DELIMITER ;


CALL IF3A(90);
CALL IF3A(40);


-- No. 2
DELIMITER $$
CREATE OR REPLACE PROCEDURE IF3A(IN input INT(3))
BEGIN
    DECLARE hasil VARCHAR(20);
    
    IF (input BETWEEN 85 AND 100) THEN 
        SET hasil = "Nilai A";
    ELSEIF (input BETWEEN 80 AND 84) THEN 
        SET hasil = "Nilai A -";
    ELSEIF (input BETWEEN 75 AND 79) THEN 
        SET hasil = "Nilai B +";
    ELSEIF (input BETWEEN 70 AND 74) THEN 
        SET hasil = "Nilai B";
    ELSEIF (input BETWEEN 65 AND 69) THEN 
        SET hasil = "Nilai B -";
    ELSEIF (input BETWEEN 60 AND 64) THEN 
        SET hasil = "Nilai C +";
    ELSEIF (input BETWEEN 55 AND 59) THEN 
        SET hasil = "Nilai C";
    ELSEIF (input BETWEEN 50 AND 54) THEN 
        SET hasil = "Nilai C -";
    ELSEIF (input BETWEEN 45 AND 49) THEN 
        SET hasil = "Nilai D";
    ELSE 
        SET hasil = "Nilai E";
    END IF;
    
    SELECT hasil;
END $$

DELIMITER ;




-- 3. Buatlah Query dengan Case menggunakan range nilai untuk menampilkan nilai. 
DELIMITER $$
CREATE OR REPLACE PROCEDURE Case1(IN input INT(3))
BEGIN
    DECLARE hasil VARCHAR(20);
    SET hasil = CASE 
        WHEN input BETWEEN 85 AND 100 THEN 'Nilai A'
        WHEN input BETWEEN 80 AND 84  THEN 'Nilai A -'
        WHEN input BETWEEN 75 AND 79  THEN 'Nilai B +'
        WHEN input BETWEEN 70 AND 74  THEN 'Nilai B'
        WHEN input BETWEEN 65 AND 69  THEN 'Nilai B -'
        WHEN input BETWEEN 60 AND 64  THEN 'Nilai C +'
        WHEN input BETWEEN 55 AND 59  THEN 'Nilai C'
        WHEN input BETWEEN 50 AND 54  THEN 'Nilai C -'
        WHEN input BETWEEN 45 AND 49  THEN 'Nilai D'
        ELSE 'Nilai E'
    END;
    
    SELECT hasil;
END $$

DELIMITER;

CALL Case1(90); 
CALL Case1(40);


-- No 3
DELIMITER $$
CREATE OR REPLACE PROCEDURE Case1(IN input INT(3))
BEGIN
    DECLARE hasil VARCHAR(20);
    SET hasil = CASE 
        WHEN input >= 85 AND input <= 100 THEN 'Nilai A'
        WHEN input >= 80 THEN 'Nilai A -'
        WHEN input >= 75 THEN 'Nilai B +'
        WHEN input >= 70 THEN 'Nilai B'
        WHEN input >= 65 THEN 'Nilai B -'
        WHEN input >= 60 THEN 'Nilai C +'
        WHEN input >= 55 THEN 'Nilai C'
        WHEN input >= 50 THEN 'Nilai C -'
        WHEN input >= 45 THEN 'Nilai D'
        ELSE 'Nilai E'
    END;
    
    SELECT hasil;
END $$

DELIMITER ;





/* 
4. Buatlah Query untuk menampilkan data barang pada database inventory dengan
keterangan barang jika harga barang kurang dari 10.000 maka Sangat Murah, jika harga
kurang dari 50.000 maka Murah, jika harga kurang dari 100.000 maka Agak Mahal, jika
harga kurang dari 1.000.000 maka Mahal dan jika harga lebih dari 1.000.000 maka Mahal
Sekali.

a. Percabangan IF Statement
b. Percabangan Case Statement
c. Kombinasi procedure dan percabangan IF Statement
d. Kombinasi procedure dan percabangan Case Statement

*/

-- a
SELECT nama_barang, harga,
    IF(harga < 10000, 'Sangat Murah',
        IF(harga < 50000, 'Murah',
            IF(harga < 100000, 'Agak Mahal',
                IF(harga < 1000000, 'Mahal', 'Mahal Sekali')
            )
        )
    ) AS Keterangan
FROM barang;


-- b
SELECT nama_barang, harga,
    CASE 
        WHEN harga < 10000 THEN 'Sangat Murah'
        WHEN harga < 50000 THEN 'Murah'
        WHEN harga < 100000 THEN 'Agak Mahal'
        WHEN harga < 1000000 THEN 'Mahal'
        ELSE 'Mahal Sekali'
    END AS Keterangan
FROM barang;

-- c 
DELIMITER $$
CREATE OR REPLACE PROCEDURE sp_cek_kategori_barang_if(IN p_kode_brg VARCHAR(10))
BEGIN
    DECLARE v_nama VARCHAR(30);
    DECLARE v_harga INT;
    DECLARE v_ket VARCHAR(30);

    SELECT nama_barang, harga INTO v_nama, v_harga FROM barang 
    WHERE kode_barang = p_kode_brg;

    IF v_harga < 10000 THEN
        SET v_ket = 'Sangat Murah';
    ELSEIF v_harga < 50000 THEN
        SET v_ket = 'Murah';
    ELSEIF v_harga < 100000 THEN
        SET v_ket = 'Agak Mahal';
    ELSEIF v_harga < 1000000 THEN
        SET v_ket = 'Mahal';
    ELSE
        SET v_ket = 'Mahal Sekali';
    END IF;

    SELECT v_nama AS Nama_Barang, v_harga AS Harga, v_ket AS Keterangan;
END $$

DELIMITER ;


-- d
DELIMITER $$
CREATE OR REPLACE PROCEDURE sp_cek_kategori_barang(IN p_kode_brg VARCHAR(10))
BEGIN
    SELECT nama_barang, harga,
        CASE 
            WHEN harga < 10000 THEN 'Sangat Murah'
            WHEN harga < 50000 THEN 'Murah'
            WHEN harga < 100000 THEN 'Agak Mahal'
            WHEN harga < 1000000 THEN 'Mahal'
            ELSE 'Mahal Sekali'
        END AS Keterangan
    FROM barang WHERE kode_barang = p_kode_brg;
END $$

DELIMITER ;


CALL sp_cek_kategori_barang('BR-01');
CALL sp_cek_kategori_barang('BR-08');
CALL sp_cek_kategori_barang('BR-06');




/*
5.

*/

-- a
SELECT nama_barang, stok AS jumlah_stok,
    IF(stok = 0, 'Persediaan Barang Telah Habis',
        IF(stok < 10, 'Persediaan Barang Kurang Dari 10', 
            'Persediaan Barang Masih Banyak')
    ) AS Keterangan
FROM barang;


-- b
SELECT nama_barang, stok AS jumlah_stok,
    CASE 
        WHEN stok = 0 THEN 'Persediaan Barang Telah Habis'
        WHEN stok < 10 THEN 'Persediaan Barang Kurang Dari 10'
        ELSE 'Persediaan Barang Masih Banyak'
    END AS Keterangan
FROM barang;


-- c
DELIMITER $$

CREATE OR REPLACE PROCEDURE sp_cek_stok_barang_if(IN p_kode_brg VARCHAR(10))
BEGIN
    DECLARE v_nama VARCHAR(50);
    DECLARE v_stok INT;
    DECLARE v_ket VARCHAR(50);

    SELECT nama_barang, stok INTO v_nama, v_stok 
    FROM barang WHERE kode_barang = p_kode_brg;

    IF v_stok = 0 THEN
        SET v_ket = 'Persediaan Barang Telah Habis';
    ELSEIF v_stok < 10 THEN
        SET v_ket = 'Persediaan Barang Kurang Dari 10';
    ELSE
        SET v_ket = 'Persediaan Barang Masih Banyak';
    END IF;

    SELECT v_nama AS Nama_Barang, v_stok AS Jumlah_Stok, v_ket AS Keterangan;
END $$

DELIMITER ;


-- d
DELIMITER $$

CREATE OR REPLACE PROCEDURE sp_cek_stok_barang(IN p_kode_brg VARCHAR(10))
BEGIN
    SELECT nama_barang, stok AS Jumlah_Stok,
        CASE 
            WHEN stok = 0 THEN 'Persediaan Barang Telah Habis'
            WHEN stok < 10 THEN 'Persediaan Barang Kurang Dari 10'
            ELSE 'Persediaan Barang Masih Banyak'
        END AS Keterangan
    FROM barang
    WHERE kode_barang = p_kode_brg;
END $$

DELIMITER ;


CALL sp_cek_stok_barang('BR-01');
CALL sp_cek_stok_barang('BR-02');



/*
6.

*/

-- a
SELECT 
    c.nama_customer AS Customer, 
    SUM(t.jumlah_transaksi) AS Total_Beli,
    IF(SUM(t.jumlah_transaksi) >= 15, 'Handuk',
        IF(SUM(t.jumlah_transaksi) >= 10, 'Piring', 'Tidak dapat hadiah')
    ) AS Keterangan_Hadiah
FROM customer c
JOIN transaksi t ON c.kode_customer = t.kode_customer
GROUP BY c.kode_customer;


-- b
SELECT 
    c.nama_customer AS Customer, 
    SUM(t.jumlah_transaksi) AS Total_Beli,
    CASE 
        WHEN SUM(t.jumlah_transaksi) >= 15 THEN 'Handuk'
        WHEN SUM(t.jumlah_transaksi) >= 10 THEN 'Piring'
        ELSE 'Tidak dapat hadiah'
    END AS Keterangan_Hadiah
FROM customer c
JOIN transaksi t ON c.kode_customer = t.kode_customer
GROUP BY c.kode_customer;


-- c
DELIMITER $$
CREATE OR REPLACE PROCEDURE sp_cek_hadiah_customer_if(IN p_kode_cus VARCHAR(10))
BEGIN
    DECLARE v_nama VARCHAR(50);
    DECLARE v_total INT;
    DECLARE v_hadiah VARCHAR(50);

    SELECT c.nama_customer, SUM(t.jumlah_transaksi) INTO v_nama, v_total
    FROM customer c
    JOIN transaksi t ON c.kode_customer = t.kode_customer
    WHERE c.kode_customer = p_kode_cus
    GROUP BY c.kode_customer;

    IF v_total >= 15 THEN
        SET v_hadiah = 'Handuk';
    ELSEIF v_total >= 10 THEN
        SET v_hadiah = 'Piring';
    ELSE
        SET v_hadiah = 'Tidak dapat hadiah';
    END IF;

    SELECT v_nama AS Customer, v_total AS Total_Beli, v_hadiah AS Keterangan_Hadiah;
END $$

DELIMITER ;


-- d
DELIMITER $$

CREATE OR REPLACE PROCEDURE sp_cek_hadiah_customer(IN p_kode_cus VARCHAR(10))
BEGIN
    SELECT 
        c.nama_customer AS Customer, 
        SUM(t.jumlah_transaksi) AS Total_Beli,
        CASE 
            WHEN SUM(t.jumlah_transaksi) >= 15 THEN 'Handuk'
            WHEN SUM(t.jumlah_transaksi) >= 10 THEN 'Piring'
            ELSE 'Tidak dapat hadiah'
        END AS Keterangan_Hadiah
    FROM customer c
    JOIN transaksi t ON c.kode_customer = t.kode_customer
    WHERE c.kode_customer = p_kode_cus
    GROUP BY c.kode_customer;
END $$

DELIMITER ;


CALL sp_cek_hadiah_customer('CT-01');
