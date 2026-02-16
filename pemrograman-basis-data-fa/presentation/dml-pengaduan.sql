SELECT * FROM petugas;
SELECT * FROM masyarakat;
SELECT * FROM kategori_pengaduan;
SELECT * FROM pengaduan;
SELECT * FROM tanggapan;



INSERT INTO petugas (nama, email, PASSWORD, jenis_kelamin, telepon) VALUES 
('Andi Wijaya', 'andi@email.com', 'petugas123', 'Laki-laki', '081234567890'),
('Siti Aminah', 'siti@email.com', 'petugas123', 'Perempuan', '081234567891'),
('Budi Santoso', 'budi@email.com', 'petugas123', 'Laki-laki', '081234567892'),
('Dewi Lestari', 'dewi@email.com', 'petugas123', 'Perempuan', '081234567893'),
('Eko Prasetyo', 'eko@email.com', 'petugas123', 'Laki-laki', '081234567894');


INSERT INTO masyarakat (nama, email, PASSWORD, jenis_kelamin, telepon, agama, rt, rw, pekerjaan, status_pernikahan) VALUES 
('Rizky Pratama', 'rizky@gmail.com', 'warga123', 'Laki-laki', '085711112222', 'Islam', 1, 5, 'Wiraswasta', 'Sudah Menikah'),
('Maya Sari', 'maya@gmail.com', 'warga123', 'Perempuan', '085711112223', 'Islam', 2, 5, 'Guru', 'Belum Menikah'),
('Hendra Gunawan', 'hendra@gmail.com', 'warga123', 'Laki-laki', '085711112224', 'Kristen', 3, 5, 'Karyawan Swasta', 'Sudah Menikah'),
('Lusiiana', 'lusi@gmail.com', 'warga123', 'Perempuan', '085711112225', 'Buddha', 1, 6, 'Mahasiswa', 'Belum Menikah'),
('Anton Kusuma', 'anton@gmail.com', 'warga123', 'Laki-laki', '085711112226', 'Katholik', 4, 6, 'Buruh', 'Sudah Menikah');


INSERT INTO kategori_pengaduan (nama_kategori, deskripsi) VALUES 
('Infrastruktur', 'Masalah jalan rusak, jembatan, dan fasilitas umum'),
('Kebersihan', 'Masalah sampah dan saluran air mampet'),
('Keamanan', 'Laporan tindak kriminal atau gangguan ketertiban'),
('Kesehatan', 'Layanan puskesmas atau wabah penyakit'),
('Administrasi', 'Masalah pengurusan KTP, KK, dan surat lainnya');


INSERT INTO pengaduan (tgl_pengaduan, judul_pengaduan, deskripsi_pengaduan, status_pengaduan, id_kategori_pengaduan, id_masyarakat) VALUES 
('2023-10-01', 'Jalan Berlubang', 'Jalan di depan RT 01 rusak parah', 'Belum', 1, 1),
('2023-10-02', 'Penumpukan Sampah', 'Sampah di TPS pasar tidak diangkut 3 hari', 'Proses', 2, 2),
('2023-10-03', 'Lampu Jalan Mati', 'Rawan begal karena lampu jalan padam', 'Belum', 3, 3),
('2023-10-04', 'Layanan Antrian Lama', 'Antrian di puskesmas sangat lambat', 'Selesai', 4, 4),
('2023-10-05', 'Salah Cetak KK', 'Nama di Kartu Keluarga tidak sesuai', 'Tolak', 5, 5);


INSERT INTO tanggapan (id_pengaduan, tgl_tanggapan, isi_tanggapan, id_petugas) VALUES 
(2, '2023-10-03', 'Petugas kebersihan sedang menuju lokasi', 1),
(4, '2023-10-05', 'Terima kasih, layanan sudah diperbaiki', 2),
(1, '2023-10-02', 'Laporan diterima, akan segera ditinjau dinas PU', 3),
(5, '2023-10-06', 'Mohon lampirkan dokumen pendukung asli', 4),
(3, '2023-10-04', 'Patroli keamanan akan ditingkatkan di area tersebut', 5);




UPDATE petugas SET telepon = '081299990000' WHERE id_petugas = 1;

