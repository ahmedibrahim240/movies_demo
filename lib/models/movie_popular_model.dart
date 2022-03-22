// ignore_for_file: constant_identifier_names

class MoviePopularModel {
  static const ID = 'id';
  static const TITLE = 'title';
  static const POSTERR_PATH = 'poster_path';
  static const RESULTS = 'results';
  String? id;
  String? title;
  String? posterPath;
  MoviePopularModel({this.id, this.posterPath, this.title});
  MoviePopularModel.fromJson(Map<String, dynamic> jsonMap) {
    id = jsonMap[ID];
    title = jsonMap[TITLE];
    posterPath = jsonMap[POSTERR_PATH];
  }
  Map<String, dynamic> toJson() {
    return {
      ID: id,
      TITLE: title,
      POSTERR_PATH: posterPath,
    };
  }
}
