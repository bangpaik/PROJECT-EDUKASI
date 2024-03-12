<?php
include "koneksi.php";

header("Access-Control-Allow-Origin: *"); // Mengizinkan akses dari semua domain

// Mendapatkan ID Pegawai dari request
$id_user = $_GET['id'];

// Membuat query untuk mendapatkan data pegawai berdasarkan ID
$sql = "SELECT * FROM tb_user WHERE id_user = '$id_user'";

$result = $koneksi->query($sql);

// Memeriksa apakah hasil query menghasilkan data
if ($result->num_rows > 0) {
    // Mengonversi hasil query menjadi array asosiatif
    $row = $result->fetch_assoc();

    // Mengembalikan data dalam format JSON
    echo json_encode($row);
} else {
    // Jika data tidak ditemukan, kembalikan respons kosong
    echo "{}";
}

// Menutup koneksi database
$koneksi->close();
?>
