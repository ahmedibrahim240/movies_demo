import 'package:movies_demo_app/core/utilities/utilities.dart';
import 'package:movies_demo_app/models/movie_popular_model.dart';
import 'package:tmdb_api/tmdb_api.dart';

class DataBaseServices {
  static final TMDB _tmdb = TMDB(
    ApiKeys(Utilities.API_TOKEN_V3, Utilities.API_ACCES_TOKEN_V4),
    logConfig: const ConfigLogger(
      showErrorLogs: true,
      showLogs: true,
    ),
  );
  static Stream<List<MoviePopularModel>> loadMoviePopular() {
    return _tmdb.v3.movies.getPopular().asStream().map(
      (Map<dynamic, dynamic> map) {
        List<MoviePopularModel> retVal = [];
        for (var item in map[MoviePopularModel.RESULTS]) {
          retVal.add(
            MoviePopularModel.fromJson(item),
          );
        }
        return retVal;
      },
    );
  }
}
