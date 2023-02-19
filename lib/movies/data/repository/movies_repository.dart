import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../core/errors/failure.dart';
import '../../../core/network/network_exceptions.dart';
import '../../domain/entities/movie.dart';
import '../../domain/entities/movie_details.dart';
import '../../domain/repository/movie_repository.dart';
import '../../domain/usecases/get_movie_details_usecase.dart';
import '../datasources/movie_remote_datasource.dart';

class MoviesRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource remoteDataSource;

  MoviesRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Movie>>> getPopularMovies() async {
    try {
      final movies = await remoteDataSource.getPopularMovies();
      return Right(movies);
    } on NetworkException catch (failure) {
      return Left(ServerFailure(message: failure.errorMessageModel.message));
    } on DioError catch (error) {
      return Left(ServerFailure(message: error.response!.data['status_message']));
    }
  }

  @override
  Future<Either<Failure, MovieDetails>> getMovieDetails(
      MovieDetailsParameters parameters) async {
    try {
      final movieDetails = await remoteDataSource.getMovieDetails(parameters);
      return Right(movieDetails);
    } on NetworkException catch (failure) {
      return Left(ServerFailure(message: failure.errorMessageModel.message));
    } on DioError catch (error) {
      return Left(ServerFailure(message: error.response!.data['status_message']));
    }
  }
}
