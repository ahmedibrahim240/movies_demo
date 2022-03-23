import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';

import 'package:movies_demo_app/screens/screens.export.dart';
import 'package:overlay_support/overlay_support.dart';

import 'package:provider/provider.dart';

import 'core/core_export.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await NotificationServices.setNotificationSetting();
  ConnectivityStatus initialData = await ConnectivityService().getIntState();

  runApp(
    MultiProvider(
      providers: [
        StreamProvider<ConnectivityStatus>(
          create: (_) =>
              ConnectivityService().connectionStatusController.stream,
          initialData: initialData,
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OverlaySupport(
      child: MaterialApp(
        title: 'Movies Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.dark,
          appBarTheme: const AppBarTheme(
            elevation: 0,
            centerTitle: false,
            backgroundColor: Color.fromARGB(255, 215, 0, 0),
          ),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
