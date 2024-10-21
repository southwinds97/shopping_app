import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shopping_app/constants/navigation.dart';

FirebaseOptions get firebaseOptions => const FirebaseOptions(
      apiKey: "AIzaSyBVHCjU4E567K2B-l18fkXsJKPaPJhPCPQ",
      authDomain: "reactapp202408.firebaseapp.com",
      projectId: "reactapp202408",
      storageBucket: "reactapp202408.appspot.com",
      messagingSenderId: "163680544048",
      appId: "1:163680544048:android:d8b088eb6aea0182a7d4f5",
      databaseURL:
          "https://reactapp202408-default-rtdb.asia-southeast1.firebasedatabase.app",
    );

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: firebaseOptions,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Navi(),
    );
  }
}
