<?php

include 'koneksi.php';

// Mengecek apakah request menggunakan metode POST
if ($_SERVER['REQUEST_METHOD'] === 'POST') {

    // Mengecek apakah body request berisi data
    $data = json_decode(file_get_contents("php://input"), true);

    // Mengecek apakah data yang diterima sesuai dengan yang diharapkan
    if (isset($data['nama']) && isset($data['nobp']) && isset($data['nohp']) && isset($data['email'])) {

        // Mengambil data dari request
        $nama = $data['nama'];
        $nobp = $data['nobp'];
        $nohp = $data['nohp'];
        $email = $data['email'];

        // Menyimpan data ke dalam database
        $sql = "INSERT INTO tb_user (nama, nobp, nohp, email) VALUES ('$nama', '$nobp', '$nohp', '$email')";

        if ($conn->query($sql) === TRUE) {
            $response = array(
                'status' => 'success',
                'message' => 'Pendaftaran berhasil',
                'data' => $data // Data yang berhasil didaftarkan
            );
        } else {
            $response = array(
                'status' => 'error',
                'message' => 'Gagal menyimpan data: '
                    . $conn->error
            );
        }
    } else {
        $response = array(
            'status' => 'error',
            'message' => 'Data tidak lengkap'
        );
    }
} else {
    $response = array(
        'status' => 'error',
        'message' => 'Metode request tidak diizinkan'
    );
}

// Mengubah respons menjadi format JSON
header('Content-Type: application/json');
echo json_encode($response);
