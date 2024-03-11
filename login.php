<?php
include "koneksi.php";

// Set header untuk mengizinkan akses dari domain yang berbeda
// header("Access-Control-Allow-Origin: http://localhost:10461");
header("Access-Control-Allow-Origin: header");
header("Access-Control-Allow-Origin: *");

// Ambil data yang dikirimkan dari aplikasi Flutter
$email = $_POST['email'];
$nobp = $_POST['nobp'];

// Query untuk mencari data pengguna dengan email dan NOBP yang diberikan
$query = "SELECT * FROM tb_user WHERE email = '$email' AND nobp = '$nobp'";
$result = mysqli_query($koneksi, $query);

// Cek apakah query berhasil dieksekusi
if ($result) {
    // Ambil jumlah baris yang ditemukan
    $row_count = mysqli_num_rows($result);

    // Jika ada pengguna dengan email dan NOBP yang sesuai, beri respon berhasil
    if ($row_count > 0) {
        $response = array(
            'status' => 'success',
            'message' => 'Login berhasil'
        );
    } else {
        // Jika tidak ada pengguna dengan email dan NOBP yang sesuai, beri respon gagal
        $response = array(
            'status' => 'failed',
            'message' => 'Email atau NOBP salah'
        );
    }
} else {
    // Jika query gagal dieksekusi, beri respon gagal
    $response = array(
        'status' => 'failed',
        'message' => 'Terjadi kesalahan saat melakukan query'
    );
}

// Ubah respon ke format JSON dan kirimkan ke aplikasi Flutter
header('Content-Type: application/json');
echo json_encode($response);

// Tutup koneksi database
mysqli_close($koneksi);
