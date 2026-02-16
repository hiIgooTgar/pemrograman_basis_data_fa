USE mysql;
SHOW TABLES;

SELECT USER, HOST, PASSWORD FROM USER;


CREATE USER 'admin_pengaduan'@'localhost';

CREATE USER 'petugas_1'@'localhost' 
IDENTIFIED BY 'petugas123';

CREATE USER 'masyarakat'@'127.0.0.1' 
IDENTIFIED BY 'masyarakat123';  




DROP USER 'admin_pengaduan'@'localhost';
DROP USER 'petugas_1'@'localhost';
DROP USER 'masyarakat'@'127.0.0.1';




SELECT PASSWORD("petugas_321") AS petugas_3;

SET PASSWORD FOR 'admin_pengaduan'@'localhost' = 
PASSWORD("admin123");

SET PASSWORD FOR 'petugas_1'@'localhost' = "";




CREATE USER 'admin_pengaduan'@'localhost';
GRANT ALL ON pbd_pengaduan.*
TO 'admin_pengaduan'@'localhost';


CREATE USER 'petugas_1'@'localhost' 
IDENTIFIED BY 'petugas123';

GRANT SELECT, DELETE ON pbd_pengaduan.pengaduan
TO 'petugas_1'@'localhost';

GRANT SELECT, INSERT ON pbd_pengaduan.tanggapan
TO 'petugas_1'@'localhost';

GRANT SELECT(nama, email, jenis_kelamin, telepon) 
ON pbd_pengaduan.masyarakat TO 'petugas_1'@'localhost';



CREATE USER 'masyarakat'@'127.0.0.1' 
IDENTIFIED BY 'masyarakat123';

GRANT SELECT, INSERT ON pbd_pengaduan.pengaduan
TO 'masyarakat'@'127.0.0.1';

GRANT SELECT ON pbd_pengaduan.tanggapan
TO 'masyarakat'@'127.0.0.1';




SHOW GRANTS FOR 'admin_pengaduan'@'localhost';
SHOW GRANTS FOR  'petugas_1'@'localhost';
SHOW GRANTS FOR  'masyarakat'@'127.0.0.1';




REVOKE ALL ON pbd_pengaduan.*
FROM 'admin_pengaduan'@'localhost';

FLUSH PRIVILEGES;



REVOKE INSERT ON pbd_pengaduan.tanggapan 
FROM 'petugas_1'@'localhost';

REVOKE SELECT, DELETE ON pbd_pengaduan.pengaduan 
FROM 'petugas_1'@'localhost';

REVOKE SELECT, INSERT ON pbd_pengaduan.tanggapan 
FROM 'petugas_1'@'localhost';

REVOKE ALL ON pbd_pengaduan.pengaduan 
FROM 'petugas_1'@'localhost';

REVOKE ALL ON pbd_pengaduan.tanggapan 
FROM 'petugas_1'@'localhost';

REVOKE SELECT(jenis_kelamin) ON pbd_pengaduan.masyarakat 
FROM 'petugas_1'@'localhost';




REVOKE INSERT ON pbd_pengaduan.pengaduan 
FROM 'masyarakat'@'127.0.0.1';

REVOKE SELECT, INSERT ON pbd_pengaduan.pengaduan 
FROM 'masyarakat'@'127.0.0.1';

REVOKE SELECT ON pbd_pengaduan.tanggapan 
FROM 'masyarakat'@'127.0.0.1';

REVOKE ALL ON pbd_pengaduan.pengaduan 
FROM 'masyarakat'@'127.0.0.1';

REVOKE ALL ON pbd_pengaduan.tanggapan 
FROM 'masyarakat'@'127.0.0.1';



