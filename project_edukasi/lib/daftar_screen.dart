import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'login_screen.dart';

class DaftarScreen extends StatelessWidget {
  final TextEditingController namaController = TextEditingController();
  final TextEditingController nobpController = TextEditingController();
  final TextEditingController nohpController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  Future<void> _daftar(BuildContext context) async {
    // Validasi input data
    if (namaController.text.isEmpty ||
        nobpController.text.isEmpty ||
        nohpController.text.isEmpty ||
        emailController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Semua field harus diisi.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      return; // Hentikan proses jika ada field yang kosong
    }

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
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['status'] == 'success') {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Pendaftaran Berhasil'),
            content: Text('Anda sudah terdaftar'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
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
        child: SingleChildScrollView(
          child: Card(
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    width: 350,
                  ),
                  TextField(
                    controller: namaController,
                    decoration: InputDecoration(
                      labelText: 'Nama',
                      prefixIcon: Icon(Icons.person),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: nobpController,
                    decoration: InputDecoration(
                      labelText: 'Nomor BP',
                      prefixIcon: Icon(Icons.confirmation_number),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: nohpController,
                    decoration: InputDecoration(
                      labelText: 'Nomor HP',
                      prefixIcon: Icon(Icons.phone),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email),
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
          ),
        ),
      ),
    );
  }
}
