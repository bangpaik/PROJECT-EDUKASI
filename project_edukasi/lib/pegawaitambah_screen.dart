// pegawaitambah_screen.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PegawaiTambahScreen extends StatefulWidget {
  final VoidCallback refreshCallback;

  const PegawaiTambahScreen({required this.refreshCallback});

  @override
  _PegawaiTambahScreenState createState() => _PegawaiTambahScreenState();
}

class _PegawaiTambahScreenState extends State<PegawaiTambahScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _noHpController = TextEditingController();
  final TextEditingController _noBpController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  Future<void> tambahPegawai() async {
    final response = await http.post(
      Uri.parse('https://tim5.trigofi.id/daftar.php'),
      body: {
        'nama': _namaController.text,
        'nohp': _noHpController.text,
        'nobp': _noBpController.text,
        'email': _emailController.text,
      },
    );

    if (response.statusCode == 200) {
      // Jika berhasil menambahkan, kembali ke halaman sebelumnya
      widget.refreshCallback(); // Panggil callback untuk perbarui data
      Navigator.pop(context);
    } else {
      // Jika gagal menambahkan, tampilkan pesan kesalahan
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Gagal menambahkan pegawai. Silakan coba lagi.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Pegawai'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _namaController,
                  decoration: InputDecoration(labelText: 'Nama'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nama tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _noHpController,
                  decoration: InputDecoration(labelText: 'No HP'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'No HP tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _noBpController,
                  decoration: InputDecoration(labelText: 'No BP'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'No BP tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      tambahPegawai();
                    }
                  },
                  child: Text('Tambah Pegawai'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
