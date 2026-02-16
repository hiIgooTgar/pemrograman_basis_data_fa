SELECT * FROM pengaduan;
SELECT * FROM tanggapan;

INSERT INTO pengaduan (tgl_pegaduan, judul_pengaduan, deskripsi_pengaduan, status_pengaduan, id_kategori_pengaduan, id_masyarakat) VALUES 
('2024-10-01', 'Jalan Berlubang', 'Jalan di sekitar RT 02 rusak dan berlubang', 'Belum', 1, 3);

INSERT INTO pengaduan (tgl_pegaduan, judul_pengaduan, deskripsi_pengaduan, status_pengaduan, id_kategori_pengaduan, id_masyarakat) VALUES 
('2024-10-05', 'Jalan Berlubang', 'Di belakang RW 10 berlubang', 'Belum', 1, 3);




UPDATE pengaduan SET judul_pengaduan = 'Jalan Rusak' WHERE id_pengaduan = 6;

DELETE FROM pengaduan WHERE id_pengaduan = 1;

SELECT * FROM masyarakat;