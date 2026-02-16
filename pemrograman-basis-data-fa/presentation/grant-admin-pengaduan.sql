SELECT * FROM petugas;
SELECT * FROM masyarakat;
SELECT * FROM kategori_pengaduan;
SELECT * FROM pengaduan;
SELECT * FROM tanggapan;

INSERT INTO kategori_pengaduan (nama_kategori, deskripsi) VALUES 
('Pendidikan', 'Masalah pada tingkat sekolah');

INSERT INTO kategori_pengaduan (nama_kategori, deskripsi) VALUES 
('Lingkungan', 'Kerusakan lingkungan dan pencemaran');




UPDATE petugas SET telepon = '081299990000' WHERE id_petugas = 4;

DELETE FROM kategori_pengaduan WHERE id_pengaduan = 7;