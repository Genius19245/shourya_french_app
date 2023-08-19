import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'category_selection_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyBa6dBOwt9DCWwi9hf2NHCdx6xGg7y8nX4",
        authDomain: "shourya-s-french-app.firebaseapp.com",
        projectId: "shourya-s-french-app",
        storageBucket: "shourya-s-french-app.appspot.com",
        messagingSenderId: "58933452989",
        appId: "1:58933452989:web:75268fc7cfd6e7d08517d4",
        measurementId: "G-GQNLF04P58"),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        colorSchemeSeed: const Color.fromARGB(255, 43, 75, 253),
        useMaterial3: true,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        colorSchemeSeed: Color.fromARGB(255, 32, 149, 245),
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      home: const CategorySelectionPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
