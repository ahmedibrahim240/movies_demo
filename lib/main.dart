import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'core/core_export.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then(
    (value) {
      Get.put<DeepLinkController>(DeepLinkController());
      Get.put<HomePageController>(HomePageController());
    },
  );
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
        Provider<DeepLinkBloc>(
          create: (context) => DeepLinkBloc(),
          dispose: (context, bloc) => bloc.dispose(),
        ),
        // ChangeNotifierProvider<DeepLinkProvider>(
        //     create: (_) => DeepLinkProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<DeepLinkBloc>(
      context,
      listen: true,
    ).state;
    return OverlaySupport(
      child: GetMaterialApp(
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
        home: Obx(() => deepLinkController.screen.value),
        // GetX(
        //   init: Get.put<DeepLinkController>(DeepLinkController()),
        //   builder: (DeepLinkController cont) {
        //     return cont.screen.value;
        //   },
        // ),
      ),
    );
  }
}
