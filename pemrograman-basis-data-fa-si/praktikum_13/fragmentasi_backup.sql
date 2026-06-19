/*
SQLyog Community v13.3.1 (64 bit)
MySQL - 10.4.32-MariaDB : Database - 24sa11a159_mart
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`24sa11a159_mart` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;

USE `24sa11a159_mart`;

/*Table structure for table `barang` */

DROP TABLE IF EXISTS `barang`;

CREATE TABLE `barang` (
  `kode_barang` varchar(10) NOT NULL,
  `nama_barang` varchar(30) DEFAULT NULL,
  `kode_kategori` varchar(10) DEFAULT NULL,
  `kode_supplier` varchar(10) DEFAULT NULL,
  `harga` int(10) DEFAULT NULL,
  `stok` int(10) DEFAULT NULL,
  `jumlah_terjual` int(11) DEFAULT 0,
  `catatan` varchar(30) DEFAULT '',
  PRIMARY KEY (`kode_barang`),
  KEY `idx_fk_kategori` (`kode_kategori`),
  KEY `idx_fk_supplier` (`kode_supplier`),
  KEY `idx_harga` (`harga`),
  KEY `idx_kategori_stok` (`kode_kategori`,`stok`),
  CONSTRAINT `barang_ibfk_1` FOREIGN KEY (`kode_kategori`) REFERENCES `kategori` (`kode_kategori`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `barang_ibfk_2` FOREIGN KEY (`kode_supplier`) REFERENCES `supplier` (`kode_supplier`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `barang` */

insert  into `barang`(`kode_barang`,`nama_barang`,`kode_kategori`,`kode_supplier`,`harga`,`stok`,`jumlah_terjual`,`catatan`) values 
('B001','Laptop Asus','K01','S003',200000,10,10,'NORMAL'),
('B002','Mouse Logitech','K01','S006',156750,50,30,'POTENSIAL'),
('B003','Buku Tulis 58lbr','K02','S002',4489,105,34,'POTENSIAL'),
('B004','Beras Premium 5kg','K03','S005',78375,27,41,'POTENSIAL'),
('B005','Kaos Polos','K04','S009',52250,45,55,'BEST SELLER'),
('B006','Vitamin C 500mg','K05','S008',21000,203,15,'NORMAL'),
('B007','Bola Basket','K06','S004',125400,10,10,'NORMAL'),
('B008','Oli Mesin 1L','K07','S001',67925,25,8,'NORMAL'),
('B009','Lampu LED 10W','K09','S007',34913,65,89,'BEST SELLER');

/*Table structure for table `barang_audit` */

DROP TABLE IF EXISTS `barang_audit`;

CREATE TABLE `barang_audit` (
  `kode_barang` varchar(10) NOT NULL,
  `kode_supplier` varchar(10) DEFAULT NULL,
  `jumlah_terjual` int(11) DEFAULT NULL,
  `catatan` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`kode_barang`),
  CONSTRAINT `barang_audit_ibfk_1` FOREIGN KEY (`kode_barang`) REFERENCES `barang_toko` (`kode_barang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `barang_audit` */

insert  into `barang_audit`(`kode_barang`,`kode_supplier`,`jumlah_terjual`,`catatan`) values 
('B001','S003',10,'NORMAL'),
('B002','S006',30,'POTENSIAL'),
('B003','S002',34,'POTENSIAL'),
('B004','S005',41,'POTENSIAL'),
('B005','S009',55,'BEST SELLER'),
('B006','S008',15,'NORMAL'),
('B007','S004',10,'NORMAL'),
('B008','S001',8,'NORMAL'),
('B009','S007',89,'BEST SELLER');

/*Table structure for table `barang_frag_horizontal` */

DROP TABLE IF EXISTS `barang_frag_horizontal`;

CREATE TABLE `barang_frag_horizontal` (
  `kode_barang` varchar(10) NOT NULL,
  `nama_barang` varchar(30) DEFAULT NULL,
  `kode_kategori` varchar(10) NOT NULL,
  `kode_supplier` varchar(10) DEFAULT NULL,
  `harga` int(10) DEFAULT NULL,
  `stok` int(10) DEFAULT NULL,
  `jumlah_terjual` int(11) DEFAULT NULL,
  `catatan` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`kode_barang`,`kode_kategori`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci
 PARTITION BY LIST  COLUMNS(`kode_kategori`)
(PARTITION `p_elektronik` VALUES IN ('K01') ENGINE = InnoDB,
 PARTITION `p_makanan_minuman` VALUES IN ('K02','K03') ENGINE = InnoDB,
 PARTITION `p_pakaian` VALUES IN ('K04') ENGINE = InnoDB,
 PARTITION `p_otomotif_furniture` VALUES IN ('K07') ENGINE = InnoDB,
 PARTITION `p_cadangan` VALUES IN ('K05','K06','K09') ENGINE = InnoDB);

/*Data for the table `barang_frag_horizontal` */

insert  into `barang_frag_horizontal`(`kode_barang`,`nama_barang`,`kode_kategori`,`kode_supplier`,`harga`,`stok`,`jumlah_terjual`,`catatan`) values 
('B001','Laptop Asus','K01','S003',200000,10,10,'NORMAL'),
('B002','Mouse Logitech','K01','S006',156750,50,30,'POTENSIAL'),
('B003','Buku Tulis 58lbr','K02','S002',4489,105,34,'POTENSIAL'),
('B004','Beras Premium 5kg','K03','S005',78375,27,41,'POTENSIAL'),
('B005','Kaos Polos','K04','S009',52250,45,55,'BEST SELLER'),
('B008','Oli Mesin 1L','K07','S001',67925,25,8,'NORMAL'),
('B006','Vitamin C 500mg','K05','S008',21000,203,15,'NORMAL'),
('B007','Bola Basket','K06','S004',125400,10,10,'NORMAL'),
('B009','Lampu LED 10W','K09','S007',34913,65,89,'BEST SELLER');

/*Table structure for table `barang_toko` */

DROP TABLE IF EXISTS `barang_toko`;

CREATE TABLE `barang_toko` (
  `kode_barang` varchar(10) NOT NULL,
  `nama_barang` varchar(30) DEFAULT NULL,
  `kode_kategori` varchar(10) DEFAULT NULL,
  `harga` int(10) DEFAULT NULL,
  `stok` int(10) DEFAULT NULL,
  PRIMARY KEY (`kode_barang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `barang_toko` */

insert  into `barang_toko`(`kode_barang`,`nama_barang`,`kode_kategori`,`harga`,`stok`) values 
('B001','Laptop Asus','K01',200000,10),
('B002','Mouse Logitech','K01',156750,50),
('B003','Buku Tulis 58lbr','K02',4489,105),
('B004','Beras Premium 5kg','K03',78375,27),
('B005','Kaos Polos','K04',52250,45),
('B006','Vitamin C 500mg','K05',21000,203),
('B007','Bola Basket','K06',125400,10),
('B008','Oli Mesin 1L','K07',67925,25),
('B009','Lampu LED 10W','K09',34913,65);

/*Table structure for table `customer` */

DROP TABLE IF EXISTS `customer`;

CREATE TABLE `customer` (
  `kode_customer` varchar(10) NOT NULL,
  `nama_customer` varchar(30) DEFAULT NULL,
  `alamat_customer` varchar(30) DEFAULT NULL,
  `telepon_customer` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`kode_customer`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `customer` */

insert  into `customer`(`kode_customer`,`nama_customer`,`alamat_customer`,`telepon_customer`) values 
('C001','Andi Wijaya','Jl. Merdeka No. 10','081234567890'),
('C002','Budi Santoso','Jl. Mawar No. 5','081234567891'),
('C003','Citra Lestari','Jl. Melati No. 22','081234567892'),
('C004','Deni Pratama','Jl. Anggrek No. 15','081234567893'),
('C005','Eka Putri','Jakarta','081234567894'),
('C006','Fajar Ramadhan','Jl. Dahlia No. 3','081234567895'),
('C007','Gita Permata','Jl. Kamboja No. 12','081234567896'),
('C008','Hadi Sucipto','Jl. Teratai No. 7','081234567897'),
('C009','Indah Sari','Jl. Tulip No. 9','081234567898'),
('C010','Joko Susilo','Jl. Sakura No. 11','081234567899');

/*Table structure for table `kategori` */

DROP TABLE IF EXISTS `kategori`;

CREATE TABLE `kategori` (
  `kode_kategori` varchar(10) NOT NULL,
  `nama_kategori` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`kode_kategori`),
  KEY `idx_nama_kategori` (`nama_kategori`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `kategori` */

insert  into `kategori`(`kode_kategori`,`nama_kategori`) values 
('K02','Alat Tulis'),
('K01','Elektronik'),
('K10','Kecantikan'),
('K05','Kesehatan'),
('K08','Mainan Anak'),
('K06','Olahraga'),
('K07','Otomotif'),
('K04','Pakaian'),
('K09','Perabot Rumah'),
('K03','Sembako');

/*Table structure for table `log_barang_terhapus` */

DROP TABLE IF EXISTS `log_barang_terhapus`;

CREATE TABLE `log_barang_terhapus` (
  `id_log` int(11) NOT NULL AUTO_INCREMENT,
  `kode_barang` varchar(10) DEFAULT NULL,
  `nama_barang_lama` varchar(50) DEFAULT NULL,
  `stok_terakhir` int(11) DEFAULT NULL,
  `tanggal_dihapus` datetime DEFAULT NULL,
  `user_pembatal` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_log`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `log_barang_terhapus` */

insert  into `log_barang_terhapus`(`id_log`,`kode_barang`,`nama_barang_lama`,`stok_terakhir`,`tanggal_dihapus`,`user_pembatal`) values 
(1,'B010','Lipstick Matte',40,'2026-05-22 07:12:43','root@localhost');

/*Table structure for table `log_customer` */

DROP TABLE IF EXISTS `log_customer`;

CREATE TABLE `log_customer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `kode_customer` varchar(10) DEFAULT NULL,
  `alamat_lama` varchar(100) DEFAULT NULL,
  `alamat_baru` varchar(100) DEFAULT NULL,
  `waktu` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `log_customer` */

insert  into `log_customer`(`id`,`kode_customer`,`alamat_lama`,`alamat_baru`,`waktu`) values 
(1,'C005','Jl. Kenanga No. 8','Jakarta','2026-05-22 06:58:20');

/*Table structure for table `pegawai` */

DROP TABLE IF EXISTS `pegawai`;

CREATE TABLE `pegawai` (
  `id_pegawai` int(11) NOT NULL AUTO_INCREMENT,
  `nama_pegawai` varchar(50) DEFAULT NULL,
  `gaji_pokok` int(11) DEFAULT 0,
  `bonus` int(11) DEFAULT 0,
  PRIMARY KEY (`id_pegawai`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `pegawai` */

insert  into `pegawai`(`id_pegawai`,`nama_pegawai`,`gaji_pokok`,`bonus`) values 
(1,'Budi Sunandar',5000000,500000),
(2,'Siti Aminah',7500000,750000),
(3,'Agus Pratama',4000000,400000),
(4,'Rina Septiani',6000000,600000),
(5,'Dedi Kurniawan',5500000,550000);

/*Table structure for table `pembelian` */

DROP TABLE IF EXISTS `pembelian`;

CREATE TABLE `pembelian` (
  `kode_pembelian` varchar(10) NOT NULL,
  `kode_barang` varchar(10) DEFAULT NULL,
  `jumlah_beli` int(10) DEFAULT NULL,
  PRIMARY KEY (`kode_pembelian`),
  KEY `pembelian_ibfk_1` (`kode_barang`),
  CONSTRAINT `pembelian_ibfk_1` FOREIGN KEY (`kode_barang`) REFERENCES `barang` (`kode_barang`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `pembelian` */

insert  into `pembelian`(`kode_pembelian`,`kode_barang`,`jumlah_beli`) values 
('P001','B001',5),
('P002','B002',20),
('P003','B003',50),
('P004','B004',15),
('P005','B005',10),
('P006','B006',100),
('P007','B007',5),
('P008','B008',12),
('P009','B009',30);

/*Table structure for table `supplier` */

DROP TABLE IF EXISTS `supplier`;

CREATE TABLE `supplier` (
  `kode_supplier` varchar(10) NOT NULL,
  `nama_supplier` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`kode_supplier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `supplier` */

insert  into `supplier`(`kode_supplier`,`nama_supplier`) values 
('S001','PT Maju Jaya'),
('S002','CV Sumber Makmur'),
('S003','PT Elektronik Utama'),
('S004','Distributor Sejahtera'),
('S005','Grosir Sembako Rejeki'),
('S006','PT Tekno Global'),
('S007','CV Alam Sari'),
('S008','Supplier Utama Mandiri'),
('S009','PT Citra Perkasa'),
('S010','Indo Logistic Group');

/*Table structure for table `transaksi` */

DROP TABLE IF EXISTS `transaksi`;

CREATE TABLE `transaksi` (
  `kode_transaksi` varchar(10) NOT NULL,
  `kode_customer` varchar(10) DEFAULT NULL,
  `kode_barang` varchar(10) DEFAULT NULL,
  `tanggal_transaksi` date DEFAULT NULL,
  `jumlah_transaksi` int(4) DEFAULT NULL,
  PRIMARY KEY (`kode_transaksi`),
  KEY `transaksi_ibfk_1` (`kode_customer`),
  KEY `transaksi_ibfk_2` (`kode_barang`),
  CONSTRAINT `transaksi_ibfk_1` FOREIGN KEY (`kode_customer`) REFERENCES `customer` (`kode_customer`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `transaksi_ibfk_2` FOREIGN KEY (`kode_barang`) REFERENCES `barang` (`kode_barang`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `transaksi` */

insert  into `transaksi`(`kode_transaksi`,`kode_customer`,`kode_barang`,`tanggal_transaksi`,`jumlah_transaksi`) values 
('T001','C001','B001','2024-03-01',1),
('T002','C002','B003','2024-03-01',5),
('T003','C003','B004','2025-03-02',2),
('T004','C004','B002','2026-03-02',1),
('T005','C005','B006','2024-03-03',3),
('T007','C007','B005','2025-03-04',1),
('T008','C008','B009','2025-03-04',4),
('T010','C010','B007','2026-03-04',1),
('T011','C001','B002','2026-03-05',2),
('T012','C002','B006','2026-03-05',10),
('T013','C003','B005','2026-03-06',3),
('T014','C004','B008','2026-03-06',1),
('T015','C005','B001','2026-03-07',1),
('T016','C006','B003','2026-03-08',12),
('T017','C007','B004','2026-03-09',4),
('T018','C008','B007','2026-03-10',2),
('T019','C009','B008','2026-03-11',1),
('T020','C010','B009','2026-03-12',5),
('T021','C001','B004','2026-03-15',2),
('T022','C003','B002','2026-03-15',1),
('T023','C005','B003','2026-03-16',6),
('T024','C007','B008','2026-03-17',2),
('T025','C009','B006','2026-03-18',20),
('T026','C002','B001','2026-03-20',1),
('T027','C004','B009','2026-03-22',3),
('T028','C006','B005','2026-03-24',2),
('T029','C008','B009','2026-03-25',4),
('T030','C010','B007','2026-03-27',1),
('T031','C002','B002','2026-04-01',3),
('T032','C004','B004','2026-04-01',1),
('T033','C006','B006','2026-04-02',15),
('T034','C008','B008','2026-04-03',2),
('T035','C010','B007','2026-04-05',3),
('T036','C001','B003','2026-04-06',10),
('T037','C003','B005','2026-04-07',4),
('T038','C005','B007','2026-04-08',2),
('T039','C007','B009','2026-04-09',5),
('T040','C009','B001','2026-04-10',1),
('T041','C001','B006','2026-04-12',8),
('T042','C002','B004','2026-04-14',2),
('T043','C003','B009','2026-04-15',3),
('T044','C004','B003','2026-04-16',20),
('T045','C005','B002','2026-04-18',2),
('T046','C006','B008','2026-04-20',1),
('T047','C007','B002','2026-04-22',2),
('T048','C008','B001','2026-04-25',1),
('T049','C009','B005','2026-04-26',5),
('T050','C010','B007','2026-04-28',2);

/* Trigger structure for table `barang` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `trg_log_hapus_barang` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'localhost' */ /*!50003 TRIGGER `trg_log_hapus_barang` AFTER DELETE ON `barang` FOR EACH ROW 
BEGIN
    INSERT INTO log_barang_terhapus 
        SET kode_barang = OLD.kode_barang,
        nama_barang_lama = OLD.nama_barang, 
        stok_terakhir = OLD.stok,
        tanggal_dihapus = NOW(), 
        user_pembatal = current_User();
END */$$


DELIMITER ;

/* Trigger structure for table `customer` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `update_alamat_customer` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'localhost' */ /*!50003 TRIGGER `update_alamat_customer` BEFORE UPDATE ON `customer` FOR EACH ROW 
BEGIN
        INSERT INTO log_customer 
        set kode_customer = OLD.kode_customer,
        alamat_lama = OLD.alamat_customer, 
        alamat_baru = NEW.alamat_customer,
        waktu = now();
END */$$


DELIMITER ;

/*Table structure for table `v_barang_monolith_transparan` */

DROP TABLE IF EXISTS `v_barang_monolith_transparan`;

/*!50001 DROP VIEW IF EXISTS `v_barang_monolith_transparan` */;
/*!50001 DROP TABLE IF EXISTS `v_barang_monolith_transparan` */;

/*!50001 CREATE TABLE  `v_barang_monolith_transparan`(
 `kode_barang` varchar(10) ,
 `nama_barang` varchar(30) ,
 `kode_kategori` varchar(10) ,
 `harga` int(10) ,
 `stok` int(10) ,
 `kode_supplier` varchar(10) ,
 `jumlah_terjual` int(11) ,
 `catatan` varchar(20) 
)*/;

/*View structure for view v_barang_monolith_transparan */

/*!50001 DROP TABLE IF EXISTS `v_barang_monolith_transparan` */;
/*!50001 DROP VIEW IF EXISTS `v_barang_monolith_transparan` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_barang_monolith_transparan` AS select `t`.`kode_barang` AS `kode_barang`,`t`.`nama_barang` AS `nama_barang`,`t`.`kode_kategori` AS `kode_kategori`,`t`.`harga` AS `harga`,`t`.`stok` AS `stok`,`a`.`kode_supplier` AS `kode_supplier`,`a`.`jumlah_terjual` AS `jumlah_terjual`,`a`.`catatan` AS `catatan` from (`barang_toko` `t` join `barang_audit` `a` on(`t`.`kode_barang` = `a`.`kode_barang`)) */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
