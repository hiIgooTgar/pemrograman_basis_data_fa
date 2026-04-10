DELIMITER $$
CREATE OR REPLACE PROCEDURE LeaveIterate2()
BEGIN
	DECLARE i INT;
	DECLARE hasil VARCHAR(20) DEFAULT '';
	SET i = 1;
	
	ulang: LOOP
	 IF i > 6 THEN
	  LEAVE ulang;
	 END IF;
	
	 SET i = i + 1;
	
	 IF(i MOD 2 != 0) THEN
	  ITERATE ulang;
	 ELSE
	  SET hasil = CONCAT(hasil, i, ' ');
	 END IF;
       END LOOP;
       
       SELECT hasil;
END$$

DELIMITER;

CALL LeaveIterate2();






DELIMITER $$
CREATE OR REPLACE PROCEDURE RepeatLoop2()
BEGIN
	DECLARE i INT;
	DECLARE hasil VARCHAR(20) DEFAULT '';
	SET i = 1;
	
	REPEAT
	 SET hasil = CONCAT(hasil, i, ' ');
	 SET i = i + 1;
	 UNTIL i > 5
	END REPEAT;
	
	SELECT hasil;
END $$
DELIMITER;

CALL RepeatLoop2();




DELIMITER $$
CREATE OR REPLACE PROCEDURE WhileLoop2()
BEGIN
	DECLARE i INT;
	DECLARE hasil VARCHAR(20) DEFAULT '';
	SET i = 1;
	
	WHILE i <= 5 DO
	 SET hasil = CONCAT(hasil, i, ' ');
	 SET i = i + 1;
	END WHILE;

	SELECT hasil;
END $$

DELIMITER;

CALL WhileLoop2();





/* Latihan Praktikum 4 */
-- 1
-- LOOP
DELIMITER $$
CREATE OR REPLACE PROCEDURE Kelipatan3_Loop()
BEGIN
    DECLARE i INT DEFAULT 3;
    DECLARE hasil VARCHAR(50) DEFAULT '';
    
    ulang: LOOP
        IF i >= 20 THEN
            LEAVE ulang;
        END IF;
        
        IF hasil = '' THEN
            SET hasil = i;
        ELSE
            SET hasil = CONCAT(hasil, ', ', i);
        END IF;
        
        SET i = i + 3;
    END LOOP ulang;
    
    SELECT hasil AS Kelipatan_3;
END $$

DELIMITER ;

CALL Kelipatan3_Loop();


-- REPEAT
DELIMITER $$
CREATE OR REPLACE PROCEDURE Kelipatan3_Repeat()
BEGIN
    DECLARE i INT DEFAULT 3;
    DECLARE hasil VARCHAR(50) DEFAULT '';
    
    REPEAT
        IF hasil = '' THEN
            SET hasil = i;
        ELSE
            SET hasil = CONCAT(hasil, ', ', i);
        END IF;
        
        SET i = i + 3;
    UNTIL i >= 20
    END REPEAT;
    
    SELECT hasil AS Kelipatan_3;
END $$

DELIMITER ;

CALL Kelipatan3_Repeat();


-- WHILE 
DELIMITER $$

CREATE OR REPLACE PROCEDURE Kelipatan3_While()
BEGIN
    DECLARE i INT DEFAULT 3;
    DECLARE hasil VARCHAR(50) DEFAULT '';
    
    WHILE i < 20 DO
        IF hasil = '' THEN
            SET hasil = i;
        ELSE
            SET hasil = CONCAT(hasil, ', ', i);
        END IF;
        
        SET i = i + 3;
    END WHILE;
    
    SELECT hasil AS Kelipatan_3;
END $$

DELIMITER ;

CALL Kelipatan3_While();





-- No 2
-- LOOP
DELIMITER $$

CREATE OR REPLACE PROCEDURE HasilNegatif_Loop()
BEGIN
    DECLARE angka INT DEFAULT 20;
    
    ulang: LOOP
        SET angka = angka - 7;
        
        IF angka < 0 THEN
            LEAVE ulang;
        END IF;
    END LOOP ulang;
    
    SELECT angka AS Hasil_Negatif_Pertama;
END $$

DELIMITER ;

CALL HasilNegatif_Loop();



-- REPEAT
DELIMITER $$

CREATE OR REPLACE PROCEDURE HasilNegatif_Repeat()
BEGIN
    DECLARE angka INT DEFAULT 20;
    
    REPEAT
        SET angka = angka - 7;
    UNTIL angka < 0
    END REPEAT;
    
    SELECT angka AS Hasil_Negatif_Pertama;
END $$

DELIMITER ;

CALL HasilNegatif_Repeat();



-- WHILE
DELIMITER $$

CREATE OR REPLACE PROCEDURE HasilNegatif_While()
BEGIN
    DECLARE angka INT DEFAULT 20;
    
    WHILE angka >= 0 DO
        SET angka = angka - 7;
    END WHILE;
    
    SELECT angka AS Hasil_Negatif_Pertama;
