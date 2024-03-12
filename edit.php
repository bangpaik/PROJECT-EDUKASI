<?php
include 'koneksi.php';

header("Access-Control-Allow-Origin: header");
header("Access-Control-Allow-Origin: *");

$id_user = $_POST['id_user'];
$nama    = $_POST['nama'];
$nobp    = $_POST['nobp'];
$nohp    = $_POST['nohp'];
$email   = $_POST['email'];

$query = "UPDATE tb_user SET nama='$nama', nobp='$nobp', nohp='$nohp', email='$email' WHERE id_user='$id_user'";
$result = mysqli_query($koneksi, $query);

if ($result) {
    $response = array(
        'status' => 'success',
        'message' => 'Data berhasil diupdate'
    );
} else {
    $response = array(
        'status' => 'failed',
        'message' => 'Gagal mengupdate data'
    );
}

header('Content-Type: application/json');
echo json_encode($response);

mysqli_close($koneksi);
