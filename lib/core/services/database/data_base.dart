import 'package:movies_demo_app/core/utilities/utilities.dart';
import 'package:movies_demo_app/models/models_export.dart';
import 'package:tmdb_api/tmdb_api.dart';

class DataBaseServices {
  static final TMDB _tmdb = TMDB(
    ApiKeys(Utilities.API_TOKEN_V3, Utilities.API_ACCES_TOKEN_V4),
    logConfig: const ConfigLogger(
      showErrorLogs: true,
      showLogs: true,
    ),
  );
  static Stream<List<MoviePopularModel>> loadMoviePopular(int page) {
    return _tmdb.v3.movies.getPopular(page: page).asStream().map(
      (map) {
        List reslt = map[MoviePopularModel.RESULTS];
        List<MoviePopularModel> movieLsit = [];
        for (var item in reslt) {
          movieLsit.add(MoviePopularModel.fromJson(item));
        }
        return movieLsit;
      },
    );
  }

  static Stream<Map<dynamic, dynamic>> loadMoviedetails(String id) {
    return _tmdb.v3.movies.getDetails(int.parse(id)).asStream().map(
      (Map<dynamic, dynamic> map) {
        return map;
      },
    );
  }
}
