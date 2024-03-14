import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PegawaiEditScreen extends StatefulWidget {
  final String pegawaiId;

  const PegawaiEditScreen({Key? key, required this.pegawaiId}) : super(key: key);

  @override
  _PegawaiEditScreenState createState() => _PegawaiEditScreenState();
}

class _PegawaiEditScreenState extends State<PegawaiEditScreen> {
  TextEditingController namaController = TextEditingController();
  TextEditingController nobpController = TextEditingController();
  TextEditingController nohpController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.get(Uri.parse('https://tim5.trigofi.id/get_pegawai_by_id.php?id=${widget.pegawaiId}'));

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        setState(() {
          namaController.text = responseData['nama'] ?? '';
          nobpController.text = responseData['nobp'] ?? '';
          nohpController.text = responseData['nohp'] ?? '';
          emailController.text = responseData['email'] ?? '';
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load data. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to load data.'),
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

  void simpanPerubahan() async {
    try {
      setState(() {
        isLoading = true;
      });

      final response = await http.post(
        Uri.parse('https://tim5.trigofi.id/edit.php'),
        body: {
          'id_user': widget.pegawaiId,
          'nama': namaController.text,
          'nobp': nobpController.text,
          'nohp': nohpController.text,
          'email': emailController.text,
        },
      );

      if (response.statusCode == 200) {
        // Jika berhasil, arahkan kembali ke layar PegawaiScreen
        Navigator.pop(context, true); // Kembali ke PegawaiScreen dengan status true
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Sukses'),
              content: Text('Data berhasil diperbarui.'),
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
        throw Exception('Failed to update data. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to update data.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Pegawai'),
        backgroundColor: Colors.blue,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16.0),
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
            SizedBox(height: 16),
            TextField(
              controller: nobpController,
              decoration: InputDecoration(labelText: 'No BP'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: nohpController,
              decoration: InputDecoration(labelText: 'No HP'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: simpanPerubahan,
              child: Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}
