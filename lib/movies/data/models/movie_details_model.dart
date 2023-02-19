import 'package:movies_app_task/movies/data/models/genre_model.dart';
import 'package:movies_app_task/movies/data/models/production_company_model.dart';

import '../../domain/entities/movie_details.dart';

class MovieDetailsModel extends MovieDetails {
  const MovieDetailsModel({
    required super.backdropPath,
    required super.id,
    required super.genres,
    required super.overview,
    required super.releaseDate,
    required super.title,
    required super.voteAverage,
    required super.runtime,
    required super.adultsOnly,
    required super.originalLanguage,
    required super.productionCompanies,
    required super.status,
    required super.popularity,
    required super.budget,
    required super.voteCount,
  });

  factory MovieDetailsModel.fromJson(Map<String, dynamic> json) {
    return MovieDetailsModel(
      backdropPath: json['backdrop_path'] ?? '',
      // could be null
      id: json['id'],
      genres: List<GenreModel>.from(
          json['genres'].map((genre) => GenreModel.fromJson(genre))),
      overview: json['overview'] ?? '',
      // could be null
      releaseDate: json['release_date'],
      title: json['title'],
      voteAverage: json['vote_average'],
      voteCount: json['vote_count'],
      runtime: json['runtime'] ?? 0,
      // could be null
      adultsOnly: json['adult'],
      originalLanguage: json['original_language'],
      productionCompanies: List<ProductionCompanyModel>.from(
          json['production_companies']
              .map((company) => ProductionCompanyModel.fromJson(company))),
      status: json['status'],
      popularity: json['popularity'],
      budget: json['budget'],
    );
  }
}
