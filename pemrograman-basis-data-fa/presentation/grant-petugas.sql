SELECT * FROM pengaduan;
SELECT * FROM tanggapan;
SELECT nama, email, jenis_kelamin, telepon FROM masyarakat;

INSERT INTO tanggapan (id_pengaduan, tgl_tanggapan, isi_tanggapan, id_petugas) VALUES 
(6, '2024-10-03', 'Petugas kebersihan sedang menuju lokasi', 3);

DELETE FROM pengaduan WHERE id_pengaduan = 1;

SELECT p.tgl_pengaduan, p.judul_pengaduan, m.nama, t.tgl_tanggapan, t.isi_tanggapan FROM tanggapan AS t
INNER JOIN pengaduan AS p ON p.id_pengaduan = t.id_pengaduan
INNER JOIN masyarakat AS m ON m.id_masyarakat = p.id_masyarakat





INSERT INTO pengaduan (tgl_pegaduan, judul_pengaduan, deskripsi_pengaduan, status_pengaduan, id_kategori_pengaduan, id_masyarakat) VALUES 
('2024-10-10', 'Jalan Rusak', 'Sekitar RT 05 rusak dan berlubang', 'Belum', 1, 5);

SELECT * FROM masyarakat;

INSERT INTO kategori_pengaduan (nama_kategori, deskripsi) VALUES 
('Pendidikan', 'Masalah pada tingkat sekolah');

UPDATE tanggapan SET isi_tanggapan = 'Jalan di sekitar RT 04 rusak dan berlubang' WHERE id_tanggapan = 6;