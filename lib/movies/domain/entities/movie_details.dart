import 'package:equatable/equatable.dart';
import 'package:movies_app_task/movies/domain/entities/genre.dart';
import 'package:movies_app_task/movies/domain/entities/production_company.dart';

class MovieDetails extends Equatable {
  final String backdropPath; // could be null
  final int id;
  final List<Genre> genres;
  final String overview; // could be null
  final bool adultsOnly;
  final String originalLanguage;
  final String releaseDate;
  final List<ProductionCompany> productionCompanies;
  final String status;
  final double popularity;
  final int budget;
  final String title;
  final double voteAverage;
  final int voteCount;
  final int runtime; // could be null

  const MovieDetails({
    required this.backdropPath,
    required this.id,
    required this.genres,
    required this.overview,
    required this.adultsOnly,
    required this.originalLanguage,
    required this.releaseDate,
    required this.productionCompanies,
    required this.status,
    required this.popularity,
    required this.budget,
    required this.title,
    required this.voteAverage,
    required this.voteCount,
    required this.runtime,
  });

  @override
  List<Object> get props =>
      [
        backdropPath,
        id,
        genres,
        overview,
        adultsOnly,
        originalLanguage,
        releaseDate,
        productionCompanies,
        status,
        popularity,
        budget,
        title,
        voteAverage,
        voteCount,
        runtime,
      ];
}
