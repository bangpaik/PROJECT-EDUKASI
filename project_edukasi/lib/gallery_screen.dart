import 'package:flutter/material.dart';
import 'dart:io';
import 'package:connectivity/connectivity.dart';

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
  final List<String> imageUrls = [
    "https://setkab.go.id/wp-content/uploads/2021/03/Screen-Shot-2021-02-20-at-21.53.28.jpg",
    "https://setkab.go.id/wp-content/uploads/2021/03/Screen-Shot-2021-02-20-at-21.53.28.jpg",
    "https://setkab.go.id/wp-content/uploads/2021/03/Screen-Shot-2021-02-20-at-21.53.28.jpg",
    "https://setkab.go.id/wp-content/uploads/2021/03/Screen-Shot-2021-02-20-at-21.53.28.jpg",
    "https://setkab.go.id/wp-content/uploads/2021/03/Screen-Shot-2021-02-20-at-21.53.28.jpg",
    "https://setkab.go.id/wp-content/uploads/2021/03/Screen-Shot-2021-02-20-at-21.53.28.jpg",
  ];

  bool _isConnected = false;

  @override
  void initState() {
    super.initState();
    _checkInternetConnection();
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
