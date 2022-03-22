import 'package:flutter/material.dart';
import 'package:movies_demo_app/core/core_export.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../../models/models_export.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';

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
        body: SafeArea(
          child: StreamBuilder(
            stream: DataBaseServices.loadMoviePopular(),
            builder: (_, AsyncSnapshot<List<MoviePopularModel>> snap) {
              if (!snap.hasData) {
                return const Center(
                  child: Text('don\'t have data ..'),
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
                  itemBuilder: (context, index) => CustomCachedNetworkImage(
                    context: context,
                    url:
                        "${Utilities.IMAGE_HOST}${movieLsit[index].posterPath}",
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
