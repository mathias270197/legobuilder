import 'package:flutter/material.dart';
import 'pages/navigation.dart';
import './pages/login.dart';

void main() => runApp(const HelloFlutterApp());

class HelloFlutterApp extends StatelessWidget {
  const HelloFlutterApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hello Flutter App',
      home: MyCustomForm(),
    );
  }
}