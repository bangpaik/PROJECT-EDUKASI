<?php
include 'koneksi.php';

header("Access-Control-Allow-Origin: header");
header("Access-Control-Allow-Origin: *");

$nama    = $_POST['nama'];
$nobp    = $_POST['nobp'];
$nohp    = $_POST['nohp'];
$email   = $_POST['email'];

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

header('Content-Type: application/json');
echo json_encode($response);

mysqli_close($koneksi);
