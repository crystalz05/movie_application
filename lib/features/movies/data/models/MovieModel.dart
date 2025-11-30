import 'package:movie_application/features/movies/domain/entities/movie.dart';

class MovieModel extends Movie {
  const MovieModel({
    required super.title,
    required super.year,
    required super.rank,
    required super.actors,
    required super.alias,
    required super.imdbUrl,
    required super.posterUrl,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      title: json['#TITLE'] ?? "",
      year: json['#YEAR'] ?? 0,
      rank: json['#RANK'] ?? 0,
      actors: json['#ACTORS'] ?? "",
      alias: json['#AKA'] ?? "",
      imdbUrl: json['#IMDB_URL'] ?? "",
      posterUrl: json['#IMG_POSTER'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '#TITLE': title,
      '#YEAR': year,
      '#RANK': rank,
      '#ACTORS': actors,
      '#AKA': alias,
      '#IMDB_URL': imdbUrl,
      '#IMG_POSTER': posterUrl,
    };
  }
}
