import 'package:flutter/material.dart';
import '../../core/core_export.dart';
import '../../models/models_export.dart';
import 'functions.dart';

class MoviedetailsScreen extends StatelessWidget {
  final int id;
  const MoviedetailsScreen({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder(
          stream: DataBaseServices.loadMoviedetails(id),
          builder: (_, AsyncSnapshot<Map<dynamic, dynamic>> snap) {
            if (!snap.hasData) {
              return const Center(
                child: CustomText(text: 'loadig data ..'),
              );
            } else if (snap.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            } else {
              MoviedetailsModel movieDitail =
                  MoviedetailsModel.fromJson(snap.data!);

              return ListView(
                shrinkWrap: true,
                primary: true,
                children: [
                  buildBackdIamge(context, movieDitail),
                  buidScreenHederdetails(movieDitail),
                  buildPosterOverView(context, movieDitail),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
