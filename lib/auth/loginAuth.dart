import 'package:flutter/material.dart';
import 'package:shopping_app/screens/loginPage.dart';
import 'package:shopping_app/screens/signup.dart';

class LoginAuth extends StatefulWidget {
  const LoginAuth({super.key});

  @override
  State<LoginAuth> createState() => _LoginAuthState();
}

class _LoginAuthState extends State<LoginAuth> {
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
