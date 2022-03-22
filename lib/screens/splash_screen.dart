import 'package:flutter/material.dart';
import 'package:movies_demo_app/screens/home/home.dart';

import '../core/core_export.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 3),
      () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => const Home(),
          ),
        );
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              'assets/splash_logo.png',
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 30,
            child: CircularProgressIndicator.adaptive(),
          ),
        ],
      ),
    );
  }
}
