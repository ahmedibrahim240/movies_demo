import 'dart:io';
import 'package:flutter/material.dart';
import '../../core/core_export.dart';
import '../../models/models_export.dart';

buildPosterOverView(BuildContext context, MoviedetailsModel movieDitail) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: Utilities.screenWidth * .45,
          height: Utilities.screenHeight * .3,
          child: CustomCachedNetworkImage(
            context: context,
            boxFit: BoxFit.cover,
            borderRadius: 10,
            url: Utilities.getIamgeUrl(movieDitail.posterPath!),
          ),
        ),
        const SizedBox(width: 10),
        SizedBox(
            width: Utilities.screenWidth * .45,
            child: Center(
              child: CustomText(
                text: movieDitail.overview!,
                textOverflow: null,
                size: 15,
              ),
            )),
      ],
    ),
  );
}

buidScreenHederdetails(MoviedetailsModel movieDitail) {
  return Padding(
    padding: const EdgeInsets.all(20),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: movieDitail.title!,
          maxLines: 2,
          size: 18,
          color: const Color.fromARGB(255, 158, 6, 6),
        ),
        SizedBox(height: Utilities.defaultSize),
        CustomText(
          text: "release on : ${movieDitail.releaseDate}",
        ),
        SizedBox(height: Utilities.defaultSize),
        const CustomText(
          text: "Genres",
        ),
        GridView.builder(
          itemCount: movieDitail.genres!.length,
          shrinkWrap: true,
          primary: false,
          padding: const EdgeInsets.only(top: 5),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 4,
            mainAxisSpacing: 4,
            childAspectRatio: Utilities.screenHeight / Utilities.screenWidth,
          ),
          itemBuilder: (_, index) {
            String name = movieDitail.genres![index].name!;
            return Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 158, 6, 6),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                child: CustomText(
                  text: name,
                  size: 15,
                ),
              ),
            );
          },
        ),
      ],
    ),
  );
}

buildBackdIamge(BuildContext context, MoviedetailsModel movieDitail) {
  return SizedBox(
    height: Utilities.screenHeight * .25,
    width: Utilities.screenWidth,
    child: Stack(
      fit: StackFit.expand,
      children: [
        CustomCachedNetworkImage(
          context: context,
          url: Utilities.getIamgeUrl(movieDitail.backdropPath!),
          boxFit: BoxFit.cover,
        ),
        Positioned(
          top: 20,
          left: 10,
          child: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Platform.isIOS
                ? const Icon(Icons.arrow_back_ios)
                : const Icon(Icons.arrow_back),
          ),
        ),
        Positioned(
          bottom: 10,
          left: 10,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.black12.withOpacity(.6),
            ),
            child: Column(
              children: [
                CustomText(
                  text: " ⭐ Average Rating : ${movieDitail.voteAverage}",
                  size: 14,
                ),
                SizedBox(height: Utilities.defaultSize),
                Row(
                  children: [
                    const CustomText(
                      text: " popularity : ",
                      size: 14,
                    ),
                    CustomText(
                      text: "${movieDitail.popularity}",
                      color: Colors.redAccent,
                      size: 14,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
