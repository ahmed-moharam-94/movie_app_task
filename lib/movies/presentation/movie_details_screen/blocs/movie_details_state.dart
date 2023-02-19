part of 'movie_details_bloc.dart';

@immutable
abstract class MovieDetailsState extends Equatable {
  @override
  List<Object> get props => [];
}

class MovieDetailsInitial extends MovieDetailsState {}

class LoadingMovieDetailsState extends MovieDetailsState {}

class LoadedMovieDetailsState extends MovieDetailsState {
  final MovieDetails movieDetails;

  LoadedMovieDetailsState({required this.movieDetails});

  @override
  List<Object> get props => [movieDetails];
}

class ErrorMovieDetailsState extends MovieDetailsState {
  final String message;

  ErrorMovieDetailsState({required this.message});

  @override
  List<Object> get props => [message];
}
