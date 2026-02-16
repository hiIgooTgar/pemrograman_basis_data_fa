LOCK TABLE petugas READ;
LOCK TABLE masyarakat READ;
LOCK TABLE kategori_pengaduan READ;
LOCK TABLE pengaduan READ;
LOCK TABLE tanggapan READ;



LOCK TABLE petugas WRITE;
LOCK TABLE masyarakat WRITE;
LOCK TABLE kategori_pengaduan WRITE;
LOCK TABLE pengaduan WRITE;
LOCK TABLE tanggapan WRITE;



UNLOCK TABLE;