END $$

DELIMITER ;




-- No. 3 
-- LOOP
DELIMITER $$
CREATE OR REPLACE PROCEDURE MateriLoop1_Loop()
BEGIN
    DECLARE i INT DEFAULT 0;
    DECLARE total INT DEFAULT 0;
    
    ulang: LOOP
        SET i = i + 1;
        
        IF i > 10 THEN
            LEAVE ulang;
        END IF;
        
        IF i = 5 THEN
            ITERATE ulang;
        END IF;
        
        SET total = total + i;
    END LOOP ulang;
    
    SELECT total AS Total_Tanpa_Angka_5;
END $$

DELIMITER ;

CALL MateriLoop1_Loop();


-- REPEAT
DELIMITER $$
CREATE OR REPLACE PROCEDURE MateriLoop1_Repeat()
BEGIN
    DECLARE i INT DEFAULT 0;
    DECLARE total INT DEFAULT 0;
    
    ulang: REPEAT
        SET i = i + 1;
        
        IF i = 5 AND i <= 10 THEN
            ITERATE ulang;
        END IF;
        
        IF i <= 10 THEN
            SET total = total + i;
        END IF;
        
    UNTIL i >= 10
    END REPEAT ulang;
    
    SELECT total AS Total_Tanpa_Angka_5;
END $$

DELIMITER ;

CALL MateriLoop1_Repeat();



-- WHILE
DELIMITER $$
CREATE OR REPLACE PROCEDURE MateriLoop1_While()
BEGIN
    DECLARE i INT DEFAULT 0;
    DECLARE total INT DEFAULT 0;
    
    ulang: WHILE i < 10 DO
        SET i = i + 1;
        
        IF i = 5 THEN
            ITERATE ulang;
        END IF;
        
        SET total = total + i;
    END WHILE ulang;
    
    SELECT total AS Total_Tanpa_Angka_5;
END $$

DELIMITER ;

MateriLoop1_While()





/* ----- Tugas Praktikum 4  -------- */
/* 1. Gudang baru saja menerima kiriman produk Laptop (BR-01). Manajer ingin kamu menambah 
stok sebanyak 10 unit satu per satu ke dalam sistem untuk memastikan sinkronisasi data per unit berjalan lancar. 
Buatlah Stored Procedure tambah_stok_while menggunakan WHILE untuk menambah stok BR-01 sebanyak 10 kali. */

DELIMITER $$
CREATE OR REPLACE PROCEDURE tambah_stok_while()
BEGIN
    DECLARE i INT;
    SET i = 1;
    
    WHILE i <= 10 DO
        UPDATE barang 
        SET stok = stok + 1 
        WHERE kode_barang = 'BR-01';
        SET i = i + 1;
    END WHILE;
    
    SELECT * FROM barang WHERE kode_barang = 'BR-01';
END $$

DELIMITER ;

CALL tambah_stok_while();




/* 2. Karena ada inflasi, harga barang Koko (BR-03) harus naik Rp 2.000 setiap tahap. 
Direktur minta kenaikan ini dilakukan sebanyak 5 kali tahap saja. Buatlah Stored 
Procedure naik_harga_loop menggunakan LOOP dan LEAVE untuk menaikkan harga BR-03 sebesar 2000 sebanyak 5 kali perulangan. */

DELIMITER $$
CREATE OR REPLACE PROCEDURE naik_harga_loop()
BEGIN
    DECLARE counter INT;
    SET counter = 1;
    
    kenaikan: LOOP
        IF counter > 5 THEN
            LEAVE kenaikan;
        END IF;
       
        UPDATE barang 
        SET harga = harga + 2000 
        WHERE kode_barang = 'BR-03';
       
        SET counter = counter + 1;
    END LOOP kenaikan;
    SELECT * FROM barang WHERE kode_barang = 'BR-03';
END $$

DELIMITER ;

CALL naik_harga_loop();


/* 3 Tim IT ingin melakukan simulasi pengurangan stok pada barang Mobil (BR-07) sebanyak
1 unit untuk melihat apakah sistem error. Simulasi dilakukan sebanyak 3 kali.
Buatlah Stored Procedure simulasi_kurang_repeat menggunakan REPEAT untuk
mengurangi stok BR-07 sebanyak 1 unit per perulangan sampai mencapai 3 kali. */

DELIMITER $$
CREATE OR REPLACE PROCEDURE simulasi_kurang_repeat()
BEGIN
    DECLARE counter INT;
    SET counter = 1;
    
    REPEAT
        UPDATE barang 
        SET stok = stok - 1 
        WHERE kode_barang = 'BR-07';
        SET counter = counter + 1;
    UNTIL counter > 3
    END REPEAT;
    
    SELECT * FROM barang WHERE kode_barang = 'BR-07';
END $$

DELIMITER ;

CALL simulasi_kurang_repeat();