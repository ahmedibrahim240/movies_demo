import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_demo_app/core/core_export.dart';
import 'package:movies_demo_app/screens/screens.export.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../../models/models_export.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';

buidPageButtoms() {
  return Obx(
    () => SizedBox(
      height: 50,
      child: Container(
        margin: const EdgeInsets.only(top: 10, right: 10, left: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            (homePageController.getPage == 1)
                ? Container()
                : pageButtom(
                    onPressed: () => homePageController.backPage(),
                    isBack: true,
                    label: 'Back',
                  ),
            pageButtom(
              onPressed: () {
                homePageController.nextPage();
              },
              label: 'Next page',
            ),
          ],
        ),
      ),
    ),
  );
}

buldMovieList() {
  return Obx(
    () => Expanded(
      child: StreamBuilder(
        stream: DataBaseServices.loadMoviePopular(homePageController.getPage),
        builder: (_, AsyncSnapshot<List<MoviePopularModel>> snap) {
          if (!snap.hasData) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CustomText(text: 'page not found ..'),
                  TextButton(
                    onPressed: () => homePageController.page.value = 1,
                    child: const CustomText(
                      text: 'back to home ',
                      color: Colors.red,
                    ),
                  )
                ],
              ),
            );
          } else if (snap.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          } else {
            List<MoviePopularModel> movieLsit = snap.data!;

            return StaggeredGridView.countBuilder(
              itemCount: movieLsit.length,
              crossAxisCount: 3,
              padding: const EdgeInsets.symmetric(vertical: 10),
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  debugPrint('/movie/${movieLsit[index].id}');
                  Get.to(() =>
                      MoviedetailsScreen(id: movieLsit[index].id!.toString()));
                },
                child: CustomCachedNetworkImage(
                  context: context,
                  url: Utilities.getIamgeUrl(
                    movieLsit[index].posterPath.toString(),
                  ),
                  boxFit: BoxFit.fill,
                ),
              ),
              staggeredTileBuilder: (index) => StaggeredTile.count(
                (index % 7 == 0) ? 2 : 1,
                (index % 7 == 0) ? 2 : 1,
              ),
              mainAxisSpacing: 1.5,
              crossAxisSpacing: 1.5,
            );
          }
        },
      ),
    ),
  );
}

Widget pageButtom({
  required String label,
  bool isBack = false,
  required void Function()? onPressed,
}) {
  return GestureDetector(
    onTap: onPressed,
    child: Row(
      children: isBack
          ? [
              Transform.rotate(
                angle: 180 * math.pi / 180,
                child: const Icon(
                  Icons.forward,
                  size: 20,
                  color: Colors.red,
                ),
              ),
              const SizedBox(width: 5),
              CustomText(
                text: label,
                color: Colors.red,
              ),
            ]
          : [
              CustomText(
                text: label,
                color: Colors.red,
              ),
              const SizedBox(width: 5),
              const Icon(
                Icons.forward,
                size: 20,
                color: Colors.red,
              ),
            ],
    ),
  );
}
