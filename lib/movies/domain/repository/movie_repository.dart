import 'package:dartz/dartz.dart';
import '../../../core/errors/failure.dart';
import '../entities/movie.dart';
import '../entities/movie_details.dart';
import '../usecases/get_movie_details_usecase.dart';

abstract class MovieRepository {
  Future<Either<Failure, List<Movie>>> getPopularMovies();
  Future<Either<Failure, MovieDetails>> getMovieDetails(MovieDetailsParameters parameters);
}