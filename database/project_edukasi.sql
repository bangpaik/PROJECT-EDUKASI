-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 11, 2024 at 10:44 AM
-- Server version: 10.4.25-MariaDB
-- PHP Version: 7.4.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `project_edukasi`
--

-- --------------------------------------------------------

--
-- Table structure for table `tb_berita`
--

CREATE TABLE `tb_berita` (
  `id_berita` int(11) NOT NULL,
  `judul` varchar(255) NOT NULL,
  `konten` text NOT NULL,
  `gambar` varchar(255) NOT NULL,
  `created` datetime NOT NULL DEFAULT current_timestamp(),
  `updated` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tb_berita`
--

INSERT INTO `tb_berita` (`id_berita`, `judul`, `konten`, `gambar`, `created`, `updated`) VALUES
(1, '50 Tokoh Antikorupsi Surati Partai-partai Desak Hak Angket Pemilu', 'Jakarta, CNN Indonesia -- Sebanyak 50 aktivis antikorupsi hingga mantan pegawai Komisi Pemberantas Korupsi (KPK) mengirim surat kepada sejumlah ketua umum partai politik untuk mendorong pengajuan Hak Angket dugaan kecurangan Pemilu 2024.\r\nSurat yang diterbitkan pada Jumat (8/3) itu ditujukan kepada Ketua Umum PDIP Megawati Soekarno Putri, Ketua Umum Partai Nasdem Surya Paloh, Ketua Umum PKB Muhaimin Iskandar, Presiden PKS Ahmad Syaikhu, dan Ketua Umum PPP Muhammad Mardiono.\r\n\r\nDalam surat itu, Tokoh Masyarakat mengatakan terjadi praktik kecurangan dalam Pemilu 2024.\r\n\r\n\"Di dalam pemantauan kami, dugaan kecurangan penyelenggaraan pemilu yang dipersoalkan oleh masyarakat, terjadi bukan hanya pada saat hari pencoblosan 14 Februari 2024, tetapi juga sejak awal proses penyelenggaraan pemilu hingga pasca pelaksanaan proses penghitungan suara yang dilakukan oleh Komisi Pemilihan Umum (KPU) dan aparatur kekuasaan lainnya,\" demikian bunyi surat itu.\r\n\r\nKecurangan itu disebut tidak hanya menyakiti hati nurani rakyat tetapi juga menimbulkan keresahan. Hal itu terlihat dari ada banyaknya diskursus di kalangan masyarakat maupun di media sosial serta meluasnya pernyataan sikap dari guru besar dan dosen-dosen perguruan tinggi.\r\n\r\nJika kecurangan dibiarkan, sambung surat tersebut, maka penegakan hukum akan dihinakan dan demokrasi terjungkal.\r\n\r\n\"Sementara itu, pelaku kecurangan pemilu terus bersimaharajalela dan menjadi kian bengis, tak lagi sekedar menghidupkan preseden busuk dan bejat di dalam suatu proses pemilu,\" bunyi surat tersebut.\r\n\r\nSebagai akibatnya, masyarakat tidak akan patuh pada pimpinan kekuasaan dan berbagai kebijakan negara yang dihasilkannya. Karena itu, partai politik diharapkan menggerakan fraksi-fraksi anggota DPR untuk mengajukan dan melakukan Hak Angket.\r\n\r\n\"Kami sangat meyakini dan mempunyai harapan yang sangat besar,\r\n\r\npara partai politik akan menyelamatkan bangsa ini sehingga dengan sengaja terlibat intensif untuk menjaga hukum, penegakan hukum dan demokrasi serta demokratisisi di Indonesia dengan menyelamatkan Pemilu 2024,\" bunyi surat itu.\r\n\r\nTokoh Masyarakat sendiri terdiri sejumlah aktivis, akademisi, hingga eks pegawai KPK, seperti Novel Baswedan, Bivitri Susanti, Usman Hamid, Faisal Basri, dan Fatia Maulidiyanti, kemudian Saut Situmorang, Agus Sunaryanto, dan Haris Azhar.\r\n\r\nSejumlah partai politik sebelumnya telah merespons usulan hak angket di parlemen.\r\n\r\nPartai NasDem mengatakan siap mendukung usulan tersebut dan tengah menyiapkan berbagai persyaratan.\r\n\r\n\"Saat ini pimpinan fraksi tengah mempersiapkan bahan-bahan yang diperlukan sebagai syarat pengajuan hak angket termasuk mengumpulkan tanda tangan para anggota fraksi,\" kata Ketua DPP Partai NasDem Taufik Basari, Rabu (6/3).\r\n\r\nTaufik mengatakan pengajuan hak angket ini tak bisa dilakukan sendirian, tapi mesti melibatkan paling sedikit dua fraksi. Karena itu, kata dia, setiap langkah politik yang diambil harus terukur.\r\n\r\nDukungan juga disampaikan anggota DPR dari Fraksi PKB, Luluk Nur Hamidah. Ia menilai Pemilu 2024 merupakan pemilu paling brutal yang pernah ia ikuti sejak reformasi.\r\n\r\n\"Sepanjang pemilu yang saya ikuti semenjak pemilu \'99 saya belum pernah melihat ada proses pemilu yang sebrutal dan semenyakitkan ini, di mana etika dan moral politik berada di titik minus, kalau tidak bisa dikatakan di titik nol,\" kata Luluk saat menyampaikan interupsi di rapat paripurna DPR di kompleks parlemen, Senayan, Selasa (5/3).\r\n\r\nSementara, Sekretaris Jendral PDI-Perjuangan Hasto Kristiyanto mengklaim internal PDIP tak terbelah soal rencana pengajuan hak angket kecurangan Pemilu 2024 di DPR.\r\n\r\n\"Tak ada [terbelah]. Karena kita sering bicara sebagai suatu proses politik yang penting di DPR,\" kata dia, di FISIP UI, Depok, Jawa Barat, Kamis (7/3)\r\n\r\nHasto mengungkapkan rencana hak angket ini sudah masuk ke tahapan pembentukan tim khusus. Tim ini, lanjutnya, sudah mengeluarkan rekomendasi dan kajian akademis terkait rencana hak angket.\r\n\r\nIa mengatakan nantinya kajian akademis itu akan disempurnakan dengan temuan-temuan di lapangan soal dugaan kecurangan pemilu.\r\n\r\n\"Karena dimensinya sangat luas. Karena dimensi penyalahgunaan kekuasaan penyalahgunaan APBN, intimidasi dan berbagai aspek hulu hilir,\" kata dia.\r\n\r\n(fby/rzr/arh)', 'pemilu.jpeg', '2024-03-11 06:20:15', NULL),
(2, 'Arab Saudi Tetapkan 1 Ramadan Jatuh pada Senin 11 Maret 2024', 'Jakarta - Arab Saudi menetapkan 1 Ramadan 1445 H jatuh pada hari Senin 11 Maret 2024. Penetapan 1 Ramadan di Arab Saudi setelah penampakan bulan di Hawtat Sudair.\r\nDilansir Arab News, Senin (11/3/2024), penampakan yang dilakukan para astronom dari Departemen Observatorium Astronomi Universitas Majmaah di Riyadh ini menandai dimulainya bulan suci bagi umat muslim.\r\n\r\nPeristiwa penting ini dipimpin oleh astronom terkemuka Saudi, Direktur Observatorium Astronomi, Abdullah Al-Khudairi, di Sudair. Mahkamah Agung Saudi mengumumkan bahwa Senin, 11 Maret, akan menjadi hari pertama Ramadan.\r\n\r\nSelain Arab Saudi, Qatar dan UEA juga telah mengonfirmasi bahwa Ramadan akan dimulai pada hari Senin 11 Maret. Sementara itu, Oman, Pakistan, Australia, Malaysia, Brunei, dan Iran pada 12 Maret.\r\n\r\nPenentuan tanggal mulai bergantung pada perhitungan bulan dan penampakan fisik bulan baru, sebuah praktik yang berakar pada tradisi Islam.\r\n\r\n\"Perhitungan dan teknologi melengkapi proses penampakan. Saya katakan bahwa perhitungan astronomi dan pengamatan dengan mata telanjang, seperti mata manusia, keduanya saling membutuhkan,\" kata Al-Khudairi.\r\n\r\nKe depan, Universitas Majmaah mengungkapkan rencana untuk meningkatkan fasilitasnya dan menambah timnya untuk lebih menyederhanakan proses penampakan bulan.\r\n\r\n\"Kami memiliki rencana strategis untuk memperluas fasilitas, peralatan, dan tenaga kerja kami di sini (Hawtat Sudair),\" kata Wakil Direktur Penelitian Pascasarjana dan Ilmiah di Universitas Majmaah.\r\n\r\n\"Kami ingin membangun gedung besar di sini. Ini akan menjadi pusat Majmaah untuk melihat bulan,\" imbuhnya.\r\n', 'arab.jpeg', '2024-03-11 07:07:58', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `tb_user`
--

CREATE TABLE `tb_user` (
  `id_user` int(11) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `nobp` varchar(14) NOT NULL,
  `nohp` varchar(16) NOT NULL,
  `email` varchar(100) NOT NULL,
  `created` datetime NOT NULL DEFAULT current_timestamp(),
  `updated` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tb_user`
--

INSERT INTO `tb_user` (`id_user`, `nama`, `nobp`, `nohp`, `email`, `created`, `updated`) VALUES
(1, 'MUHAMMAD FADLI', '2311089011', '081277785227', 'bangpaik1@gmail.com', '2024-03-11 08:16:43', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tb_berita`
--
ALTER TABLE `tb_berita`
  ADD PRIMARY KEY (`id_berita`);

--
-- Indexes for table `tb_user`
--
ALTER TABLE `tb_user`
  ADD PRIMARY KEY (`id_user`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tb_berita`
--
ALTER TABLE `tb_berita`
  MODIFY `id_berita` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tb_user`
--
ALTER TABLE `tb_user`
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
