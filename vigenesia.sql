-- phpMyAdmin SQL Dump
-- version 3.5.2.2
-- http://www.phpmyadmin.net
--
-- Inang: 127.0.0.1
-- Waktu pembuatan: 14 Nov 2023 pada 01.29
-- Versi Server: 5.5.27
-- Versi PHP: 5.4.7

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Basis data: `vigenesia`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `kategori`
--

CREATE TABLE IF NOT EXISTS `kategori` (
  `id` int(11) NOT NULL,
  `kategori` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur dari tabel `motivasi`
--

CREATE TABLE IF NOT EXISTS `motivasi` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `isi_motivasi` text NOT NULL,
  `iduser` int(11) NOT NULL,
  `tanggal_input` date NOT NULL,
  `tanggal_update` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `iduser` (`iduser`),
  KEY `iduser_2` (`iduser`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 AUTO_INCREMENT=58 ;

--
-- Dumping data untuk tabel `motivasi`
--

INSERT INTO `motivasi` (`id`, `isi_motivasi`, `iduser`, `tanggal_input`, `tanggal_update`) VALUES
(24, 'Hujan tetap semangat beljar', 4, '2022-11-04', '0000-00-00'),
(25, 'Hujan tetap semangat beljar', 4, '2022-11-04', '0000-00-00'),
(26, 'Manja terus kurang sehat', 4, '2022-11-04', '0000-00-00'),
(27, 'Membangun ekosistem digital', 5, '2022-11-06', '0000-00-00'),
(28, 'sikat bleh', 10, '2022-11-09', '0000-00-00'),
(29, 'Mantab masih ada PR', 9, '2022-11-09', '0000-00-00'),
(30, 'belum bisa tapi yakin bisa', 10, '2022-11-09', '0000-00-00'),
(31, 'Mks Pa Sri, sudah dikasih kesempatan di depan, sering-sering yaa', 12, '2022-11-10', '0000-00-00'),
(48, 'segera jalan', 21, '2023-10-28', '0000-00-00'),
(49, 'bisakah', 21, '2023-10-28', '0000-00-00'),
(50, 'jaringan kurang bagus', 21, '2023-10-28', '0000-00-00'),
(51, 'alhamdulillah bisa', 21, '2023-10-28', '0000-00-00'),
(52, 'Kuliah..? BSI Aja !', 21, '2023-10-29', '0000-00-00'),
(53, 'Bismillah beraktifitas', 21, '2023-11-14', '0000-00-00'),
(54, 'Semangat 45', 21, '2023-11-14', '0000-00-00'),
(55, 'Selalu semangat 10 Nov', 21, '2023-11-14', '0000-00-00'),
(56, 'Melalui aktifitas dengan santuy', 21, '2023-11-14', '0000-00-00'),
(57, 'Merdeka pagi', 21, '2023-11-14', '0000-00-00');

-- --------------------------------------------------------

--
-- Struktur dari tabel `report_apk`
--

CREATE TABLE IF NOT EXISTS `report_apk` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `desc` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `role`
--

CREATE TABLE IF NOT EXISTS `role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role` varchar(128) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data untuk tabel `role`
--

INSERT INTO `role` (`id`, `role`) VALUES
(1, 'admin'),
(2, 'member');

-- --------------------------------------------------------

--
-- Struktur dari tabel `user`
--

CREATE TABLE IF NOT EXISTS `user` (
  `iduser` int(11) NOT NULL AUTO_INCREMENT,
  `nama` varchar(128) NOT NULL,
  `profesi` varchar(50) NOT NULL,
  `email` varchar(128) NOT NULL,
  `password` varchar(256) NOT NULL,
  `role_id` int(11) NOT NULL,
  `is_active` int(1) NOT NULL,
  `tanggal_input` date NOT NULL,
  `modified` date NOT NULL,
  PRIMARY KEY (`iduser`),
  KEY `id` (`iduser`,`nama`,`email`,`password`,`role_id`,`is_active`,`tanggal_input`),
  KEY `role_id` (`role_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=28 ;

--
-- Dumping data untuk tabel `user`
--

INSERT INTO `user` (`iduser`, `nama`, `profesi`, `email`, `password`, `role_id`, `is_active`, `tanggal_input`, `modified`) VALUES
(1, 'sriyadi', 'dosen', 'sriyadi.sry@bsi.ac.id', '123', 2, 1, '2021-07-16', '2021-07-16'),
(2, 'affan', 'mahasiswa', 'affan@bsi.ac.id', '321', 2, 1, '2021-07-16', '2021-07-16'),
(3, 'Fauko Missalam', 'Mahasiswa', 'koko@id.id', '202cb962ac59075b964b07152d234b70', 2, 1, '2021-07-21', '0000-00-00'),
(4, 'joko', 'Siswa', 'joko@gmail.com', '827ccb0eea8a706c4c34a16891f84e7b', 2, 1, '2022-11-04', '0000-00-00'),
(5, 'ali', 'siswa', 'ali@gmail.com', '827ccb0eea8a706c4c34a16891f84e7b', 2, 1, '2022-11-06', '0000-00-00'),
(6, 'nama', 'nama', 'nama', '827ccb0eea8a706c4c34a16891f84e7b', 2, 1, '2022-11-06', '0000-00-00'),
(7, 'aku', 'aku', 'aku', '89ccfac87d8d06db06bf3211cb2d69ed', 2, 1, '2022-11-06', '0000-00-00'),
(8, 'nama', 'nama', 'nama@gmail.com', '827ccb0eea8a706c4c34a16891f84e7b', 2, 1, '2022-11-09', '0000-00-00'),
(9, 'abang', 'abang', 'abang@gmail.com', '827ccb0eea8a706c4c34a16891f84e7b', 2, 1, '2022-11-09', '0000-00-00'),
(10, 'itu', 'itu', 'itu@gmail.com', '827ccb0eea8a706c4c34a16891f84e7b', 2, 1, '2022-11-09', '0000-00-00'),
(11, 'ini', 'ini', 'ini@gmail.com', '827ccb0eea8a706c4c34a16891f84e7b', 2, 1, '2022-11-09', '0000-00-00'),
(12, 'tiara ', 'mahasiswa', 'tiaradwirahmadhani28@gmail.com', '827ccb0eea8a706c4c34a16891f84e7b', 2, 1, '2022-11-10', '0000-00-00'),
(13, 'apa', 'apa', 'apa@gmail.com', '827ccb0eea8a706c4c34a16891f84e7b', 2, 1, '2022-11-12', '0000-00-00'),
(14, 'jkw', 'presiden', 'jkw@mail', '827ccb0eea8a706c4c34a16891f84e7b', 2, 1, '2022-12-17', '0000-00-00'),
(15, 'sriyadi', 'pemain bola', 'sriyadi@', '81dc9bdb52d04dc20036dbd8313ed055', 2, 1, '2023-05-31', '0000-00-00'),
(16, 'mira', 'guru', 'mira', '202cb962ac59075b964b07152d234b70', 2, 1, '2023-06-01', '0000-00-00'),
(17, 'aghna', 'siswa', 'aghna@gmail.com', '202cb962ac59075b964b07152d234b70', 2, 1, '2023-06-06', '0000-00-00'),
(18, 'Riswandi ', 'Dosen', 'riswandi@gmail.com', '827ccb0eea8a706c4c34a16891f84e7b', 2, 1, '2023-10-15', '0000-00-00'),
(19, 'prabowo', 'caleg', 'prabowo@gmail', '827ccb0eea8a706c4c34a16891f84e7b', 2, 1, '2023-10-15', '0000-00-00'),
(20, 'gama', 'politikus', 'gama@', '827ccb0eea8a706c4c34a16891f84e7b', 2, 1, '2023-10-28', '0000-00-00'),
(21, 'sry', 'dosen', 'sry@', '827ccb0eea8a706c4c34a16891f84e7b', 2, 1, '2023-10-28', '0000-00-00'),
(25, 'gopan', 'pelajar', 'gopan@', '81dc9bdb52d04dc20036dbd8313ed055', 2, 1, '2023-10-28', '0000-00-00'),
(26, 'gosa', 'mhs', 'gosa@', '827ccb0eea8a706c4c34a16891f84e7b', 2, 1, '2023-10-28', '0000-00-00'),
(27, 'surati', 'guru', 'surati@', '827ccb0eea8a706c4c34a16891f84e7b', 2, 1, '2023-11-14', '0000-00-00');

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `motivasi`
--
ALTER TABLE `motivasi`
  ADD CONSTRAINT `motivasi_ibfk_1` FOREIGN KEY (`iduser`) REFERENCES `user` (`iduser`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
