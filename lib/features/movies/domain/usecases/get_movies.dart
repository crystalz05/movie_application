

import 'package:dartz/dartz.dart';
import 'package:movie_application/core/error/failures.dart';
import 'package:movie_application/core/usecases/usecase.dart';
import 'package:movie_application/features/movies/domain/entities/movie.dart';

import '../repositories/movie_repository.dart';

class GetMovies implements UseCase<List<Movie>, MovieParams> {

  final MovieRepository movieRepository;

  GetMovies(this.movieRepository);

  @override
  Future<Either<Failure, List<Movie>>> call(MovieParams params) async {
    return await movieRepository.getMovies(params.search);
  }
}