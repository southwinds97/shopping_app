import 'package:flutter/material.dart';
import 'package:shopping_app/auth/auth.dart';
import 'package:shopping_app/auth/main_auth.dart';
import 'package:shopping_app/constants/colors.dart';
import 'package:shopping_app/constants/navigation.dart';
import 'package:shopping_app/screens/home.dart';
import 'package:shopping_app/screens/login_page.dart';
import 'package:shopping_app/screens/signup.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Navi(),
    );
  }
}
