import 'package:flutter/material.dart';
import 'package:movies_demo_app/core/core_export.dart';
import 'package:movies_demo_app/screens/screens.export.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return NetworkSensitive(
      child: Scaffold(
        appBar: AppBar(
          title: const CustomText(
            text: "Movies",
            size: 18,
          ),
          actions: [
            IconButton(
              onPressed: () => NotificationServices.sentNotifications(),
              icon: const Icon(Icons.notification_add_sharp),
            ),
          ],
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buidPageButtoms(),
              buldMovieList(),
            ],
          ),
        ),
      ),
    );
  }
}
