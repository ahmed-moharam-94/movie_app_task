import 'package:get_it/get_it.dart';
import 'package:movies_app_task/movies/data/datasources/movie_remote_datasource.dart';
import 'package:movies_app_task/movies/data/repository/movies_repository.dart';
import 'package:movies_app_task/movies/domain/repository/movie_repository.dart';
import 'package:movies_app_task/movies/domain/usecases/get_movie_details_usecase.dart';
import 'package:movies_app_task/movies/domain/usecases/get_popular_movies_usecase.dart';
import 'package:movies_app_task/movies/presentation/movie_details_screen/blocs/movie_details_bloc.dart';
import 'package:movies_app_task/movies/presentation/popular_movies_bloc/blocs/popular_movies_bloc.dart';

import '../network/dio_factory.dart';

final sl = GetIt.instance;

class ServiceLocator {
  void init() {
    // Dio
    sl.registerLazySingleton(() => DioFactory().getDioObject());

    // data sources
    sl.registerLazySingleton<MovieRemoteDataSource>(
        () => MoviesRemoteDataSourceImpl(sl()));

    // repositories
    sl.registerLazySingleton<MovieRepository>(
        () => MoviesRepositoryImpl(remoteDataSource: sl()));

    // usecases
    sl.registerLazySingleton(() => GetPopularMoviesUsecase(sl()));
    sl.registerLazySingleton(() => GetMovieDetailsUsecase(sl()));

    // blocs
    sl.registerFactory(() => PopularMoviesBloc(getPopularMoviesUseCase: sl()));
    sl.registerFactory(() => MovieDetailsBloc(getMovieDetailsUsecase: sl()));
  }
}
