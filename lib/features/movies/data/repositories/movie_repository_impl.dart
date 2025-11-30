
import 'package:dartz/dartz.dart';
import 'package:movie_application/core/error/failures.dart';
import 'package:movie_application/features/movies/data/datasources/movie_remote_datasource.dart';
import 'package:movie_application/features/movies/domain/entities/movie.dart';
import 'package:movie_application/features/movies/domain/repositories/movie_repository.dart';

class MovieRepositoryImpl extends MovieRepository {

  final MovieRemoteDatasource remoteDataSource;

  MovieRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Movie>>> getMovies(String search) async {
    try {
      final movies = await remoteDataSource.getMovies(search);
      return Right(movies);
    } catch (e, stackTrace) {
      print('ERROR in repository: $e');
      print('STACK TRACE: $stackTrace');
      return Left(ServerFailure());
    }
  }
}