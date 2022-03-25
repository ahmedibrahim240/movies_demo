import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:movies_demo_app/screens/screens.export.dart';

DeepLinkController deepLinkController = DeepLinkController.instance;

abstract class Bloc {
  void dispose();
}

class DeepLinkBloc extends Bloc {
  //Event Channel creation
  static const stream = EventChannel('deeplink.movie.app/events');

  //Method channel creation
  static const platform = MethodChannel('deeplink.movie.app/channel');
  final StreamController<String> _stateController = StreamController();

  Stream<String> get state => _stateController.stream;

  Sink<String> get stateSink => _stateController.sink;

  DeepLinkBloc() {
    startUri().then(_onRedirected);
    stream.receiveBroadcastStream().listen((d) {
      _onRedirected(d);
    });
  }

  _onRedirected(dynamic uri) {
    Uri deepLink = Uri.parse(uri.toString());
    debugPrint("deeplink:$deepLink");
    late dynamic route;
    if (deepLink.host == "deeplink.movie.app") {
      if (deepLink.path.isEmpty) {
        route = '/';
      } else if (deepLink.path == '/movie') {
        route = '/movie';
      } else if (deepLink.path == '/open') {
        route = '/';
      } else if (deepLink.path.contains('/movie/')) {
        route = deepLink.path;
      } else {
        route = 'notfound';
      }
    } else {
      route = 'notfound';
    }

    stateSink.add(route);
    deepLinkController.setScreen(route);
  }

  @override
  void dispose() {
    _stateController.close();
  }

  startUri() async {
    try {
      return platform.invokeMethod('initialLink');
    } on PlatformException catch (e) {
      return "Failed to Invoke: '${e.message}'.";
    }
  }
}

class DeepLinkController extends GetxController {
  static DeepLinkController instance = Get.find();
  Rx<Widget> screen = Rx<Widget>(const SplashScreen());

  setScreen(String? route) {
    if (route == null || route == '/') {
      screen.value = const SplashScreen();
      Get.to(
        () => const HomeScreen(),
      );
    } else if (route == '/movie') {
      screen.value = const HomeScreen();
      Get.to(
        () => const HomeScreen(),
      );
    } else if (route.contains('/movie/')) {
      List splet = route.split('/movie/');
      String id = splet[1];
      if (id.isEmpty) {
        screen.value = const NotFoundScreen(
          text: "Movie not found",
        );
        Get.to(
          () => const NotFoundScreen(
            text: "Movie not found",
          ),
        );
      } else {
        screen.value = const HomeScreen();
        Get.to(() => MoviedetailsScreen(id: id));
      }
    } else {
      screen.value = const NotFoundScreen();
      Get.to(
        () => const NotFoundScreen(),
      );
    }
    update();
  }
}
