import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'login_screen.dart'; // Import dart:convert untuk menggunakan json.decode

class DaftarScreen extends StatelessWidget {
  final TextEditingController namaController = TextEditingController();
  final TextEditingController nobpController = TextEditingController();
  final TextEditingController nohpController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  Future<void> _daftar(BuildContext context) async {
    final String url = 'https://tim5.trigofi.id/daftar.php';

    final response = await http.post(
      Uri.parse(url),
      body: {
        'nama': namaController.text,
        'nobp': nobpController.text,
        'nohp': nohpController.text,
        'email': emailController.text,
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body); // Gunakan json.decode untuk mengurai respons
      if (responseData['status'] == 'success') {
        // Pendaftaran berhasil
        // Tampilkan dialog bahwa pengguna sudah terdaftar
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Pendaftaran Berhasil'),
            content: Text('Anda sudah terdaftar'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Tutup dialog
                  // Navigasi ke halaman login_screen
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      } else {
        // Pendaftaran gagal, tampilkan pesan kesalahan
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Pendaftaran Gagal'),
              content: Text(responseData['message']),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } else {
      // Jika terjadi kesalahan dalam komunikasi dengan server, tampilkan pesan error
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Terjadi kesalahan saat mendaftar.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: namaController,
              decoration: InputDecoration(
                labelText: 'Nama',
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: nobpController,
              decoration: InputDecoration(
                labelText: 'Nomor BP',
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: nohpController,
              decoration: InputDecoration(
                labelText: 'Nomor HP',
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _daftar(context),
              child: Text('Daftar'),
            ),
          ],
        ),
      ),
    );
  }
}
