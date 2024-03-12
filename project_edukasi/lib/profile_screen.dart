// profile_screen.dart
import 'package:flutter/material.dart';
import 'edit_profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late String _nama;
  late String _nobp;
  late String _nohp;
  late String _email;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _nama = prefs.getString('nama') ?? '';
      _nobp = prefs.getString('nobp') ?? '';
      _nohp = prefs.getString('nohp') ?? '';
      _email = prefs.getString('email') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.blue,
      ),
      body: Align(
        alignment: Alignment.topCenter,
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
            SizedBox(height: 16),
            Text(
              _nama, // Tampilkan nama pengguna
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'No BP : $_nobp',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'No HP : $_nohp',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'Email : $_email',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditProfileScreen()),
                ).then((value) {

                  if (value != null && value) {
                    _loadProfile();
                  }
                });
              },
              child: Text('Edit Profile'),
            ),
          ],
        ),
      ),
    );
  }
}
