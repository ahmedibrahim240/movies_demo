import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:movies_demo_app/core/core_export.dart';
import 'package:movies_demo_app/screens/screens.export.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../../models/models_export.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    NotificationServices.notificatonsHandel(context);
    super.initState();
  }

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
          child: StreamBuilder(
            stream: DataBaseServices.loadMoviePopular(),
            builder: (_, AsyncSnapshot<List<MoviePopularModel>> snap) {
              if (!snap.hasData) {
                return const Center(
                  child: CustomText(text: 'loadig data ..'),
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
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      debugPrint('/movie/${movieLsit[index].id}');
                      Get.to(() => MoviedetailsScreen(
                          id: movieLsit[index].id!.toString()));
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
      ),
    );
  }
}
