import 'package:flutter/material.dart';
import 'package:movies_app_task/core/constants/app_dims.dart';
import 'package:movies_app_task/movies/presentation/popular_movies_bloc/view/widgets/movie_item.dart';
import '../../../../domain/entities/movie.dart';

class PopularMoviesGridWidget extends StatelessWidget {
  final List<Movie> movies;

  const PopularMoviesGridWidget({Key? key, required this.movies})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: AppDims.d2.toInt(),
        childAspectRatio: AppDims.d2 / AppDims.d3,
        crossAxisSpacing: AppDims.d1,
        mainAxisSpacing: AppDims.d1,
      ),
      itemBuilder: (context, index) {
        return MovieItem(movie: movies[index]);
      },
      itemCount: movies.length,
    );
  }
}
