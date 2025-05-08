import 'package:flutter/material.dart';
import 'start_page.dart'; // ← 现在是 start_page.dart

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shoe Store',
      debugShowCheckedModeBanner: false,
      home: StartPage(),
    );
  }
}
