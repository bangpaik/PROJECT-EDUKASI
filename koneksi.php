<?php
$koneksi = mysqli_connect("localhost", "root", "", "project_edukasi");
if ($koneksi) {
    // echo "Berhasil konek ke database";
} else {
    echo "Gagal koneksi";
}
