import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_app/auth/auth.dart';
import 'package:shopping_app/screens/profil.dart';

class MainAuth extends StatefulWidget {
  const MainAuth({super.key});

  @override
  _MainAuthState createState() => _MainAuthState();
}

class _MainAuthState extends State<MainAuth> {
  Future<bool> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  void showLoginPage() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: checkLoginStatus(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text('Error: ${snapshot.error}')),
          );
        } else if (snapshot.hasData && snapshot.data == true) {
          return const ProFil();
        } else {
          return const AuthPage();
        }
      },
    );
  }
}
