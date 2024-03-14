import 'login_screen.dart';
import 'pegawaitambah_screen.dart';
import 'pegawaiedit_screen.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class PegawaiScreen extends StatefulWidget {
  @override
  _PegawaiScreenState createState() => _PegawaiScreenState();
}

class _PegawaiScreenState extends State<PegawaiScreen> {
  late List<Pegawai> pegawaiList;
  late List<Pegawai> filteredPegawaiList;
  bool isLoading = false;
  TextEditingController searchController = TextEditingController();
  late String? id_user;
  @override
  void initState() {
    super.initState();
    fetchData();
    filteredPegawaiList = [];
      }


  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.get(Uri.parse('https://tim5.trigofi.id/get_pegawai.php'));

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body)['data'];
        setState(() {
          pegawaiList = responseData.map((item) => Pegawai.fromJson(item)).toList();
          filteredPegawaiList = List.from(pegawaiList);
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load data. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
      setState(() {
        isLoading = false;
      });
    }
  }

  void searchPegawai(String query) {
    setState(() {
      filteredPegawaiList = pegawaiList.where((pegawai) {
        return pegawai.nama.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  void editPegawai(String id) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PegawaiEditScreen(pegawaiId: id),
      ),
    ).then((value) {
      if (value == true) {
        fetchData(); // Perbarui data jika berhasil menyimpan perubahan
      }
    });
  }

  Future<void> hapusPegawai(String id, String nama) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id_user = prefs.getString('id_user');

    if (id_user == id) {
      // Hapus data pengguna yang login dan lakukan logout
      try {
        final response = await http.post(
          Uri.parse('https://tim5.trigofi.id/hapus.php'),
          body: {'id': id},
        );

        if (response.statusCode == 200) {
          final responseData = json.decode(response.body);
          if (responseData['status'] == 'success') {
            await prefs.clear(); // Hapus data login dari SharedPreferences
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Informasi'),
                content: Text('Data Anda telah dihapus. Silahkan mendaftar kembali.'),
                actions: [
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
            return; // Stop the execution flow after successful logout
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Gagal menghapus data')),
            );
          }
        } else {
          throw Exception('Failed to delete data. Status code: ${response.statusCode}');
        }
      } catch (error) {
        print('Error: $error');
      }
    }

    // Hapus data pegawai jika tidak ada masalah dengan ID
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Konfirmasi'),
        content: Text('Apakah Anda yakin ingin menghapus data pegawai $nama?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Batal'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop(); // Tutup dialog
              try {
                final response = await http.post(
                  Uri.parse('https://tim5.trigofi.id/hapus.php'),
                  body: {'id': id},
                );

                if (response.statusCode == 200) {
                  final responseData = json.decode(response.body);
                  if (responseData['status'] == 'success') {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Data berhasil dihapus')),
                    );
                    fetchData(); // Reload data setelah penghapusan
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Gagal menghapus data')),
                    );
                  }
                } else {
                  throw Exception('Failed to delete data. Status code: ${response.statusCode}');
                }
              } catch (error) {
                print('Error: $error');
              }
            },
            child: Text('Ya'),
          ),
        ],
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Pegawai'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Cari pegawai...',
              ),
              onChanged: searchPegawai,
            ),
          ),
          Expanded(
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: [
                  DataColumn(label: Text('Nama')),
                  DataColumn(label: Text('No HP')),
                  DataColumn(label: Text('No BP')),
                  DataColumn(label: Text('Email')),
                  DataColumn(label: Text('Aksi')),
                ],
                rows: filteredPegawaiList
                    .map(
                      (pegawai) => DataRow(
                    cells: [
                      DataCell(Text(pegawai.nama)),
                      DataCell(Text(pegawai.noHp)),
                      DataCell(Text(pegawai.noBP)),
                      DataCell(Text(pegawai.email)),
                      DataCell(
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () => editPegawai(pegawai.id),
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () => hapusPegawai(pegawai.id, pegawai.nama),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
                    .toList(),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PegawaiTambahScreen(refreshCallback: fetchData)),
          );
        },
        child: Icon(Icons.person_add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}

class Pegawai {
  final String id;
  final String nama;
  final String noHp;
  final String noBP;
  final String email;

  Pegawai({
    required this.id,
    required this.nama,
    required this.noHp,
    required this.noBP,
    required this.email,
  });

  factory Pegawai.fromJson(Map<String, dynamic> json) {
    return Pegawai(
      id: json['id_user'],
      nama: json['nama'],
      noHp: json['nohp'],
      noBP: json['nobp'],
      email: json['email'],
    );
  }
}
