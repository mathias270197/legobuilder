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
        title: const Text("Lego's"),
      ),
      body: const Center(
          child: ArMultipleTargetsWidget()),
    );
  }
}