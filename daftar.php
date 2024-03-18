<?php
include 'koneksi.php';

header("Access-Control-Allow-Origin: *");

$nama    = $_POST['nama'];
$nobp    = $_POST['nobp'];
$nohp    = $_POST['nohp'];
$email   = $_POST['email'];

$queryCheck = "SELECT * FROM tb_user WHERE email='$email' OR nobp='$nobp'";
$resultCheck = mysqli_query($koneksi, $queryCheck);

if (mysqli_num_rows($resultCheck) > 0) {
    $response = array(
        'status' => 'failed',
        'message' => 'Email atau nomor BP sudah terdaftar'
    );
} else {
    $query = "INSERT INTO tb_user SET nama='$nama', nobp='$nobp', nohp='$nohp', email='$email'";
    $result = mysqli_query($koneksi, $query);

    if ($result) {
        $response = array(
            'status' => 'success',
            'message' => 'Data berhasil ditambahkan'
        );
    } else {
        $response = array(
            'status' => 'failed',
            'message' => 'Gagal insert data'
        );
    }
}

header('Content-Type: application/json');
echo json_encode($response);

mysqli_close($koneksi);
