part of 'popular_movies_bloc.dart';

@immutable
abstract class PopularMoviesState extends Equatable {
  @override
  List<Object> get props => [];
}


class PopularMoviesInitial extends PopularMoviesState {}

class LoadingPopularMoviesState extends PopularMoviesState {}

class LoadedPopularMoviesState extends PopularMoviesState {
  final List<Movie> popularMovies;

  LoadedPopularMoviesState({required this.popularMovies});

  @override
  List<Object> get props => [popularMovies];
}

class ErrorPopularMoviesState extends PopularMoviesState {
  final String message;
  ErrorPopularMoviesState({required this.message});
}
