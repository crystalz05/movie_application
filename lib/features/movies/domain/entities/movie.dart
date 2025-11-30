
import 'package:equatable/equatable.dart';

class Movie extends Equatable {

  final String title;
  final int year;
  final int rank;
  final String actors;
  final String alias;
  final String imdbUrl;
  final String posterUrl;

  const Movie({
    required this.title,
    required this.year,
    required this.rank,
    required this.actors,
    required this.alias,
    required this.imdbUrl,
    required this.posterUrl});

  @override
  List<Object?> get props => [title, year, rank, actors, alias, imdbUrl, posterUrl];
}