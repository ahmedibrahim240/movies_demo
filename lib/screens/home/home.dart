import 'package:flutter/material.dart';
import 'package:movies_demo_app/core/core_export.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return NetworkSensitive(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Movies"),
        ),
        body: Container(),
      ),
    );
  }
}
