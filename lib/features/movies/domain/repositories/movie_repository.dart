
import 'package:dartz/dartz.dart';
import 'package:movie_application/core/error/failures.dart';
import 'package:movie_application/features/movies/domain/entities/movie.dart';

abstract class MovieRepository {
  Future<Either<Failure, List<Movie>>> getMovies(String name);
}