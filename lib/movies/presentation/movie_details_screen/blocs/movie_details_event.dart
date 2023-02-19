part of 'movie_details_bloc.dart';

@immutable
abstract class MovieDetailsEvent extends Equatable {
  @override
  List<Object> get props => [];
}


class GetMovieDetailsEvent extends MovieDetailsEvent {
  final int movieId;

  GetMovieDetailsEvent({required this.movieId});

  @override
  List<Object> get props => [movieId];
}


