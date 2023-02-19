import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_app_task/core/constants/app_colors.dart';
import 'package:movies_app_task/core/constants/app_dims.dart';
import 'package:movies_app_task/core/network/api_strings.dart';
import 'package:movies_app_task/movies/domain/entities/movie_details.dart';

class SliverAppBarWidget extends StatelessWidget {
  final MovieDetails movieDetails;

  const SliverAppBarWidget({Key? key, required this.movieDetails})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      foregroundColor: AppColors.greyShade900,
      expandedHeight: AppDims.d400,
      pinned: true,
      stretch: true,
      backgroundColor: AppColors.greyShade900,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppDims.d8),
          child: Text(
            movieDetails.title,
            style: const TextStyle(color: AppColors.white),
          ),
        ),
        background: CachedNetworkImage(
            imageUrl: ApiStrings.imageUrl(movieDetails.backdropPath),
            fit: movieDetails.backdropPath.isEmpty
                ? BoxFit.contain
                : BoxFit.cover),
      ),
    );
  }
}
