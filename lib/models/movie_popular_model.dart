// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

class MoviePopularModel {
  static const ID = 'id';
  static const TITLE = 'title';
  static const POSTERR_PATH = 'poster_path';
  static const RESULTS = 'results';
  int? id;
  String? title;
  String? posterPath;
  MoviePopularModel({this.id, this.posterPath, this.title});
  MoviePopularModel.fromJson(Map<String, dynamic> jsonMap) {
    debugPrint("jsonMap:$jsonMap");
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
