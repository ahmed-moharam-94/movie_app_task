import 'package:flutter/material.dart';
import 'package:movies_app_task/movies/domain/entities/movie_details.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_dims.dart';
import '../../../../../core/constants/app_strings.dart';

class MovieInfoListWidget extends StatelessWidget {
  final MovieDetails movieDetails;

  const MovieInfoListWidget({Key? key, required this.movieDetails})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          Container(
            margin: const EdgeInsetsDirectional.symmetric(
              horizontal: AppDims.d8,
              vertical: AppDims.d16,
            ),
            padding: const EdgeInsets.all(AppDims.d4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (movieDetails.overview.isNotEmpty)
                  movieInfoBuilder(
                      title: AppStrings.overview,
                      singleValue: movieDetails.overview),
                movieInfoBuilder(
                    title: AppStrings.adultsOnly, singleValue: adultsText),
                movieInfoBuilder(
                    title: AppStrings.releaseDate,
                    singleValue: movieDetails.releaseDate),
                movieInfoBuilder(
                    title: AppStrings.genres, listValue: movieDetails.genres),
                if (movieDetails.runtime != 0)
                  movieInfoBuilder(
                      title: AppStrings.runtime, singleValue: runtimeText),
                movieInfoBuilder(
                    title: AppStrings.voteCounts, singleValue: voteCountsText),
                movieInfoBuilder(
                    title: AppStrings.voteAverage,
                    singleValue: movieDetails.voteAverage.toString()),
                movieInfoBuilder(
                    title: AppStrings.originalLanguage,
                    singleValue: movieDetails.originalLanguage),
                movieInfoBuilder(
                    title: AppStrings.productionCompanies,
                    listValue: movieDetails.productionCompanies),
                movieInfoBuilder(
                    title: AppStrings.budget,
                    singleValue: movieDetails.budget.toString()),
                movieInfoBuilder(
                    title: AppStrings.status, singleValue: movieDetails.status),
                movieInfoBuilder(
                    title: AppStrings.popularity,
                    singleValue: movieDetails.popularity.toString(),
                    applyDivider: false),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String get adultsText {
    return movieDetails.adultsOnly ? 'Yes' : 'No';
  }

  String get runtimeText {
    return '${movieDetails.runtime.toString()} min';
  }

  String get voteCountsText {
    return '${movieDetails.voteCount.toString()} votes';
  }

  Widget movieInfoBuilder(
      {required String title,
      String singleValue = '',
      List<dynamic> listValue = const [],
      bool applyDivider = true}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
              color: AppColors.white,
              fontSize: AppDims.d20,
              fontWeight: FontWeight.bold),
        ),
        if (singleValue.isNotEmpty)
          Text(singleValue,
              style: TextStyle(
                  color: AppColors.greyShade400, fontSize: AppDims.d18)),
        if (listValue.isNotEmpty)
          ...listValue.map((value) => Text(value.name,
              style: TextStyle(
                  color: AppColors.greyShade400, fontSize: AppDims.d18))),
        if (applyDivider)
          Divider(
            color: AppColors.greyShade400,
          )
      ],
    );
  }
}
