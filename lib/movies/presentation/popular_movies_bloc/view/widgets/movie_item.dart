import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_app_task/core/constants/app_colors.dart';
import 'package:movies_app_task/core/constants/app_dims.dart';
import 'package:movies_app_task/core/network/api_strings.dart';
import 'package:movies_app_task/core/router/app_routes.dart';
import 'package:movies_app_task/movies/domain/entities/movie.dart';

class MovieItem extends StatelessWidget {
  final Movie movie;

  const MovieItem({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsetsDirectional.symmetric(
          horizontal: AppDims.d8, vertical: AppDims.d4),
      padding: const EdgeInsetsDirectional.all(AppDims.d2),
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.all(Radius.circular(AppDims.d16)),
      ),
      child: InkWell(
        onTap: () => _navigateToMovieDetailScreen(context),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(AppDims.d16)),
          child: GridTile(
            footer: _movieItemFooterWidgetBuilder(),
            child: _movieImageWidgetBuilder(),
          ),
        ),
      ),
    );
  }

  Widget _movieItemFooterWidgetBuilder() {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: AppDims.d8, vertical: AppDims.d12),
      color: Colors.black54,
      child: Text(movie.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
              color: AppColors.white, fontWeight: FontWeight.bold)),
    );
  }

  Widget _movieImageWidgetBuilder() {
    return ClipRRect(
      borderRadius:
      const BorderRadius.all(Radius.circular(AppDims.d16)),
      child: Container(
        color: AppColors.white,
        child: CachedNetworkImage(
          placeholder: (context, url) =>
          const Center(child: CircularProgressIndicator()),
          imageUrl: movie.backdropPath.isEmpty
              ? ApiStrings.noImageFound
              : ApiStrings.imageUrl(movie.backdropPath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  void _navigateToMovieDetailScreen(BuildContext context) {
    Navigator.of(context)
        .pushNamed(AppRoutes.movieDetailsScreen, arguments: movie.id);
  }

}
