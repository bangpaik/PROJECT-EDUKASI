import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController namaController = TextEditingController();
  TextEditingController nobpController = TextEditingController();
  TextEditingController nohpController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  late String? id_user;

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      namaController.text = prefs.getString('nama') ?? '';
      nobpController.text = prefs.getString('nobp') ?? '';
      nohpController.text = prefs.getString('nohp') ?? '';
      emailController.text = prefs.getString('email') ?? '';
      id_user = prefs.getString('id_user');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(
                    'https://cdn.pixabay.com/photo/2016/03/31/19/56/avatar-1295399_640.png',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            TextField(
              controller: namaController,
              decoration: InputDecoration(labelText: 'Nama'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: nobpController,
              decoration: InputDecoration(labelText: 'No BP'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: nohpController,
              decoration: InputDecoration(labelText: 'No HP'),
            ),
            SizedBox(height: 32.0),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 16.0),
            Text(
              'ID User: $id_user',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                _editProfile();
              },
              child: Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _editProfile() async {
    final nama = namaController.text;
    final nobp = nobpController.text;
    final nohp = nohpController.text;
    final email = emailController.text;

    // Validasi jika data kosong
    if (nama.isEmpty || nobp.isEmpty || nohp.isEmpty || email.isEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Peringatan'),
            content: Text('Semua data harus diisi.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      return; // Stop the execution flow
    }

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      id_user = prefs.getString('id_user');

      final response = await http.post(
        Uri.parse('https://tim5.trigofi.id/edit.php'),
        body: {
          'id_user': id_user,
          'nama': nama,
          'nobp': nobp,
          'nohp': nohp,
          'email': email,
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['status'] == 'success') {
          // Data berhasil diupdate
          // Simpan data terbaru ke SharedPreferences
          prefs.setString('nama', nama);
          prefs.setString('nobp', nobp);
          prefs.setString('nohp', nohp);
          prefs.setString('email', email);

          Navigator.pop(context, true);

          // Tampilkan alert bahwa data berhasil diubah
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Berhasil'),
                content: Text('Data berhasil diupdate.'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        } else {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Gagal'),
                content: Text('Gagal mengupdate data.'),
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
        throw Exception(
            'Gagal mengupdate data. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Terjadi kesalahan saat mengedit profile.'),
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
}