UPDATE masyarakat SET status_pernikahan = 'Sudah Menikah' WHERE id_masyarakat = 2;

UPDATE kategori_pengaduan SET deskripsi = 'Laporan terkait keamanan dan ketertiban lingkungan' WHERE id_kategori_pengaduan = 3;

UPDATE pengaduan SET status_pengaduan = 'Selesai' WHERE id_pengaduan = 2;

UPDATE tanggapan SET isi_tanggapan = 'Petugas sudah selesai mengangkut sampah di lokasi' WHERE id_tanggapan = 1;













INSERT INTO petugas (nama, email, PASSWORD, jenis_kelamin, telepon) VALUES 
('Rahmat Hidayat', 'rahmat@email.com', 'petugas123', 'Laki-laki', '081234567895'),
('Nur Aisyah', 'aisyah@email.com', 'petugas123', 'Perempuan', '081234567896'),
('Dimas Saputra', 'dimas@email.com', 'petugas123', 'Laki-laki', '081234567897'),
('Fitri Handayani', 'fitri@email.com', 'petugas123', 'Perempuan', '081234567898'),
('Agus Setiawan', 'agus@email.com', 'petugas123', 'Laki-laki', '081234567899');


INSERT INTO masyarakat 
(nama, email, PASSWORD, jenis_kelamin, telepon, agama, rt, rw, pekerjaan, status_pernikahan) VALUES 
('Doni Firmansyah', 'doni@gmail.com', 'warga123', 'Laki-laki', '085711112227', 'Islam', 2, 6, 'Teknisi', 'Sudah Menikah'),
('Intan Permata', 'intan@gmail.com', 'warga123', 'Perempuan', '085711112228', 'Islam', 3, 6, 'Perawat', 'Belum Menikah'),
('Rudi Hartono', 'rudi@gmail.com', 'warga123', 'Laki-laki', '085711112229', 'Kristen', 4, 7, 'Supir', 'Sudah Menikah'),
('Melati Putri', 'melati@gmail.com', 'warga123', 'Perempuan', '085711112230', 'Hindu', 1, 7, 'Karyawan Swasta', 'Belum Menikah'),
('Yusuf Maulana', 'yusuf@gmail.com', 'warga123', 'Laki-laki', '085711112231', 'Islam', 5, 7, 'Pedagang', 'Sudah Menikah');


INSERT INTO kategori_pengaduan (nama_kategori, deskripsi) VALUES 
('Lingkungan', 'Kerusakan lingkungan dan pencemaran'),
('Pendidikan', 'Masalah fasilitas dan layanan pendidikan'),
('Transportasi', 'Angkutan umum dan rambu lalu lintas'),
('Sosial', 'Konflik sosial dan bantuan masyarakat'),
('Perizinan', 'Masalah izin usaha dan bangunan');


INSERT INTO pengaduan 
(tgl_pegaduan, judul_pengaduan, deskripsi_pengaduan, status_pengaduan, id_kategori_pengaduan, id_masyarakat) VALUES 
('2023-10-06', 'Pencemaran Sungai', 'Air sungai berbau dan berwarna hitam', 'Belum', 6, 6),
('2023-10-07', 'Kelas Rusak', 'Atap sekolah bocor saat hujan', 'Proses', 7, 7),
('2023-10-08', 'Halte Rusak', 'Halte bus rusak dan tidak terawat', 'Belum', 8, 8),
('2023-10-09', 'Konflik Warga', 'Perselisihan antar warga RT 07', 'Proses', 9, 9),
('2023-10-10', 'Izin Usaha Lama', 'Pengurusan izin usaha terlalu lama', 'Belum', 10, 10);


INSERT INTO tanggapan 
(id_pengaduan, tgl_tanggapan, isi_tanggapan, id_petugas) VALUES 
(6, '2023-10-07', 'Tim lingkungan akan melakukan pengecekan lokasi', 6),
(7, '2023-10-08', 'Pihak sekolah sedang mengajukan perbaikan', 7),
(8, '2023-10-09', 'Dinas perhubungan akan menindaklanjuti', 8),
(9, '2023-10-10', 'Mediasi antar warga sedang dijadwalkan', 9),
(10, '2023-10-11', 'Permohonan sedang dalam proses verifikasi', 10);
