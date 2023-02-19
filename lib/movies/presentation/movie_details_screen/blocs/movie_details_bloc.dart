import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:movies_app_task/core/errors/failure.dart';
import 'package:movies_app_task/movies/domain/entities/movie_details.dart';

import '../../../domain/usecases/get_movie_details_usecase.dart';

part 'movie_details_event.dart';

part 'movie_details_state.dart';

class MovieDetailsBloc extends Bloc<MovieDetailsEvent, MovieDetailsState> {
  final GetMovieDetailsUsecase getMovieDetailsUsecase;

  MovieDetailsBloc({required this.getMovieDetailsUsecase})
      : super(MovieDetailsInitial()) {
    on<GetMovieDetailsEvent>((event, emit) async {
      emit(LoadingMovieDetailsState());
      final failureOrMovieDetails = await getMovieDetailsUsecase(
          MovieDetailsParameters(movieId: event.movieId));
      emit(_getMovieDetailsState(failureOrMovieDetails));
    });
  }

  MovieDetailsState _getMovieDetailsState(
      Either<Failure, MovieDetails> failureOrMovieDetails) {
    return failureOrMovieDetails.fold(
        (failure) => ErrorMovieDetailsState(message: failure.message),
        (movieDetails) => LoadedMovieDetailsState(movieDetails: movieDetails));
  }
}
