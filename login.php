<?php
include "koneksi.php";
header("Access-Control-Allow-Origin: *");

$email = $_POST['email'];
$nobp = $_POST['nobp'];

$query = "SELECT * FROM tb_user WHERE email = '$email' AND nobp = '$nobp'";
$result = mysqli_query($koneksi, $query);

if ($result) {
    $row_count = mysqli_num_rows($result);

    if ($row_count > 0) {
        $response = array(
            'status' => 'success',
            'message' => 'Login berhasil',
            'data' => mysqli_fetch_assoc($result)

        );
    } else {
        $response = array(
            'status' => 'failed',
            'message' => 'Email atau NOBP salah'
        );
    }
} else {
    $response = array(
        'status' => 'failed',
        'message' => 'Terjadi kesalahan saat melakukan query'
    );
}

header('Content-Type: application/json');
echo json_encode($response);

mysqli_close($koneksi);
