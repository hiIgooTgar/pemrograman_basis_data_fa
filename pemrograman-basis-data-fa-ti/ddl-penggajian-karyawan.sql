CREATE DATABASE 24sa11a159_penggajian_karyawan;
USE 24sa11a159_penggajian_karyawan;


CREATE TABLE departemen (
 IdDepartemen CHAR(4) PRIMARY KEY,
 NamaDepartemen VARCHAR(60)
)

CREATE TABLE jabatan (
 IdJabatan CHAR(3) PRIMARY KEY,
 NamaJabatan VARCHAR(60),
 GajiPokok INT 
)

CREATE TABLE tunjangan (
 IdTunjangan CHAR(3) PRIMARY KEY,
 NamaTunjangan VARCHAR(60),
 JmlTunjangan INT
)

CREATE TABLE potongan (
 IdPotongan CHAR(3) PRIMARY KEY,
 NamaPotongan VARCHAR(60),
 JmlPotongan INT
)

CREATE TABLE employees (
 IdKaryawan VARCHAR(10) PRIMARY KEY,
 Nama VARCHAR(60),
 IdDepartemen CHAR(4),
 IdJabatan CHAR(3),
 TglMasuk DATE,
 STATUS ENUM('Aktif','NonAktif'),
 
 FOREIGN KEY (IdDepartemen) REFERENCES departemen(IdDepartemen),
 FOREIGN KEY (IdJabatan) REFERENCES jabatan(IdJabatan)
)

CREATE TABLE penggajian (
 IdPenggajian INT PRIMARY KEY,
 IdKaryawan VARCHAR(10),
 TglGaji DATE,
 TotalTunjangan INT,
 TotalPotongan INT,
 GajiBersih INT,
 
 FOREIGN KEY (IdKaryawan) REFERENCES employees(IdKaryawan)
)

CREATE TABLE tunjangan_karyawan (
 IdDetailTunjangan INT PRIMARY KEY,
 IdKaryawan VARCHAR(10),
 IdTunjangan CHAR(3),
 Jumlah INT,
 
 FOREIGN KEY (IdKaryawan) REFERENCES employees(IdKaryawan),
 FOREIGN KEY (IdTunjangan) REFERENCES tunjangan(IdTunjangan)
)

CREATE TABLE potongan_karyawan (
 IdDetailPotongan INT PRIMARY KEY,
 IdKaryawan VARCHAR(10),
 IdPotongan CHAR(3),
 Jumlah INT,
 
 FOREIGN KEY (IdKaryawan) REFERENCES employees(IdKaryawan),
 FOREIGN KEY (IdPotongan) REFERENCES potongan(IdPotongan)
)