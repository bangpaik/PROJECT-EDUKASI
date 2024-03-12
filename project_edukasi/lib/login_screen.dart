import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_screen.dart';
import 'daftar_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nobpController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: nobpController,
              decoration: InputDecoration(
                labelText: 'No BP',
              ),
            ),
            SizedBox(height: 32.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: isLoading ? null : () => _login(),
                  child: isLoading ? CircularProgressIndicator() : Text('Login'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DaftarScreen()),
                    );
                  },
                  child: Text('Daftar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _login() async {
    setState(() {
      isLoading = true;
    });

    final email = emailController.text;
    final nobp = nobpController.text;

    try {
      final response = await http.post(
        Uri.parse('https://tim5.trigofi.id/login.php'),
        body: {
          'email': email,
          'nobp': nobp,
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['status'] == 'success') {

          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('email', email);
          prefs.setString('nobp', nobp);
          prefs.setString('nama', responseData['data']['nama']);
          prefs.setString('nohp', responseData['data']['nohp']);
          prefs.setString('id_user', responseData['data']['id_user']);

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        } else {

          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Login Gagal'),
                content: Text('Email atau NOBP salah.'),
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
        throw Exception('Failed to login. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Terjadi kesalahan saat melakukan login.'),
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
}
