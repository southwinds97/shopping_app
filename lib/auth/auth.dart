import 'package:flutter/material.dart';
import 'package:shopping_app/screens/login_page.dart';
import 'package:shopping_app/screens/signup.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool a = true;
  void go() {
    setState(() {
      a = !a;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (a) {
      return LoginPage(show: go);
    } else {
      return Signup(show: go);
    }
  }
}
 