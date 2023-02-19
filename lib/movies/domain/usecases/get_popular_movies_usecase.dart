import 'package:dartz/dartz.dart';
import '../../../core/errors/failure.dart';
import '../../../core/usecase/base_usecase.dart';
import '../entities/movie.dart';
import '../repository/movie_repository.dart';

class GetPopularMoviesUsecase extends BaseUsecase<List<Movie>, Unit> {
  final MovieRepository movieRepository;

  GetPopularMoviesUsecase(this.movieRepository);

  @override
  Future<Either<Failure, List<Movie>>> call(Unit parameters) async {
    return await movieRepository.getPopularMovies();
  }
}
