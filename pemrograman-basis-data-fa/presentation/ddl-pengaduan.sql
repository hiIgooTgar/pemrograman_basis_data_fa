CREATE DATABASE pbd_pengaduan;
USE pbd_pengaduan;

DROP DATABASE pbd_pengaduan;


CREATE TABLE petugas (
id_petugas INT AUTO_INCREMENT PRIMARY KEY,
nama VARCHAR(128),
email VARCHAR(255) UNIQUE,
PASSWORD VARCHAR(255),
jenis_kelamin ENUM("Laki-laki", "Perempuan"),
telepon CHAR(16)
)


CREATE TABLE masyarakat (
id_masyarakat INT AUTO_INCREMENT PRIMARY KEY,
nama VARCHAR(128),
email VARCHAR(255) UNIQUE,
PASSWORD VARCHAR(255),
jenis_kelamin ENUM("Laki-laki", "Perempuan"),
telepon CHAR(16),
agama ENUM("Islam", "Kristen", "Katholik", "Hindu", "Buddha", "Konghucu"),
rt INT(4),
rw INT(4),
pekerjaan VARCHAR(128),
status_pernikahan ENUM("Sudah Menikah", "Belum Menikah")
)


CREATE TABLE kategori_pengaduan (
 id_kategori_pengaduan INT AUTO_INCREMENT PRIMARY KEY,
 nama_kategori VARCHAR(255),
 deskripsi TEXT
)


CREATE TABLE pengaduan (
 id_pengaduan INT AUTO_INCREMENT PRIMARY KEY,
 tgl_pegaduan DATE,
 judul_pengaduan VARCHAR(255),
 deskripsi_pengaduan TEXT,
 status_pengaduan ENUM('Belum', 'Proses', 'Selesai', 'Tolak'),
 id_kategori_pengaduan INT,
 id_masyarakat INT,
 
 FOREIGN KEY (id_kategori_pengaduan) REFERENCES kategori_pengaduan(id_kategori_pengaduan),
 FOREIGN KEY (id_masyarakat) REFERENCES masyarakat(id_masyarakat)
)

CREATE TABLE tanggapan (
  id_tanggapan INT AUTO_INCREMENT PRIMARY KEY,
  id_pengaduan INT(11),
  tgl_tanggapan DATE,
  isi_tanggapan TEXT,
  id_petugas INT(11),
  
  FOREIGN KEY (id_pengaduan) REFERENCES pengaduan(id_pengaduan),
  FOREIGN KEY (id_petugas) REFERENCES petugas(id_petugas)
) 