
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../core/errors/failure.dart';
import '../../../core/usecase/base_usecase.dart';
import '../entities/movie_details.dart';
import '../repository/movie_repository.dart';

class GetMovieDetailsUsecase extends BaseUsecase<MovieDetails, MovieDetailsParameters> {
  final MovieRepository movieRepository;
  GetMovieDetailsUsecase(this.movieRepository);
  @override
  Future<Either<Failure, MovieDetails>> call(MovieDetailsParameters parameters) async  {
      return await movieRepository.getMovieDetails(parameters);
  }

}

class MovieDetailsParameters extends Equatable {
  final int movieId;

  const MovieDetailsParameters({required this.movieId});

  @override
  List<Object> get props => [movieId];
}