import 'package:flutter/material.dart';
import 'package:movies_app_task/core/router/app_routes.dart';
import 'package:movies_app_task/movies/presentation/movie_details_screen/views/screens/movie_detailes_screen.dart';

import '../../movies/presentation/popular_movies_bloc/view/screens/popular_movies_screen.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.popularMoviesScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const PopularMoviesScreen());

      case AppRoutes.movieDetailsScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const MovieDetailsScreen());
    }
    return null;
  }
}
