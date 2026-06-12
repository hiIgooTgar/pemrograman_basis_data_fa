CREATE DATABASE 24sa11a159_listrik;
USE 24sa11a159_listrik;

DROP DATABASE 24sa11a159_listrik;

CREATE TABLE pelanggan (
	id_pelanggan INT PRIMARY KEY,
	nama_pelanggan VARCHAR(128),
	alamat VARCHAR(128)
);

CREATE TABLE golongan (
	id INT(11) UNIQUE,
	gol VARCHAR(64),
	tarif INT(11)
);

CREATE TABLE daya_terpasang (
	id_pelanggan INT,
	golongan VARCHAR(128),
	daya INT,
	FOREIGN KEY(id_pelanggan) REFERENCES pelanggan(id_pelanggan)
);







-- =========================================================================
-- JAWABAN SOAL 1: PEMBUATAN DATABASE DAN TABEL
-- =========================================================================

CREATE DATABASE IF NOT EXISTS bandara;
USE bandara;

-- a. Tabel Penerbangan
CREATE TABLE penerbangan (
    penerbanganno VARCHAR(10) PRIMARY KEY,
    asal VARCHAR(50),
    tujuan VARCHAR(50),
    jarak INT
);

-- b. Tabel Pesawat
CREATE TABLE pesawat (
    pesawatno VARCHAR(10) PRIMARY KEY,
    pesawatnama VARCHAR(50),
    jaraktempuh INT
);

-- c. Tabel Berangkat
CREATE TABLE berangkat (
    penerbanganno VARCHAR(10), -- Ditambahkan sebagai penghubung ke tabel penerbangan
    waktu_tiba TIME,
    harga INT,
    pesawatno VARCHAR(10),
    PRIMARY KEY (penerbanganno, pesawatno),
    FOREIGN KEY (penerbanganno) REFERENCES penerbangan(penerbanganno) ON DELETE CASCADE,
    FOREIGN KEY (pesawatno) REFERENCES pesawat(pesawatno) ON DELETE CASCADE
);

-- d. Tabel Pilot
CREATE TABLE pilot (
    pilotid VARCHAR(10) PRIMARY KEY,
    pilotnama VARCHAR(50),
    gaji INT
);

-- e. Tabel Sertifikat
CREATE TABLE sertifikat (
    pilotid VARCHAR(10),
    pesawatno VARCHAR(10),
    PRIMARY KEY (pilotid, pesawatno),
    FOREIGN KEY (pilotid) REFERENCES pilot(pilotid) ON DELETE CASCADE,
    FOREIGN KEY (pesawatno) REFERENCES pesawat(pesawatno) ON DELETE CASCADE
);


-- =========================================================================
-- JAWABAN SOAL 2: OPTIMASI QUERY
-- =========================================================================

-- Optimasi Query 2.a: 
-- Menyederhanakan redundansi aljabar boolean (hukum absorpsi), 
-- serta memperbaiki format waktu ('10:00:00') dan angka tanpa koma (700000).
SELECT penerbanganno 
FROM penerbangan p
JOIN berangkat b ON p.penerbanganno = b.penerbanganno
WHERE b.waktu_tiba = '10:00:00' OR b.harga > 700000;


-- Optimasi Query 2.b:
-- Mengubah implicit join (koma) menjadi EXPLICIT JOIN (INNER JOIN),
-- memperbaiki penulisan alias kolom yang terbalik (seharusnya alias.kolom),
-- dan menghubungkan tabel penerbangan lewat tabel berangkat agar relasinya valid.
SELECT plt.pilotnama 
FROM pilot plt
INNER JOIN sertifikat s ON plt.pilotid = s.pilotid
INNER JOIN pesawat pst ON s.pesawatno = pst.pesawatno
INNER JOIN berangkat b ON pst.pesawatno = b.pesawatno
INNER JOIN penerbangan p ON b.penerbanganno = p.penerbanganno
WHERE p.asal = 'semarang' 
  AND pst.pesawatnama LIKE '%boeing%';