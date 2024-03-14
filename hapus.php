<?php
include 'koneksi.php';

header("Access-Control-Allow-Origin: header");
header("Access-Control-Allow-Origin: *");

$id = $_POST['id'];
$nama    = $_POST['nama'];
$nobp    = $_POST['nobp'];
$nohp    = $_POST['nohp'];
$email   = $_POST['email'];

$query = "DELETE FROM tb_user WHERE id_user='$id'";
$result = mysqli_query($koneksi, $query);

if ($result) {
    $response = array(
        'status' => 'success',
        'message' => 'Data berhasil dihapus'
    );
} else {
    $response = array(
        'status' => 'failed',
        'message' => 'Gagal hapus data'
    );
}

header('Content-Type: application/json');
echo json_encode($response);

mysqli_close($koneksi);
