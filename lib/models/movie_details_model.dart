// ignore_for_file: constant_identifier_names

class MoviedetailsModel {
  static const ID = 'id';
  static const TITLE = 'title';
  static const RELEASEDATE = 'release_date';
  static const GENRES = 'genres';
  static const OVERVIEW = 'overview';
  static const POSTERR_PATH = 'poster_path';
  static const BACKDROP_PATH = 'backdrop_path';
  static const POPULARITY = 'popularity';
  static const VOTE_AVERAGE = 'vote_average';
  static const VOTE_COUNT = 'vote_count';
  int? id, voteCount;
  double? popularity, voteAverage;
  String? title, posterPath, backdropPath, overview, releaseDate;
  List<MovieGenres>? genres;

  MoviedetailsModel({
    this.id,
    this.voteAverage,
    this.voteCount,
    this.popularity,
    this.title,
    this.posterPath,
    this.backdropPath,
    this.genres,
    this.overview,
  });
  MoviedetailsModel.fromJson(Map<dynamic, dynamic> jsonMap) {
    id = jsonMap[ID];
    title = jsonMap[TITLE];
    releaseDate = jsonMap[RELEASEDATE];
    overview = jsonMap[OVERVIEW];
    voteAverage = jsonMap[VOTE_AVERAGE];
    voteCount = jsonMap[VOTE_COUNT];
    popularity = jsonMap[POPULARITY];
    backdropPath = jsonMap[BACKDROP_PATH];
    posterPath = jsonMap[POSTERR_PATH];
    genres = _setGenresLsit(jsonMap[GENRES]);
  }
  List<MovieGenres> _setGenresLsit(List? reslt) {
    List<MovieGenres> movieLsit = [];
    if (reslt == null) {
      return [];
    } else {
      for (var item in reslt) {
        movieLsit.add(MovieGenres.fromJson(item));
      }
      return movieLsit;
    }
  }

  toJson() {
    return {
      ID: id,
      TITLE: title,
      RELEASEDATE: releaseDate,
      OVERVIEW: overview,
      POSTERR_PATH: posterPath,
      BACKDROP_PATH: backdropPath,
      POPULARITY: popularity,
      VOTE_AVERAGE: voteAverage,
      VOTE_COUNT: voteCount,
    };
  }
}

class MovieGenres {
  static const ID = 'id';
  static const NANE = 'name';
  int? id;
  String? name;
  MovieGenres({this.id, this.name});
  MovieGenres.fromJson(Map<String, dynamic> jsonMap) {
    id = jsonMap[ID];
    name = jsonMap[NANE];
  }
}
