import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../../core/errors/error_message_model.dart';
import '../../../core/network/api_strings.dart';
import '../../../core/network/network_exceptions.dart';
import '../../domain/usecases/get_movie_details_usecase.dart';
import '../models/movie_details_model.dart';
import '../models/movie_model.dart';

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> getPopularMovies();

  Future<MovieDetailsModel> getMovieDetails(MovieDetailsParameters parameters);
}

class MoviesRemoteDataSourceImpl with MovieRemoteDataSource {
  final Dio dio;

  MoviesRemoteDataSourceImpl(this.dio);

  @override
  Future<List<MovieModel>> getPopularMovies() async {
    try {
      final response = await dio.get(ApiStrings.popularMoviesPath);
      // note: you can log headers and responses here or using Dio interceptors
      if (kDebugMode) {
        log('${response.headers}', name: 'popular movies request header');
        log('${response.data}', name: 'popular movies request body');
      }

      if (response.statusCode == 200) {
        List movies = response.data['results'];
        List<MovieModel> moviesModels =
            movies.map((movies) => MovieModel.fromJson(movies)).toList();
        return moviesModels;
      } else {
        throw NetworkException(
          errorMessageModel: ErrorMessageModel.fromJson(response.data),
        );
      }
    } on DioError catch (error) {
      throw error;
    }
  }

  @override
  Future<MovieDetailsModel> getMovieDetails(
      MovieDetailsParameters parameters) async {
    try {
      final response =
          await dio.get(ApiStrings.movieDetailsPath(parameters.movieId));
      // you can log headers and responses here or using Dio interceptors
      if (kDebugMode) {
        log('${response.headers}', name: 'movie details request header');
        log('${response.data}', name: 'movie details request body');
      }

      if (response.statusCode == 200) {
        final MovieDetailsModel movieDetailsModel =
            MovieDetailsModel.fromJson(response.data);
        return movieDetailsModel;
      } else {
        throw NetworkException(
          errorMessageModel: ErrorMessageModel.fromJson(response.data),
        );
      }
    } on DioError catch (error) {
      throw error;
    }
  }
}
