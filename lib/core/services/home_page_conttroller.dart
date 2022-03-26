import 'package:get/get.dart';

HomePageController homePageController = HomePageController.instance;

class HomePageController extends GetxController {
  static HomePageController instance = Get.find();
  RxInt page = 1.obs;
  int get getPage => page.value;
  @override
  void onInit() {
    page.value = 1;
    super.onInit();
  }

  nextPage() {
    page.value += 1;
    update();
  }

  backPage() {
    page.value -= 1;
    update();
  }
}
