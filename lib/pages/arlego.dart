import 'package:flutter/material.dart';
import '../widgets/armultipletargets.dart';

class ArLegoPage extends StatefulWidget {
  const ArLegoPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ArLegoStatePage();
}

class _ArLegoStatePage extends State<ArLegoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dino's"),
      ),
      body: const Center(
          // Here we load the Widget with the AR Dino experience
          child: ArMultipleTargetsWidget()),
    );
  }
}