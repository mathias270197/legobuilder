import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: const Material(
        color: Colors.blue,
        child: Center(
          child: Text(
            "Welcome to the lego builder",
            textDirection: TextDirection.ltr,
            style: TextStyle(color: Colors.white, fontSize: 36.0),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}