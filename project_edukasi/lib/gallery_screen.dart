import 'package:flutter/material.dart';
import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(GalleryApp());
}

class GalleryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Gallery',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GalleryScreen(),
    );
  }
}

class GalleryScreen extends StatefulWidget {
  @override
  _GalleryScreenState createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  List<String> imageUrls = [];

  bool _isConnected = false;

  @override
  void initState() {
    super.initState();
    _checkInternetConnection();
    _fetchImageData();
  }

  Future<void> _checkInternetConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      setState(() {
        _isConnected = true;
      });
    } else {
      setState(() {
        _isConnected = false;
      });
    }
  }

  Future<void> _fetchImageData() async {
    try {
      final response = await http.get(Uri.parse('https://tim5.trigofi.id/get_gambar.php'));
      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body)['data'];
        List<String> urls = responseData.map((item) => 'https://tim5.trigofi.id/gambar/${item['gambar']}').toList();
        setState(() {
          imageUrls = urls;
        });
      } else {
        throw Exception('Failed to load image data. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to load image data.'),
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
        title: Text('Gallery'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 4.0,
          mainAxisSpacing: 4.0,
        ),
        itemCount: imageUrls.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              // Handle image tap event
            },
            child: Card(
              elevation: 2.0,
              child: _isConnected
                  ? Image.network(
                imageUrls[index],
                fit: BoxFit.cover,
              )
                  : Center(
                child: Text('No internet connection'),
              ),
            ),
          );
        },
      ),
    );
  }
}
