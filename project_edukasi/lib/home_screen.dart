import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'login_screen.dart'; // Import halaman login_screen.dart
import 'package:shared_preferences/shared_preferences.dart'; // Import shared_preferences

class Berita {
  final String judul;
  final String konten;
  final String gambar;

  Berita({
    required this.judul,
    required this.konten,
    required this.gambar,
  });

  factory Berita.fromJson(Map<String, dynamic> json) {
    return Berita(
      judul: json['judul'],
      konten: json['konten'],
      gambar: json['gambar'],
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Berita> beritaList;
  late List<Berita> filteredBeritaList; // Tambahkan filteredBeritaList
  bool isLoading = false;
  String? namaUser;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchData();
    getUsername();
    filteredBeritaList = []; // Inisialisasi filteredBeritaList
  }

  Future<void> getUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      namaUser = prefs.getString('email');
    });
  }

  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.get(Uri.parse('http://192.168.0.220/PROJECT-EDUKASI/get_berita.php'));

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body)['data'];
        setState(() {
          beritaList = responseData.map((item) => Berita.fromJson(item)).toList();
          filteredBeritaList = beritaList; // Isi filteredBeritaList dengan beritaList awal
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

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  void searchBerita(String query) {
    // Lakukan pencarian berita sesuai dengan nilai yang dimasukkan
    setState(() {
      filteredBeritaList = beritaList.where((berita) {
        return berita.judul.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'PROJECT EDUKASI TIM 5',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
        actions: [
          if (namaUser != null)
            Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: Text(
                'Halo, $namaUser!',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(8),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Cari berita...',
              ),
              onChanged: (value) {
                searchBerita(value); // Panggil fungsi pencarian saat teks berubah
              },
            ),
          ),
          Expanded(
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : filteredBeritaList.isEmpty
                ? Center(child: Text('Tidak ada data'))
                : ListView.builder(
              itemCount: filteredBeritaList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(filteredBeritaList[index].judul),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${filteredBeritaList[index].konten.substring(0, 50)}...',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 8),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailScreen(berita: filteredBeritaList[index]),
                            ),
                          );
                        },
                        child: Text(
                          'Selengkapnya',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.blue),
                        ),
                      ),
                    ],
                  ),
                  leading: CircleAvatar(
                    backgroundColor: Colors.black,
                    backgroundImage: NetworkImage(
                      'http://192.168.147.42/PROJECT-EDUKASI/gambar/${filteredBeritaList[index].gambar}',
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.blue,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton.extended(
                onPressed: logout,
                icon: Icon(Icons.logout),
                label: Text(
                  'Logout',
                  style: TextStyle(color: Colors.black),
                ),
                backgroundColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  final Berita berita;

  DetailScreen({required this.berita});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(berita.judul),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                berita.konten,
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 20),
              // Tambahkan informasi lain yang diperlukan di sini
            ],
          ),
        ),
      ),
    );
  }
}
