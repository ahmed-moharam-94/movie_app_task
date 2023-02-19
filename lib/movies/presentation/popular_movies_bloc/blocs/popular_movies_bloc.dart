import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:movies_app_task/core/errors/failure.dart';

import '../../../domain/entities/movie.dart';
import '../../../domain/usecases/get_popular_movies_usecase.dart';

part 'popular_movies_event.dart';

part 'popular_movies_state.dart';

class PopularMoviesBloc extends Bloc<PopularMoviesEvent, PopularMoviesState> {
  final GetPopularMoviesUsecase getPopularMoviesUseCase;

  PopularMoviesBloc({required this.getPopularMoviesUseCase})
      : super(PopularMoviesInitial()) {
    on<PopularMoviesEvent>((event, emit) async {
      if (event is GetPopularMoviesEvent) {
        emit(LoadingPopularMoviesState());
        final failureOrPopularMovies = await getPopularMoviesUseCase(unit);
        emit(_getPopularMoviesState(failureOrPopularMovies));
      }
    });
  }

  PopularMoviesState _getPopularMoviesState(
      Either<Failure, List<Movie>> failureOrPopularMovies) {
    return failureOrPopularMovies.fold(
        (failure) => ErrorPopularMoviesState(message: failure.message),
        (movies) => LoadedPopularMoviesState(popularMovies: movies));
  }
}
