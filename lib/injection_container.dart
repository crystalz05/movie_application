import 'package:get_it/get_it.dart';
import 'package:movie_application/features/movies/data/datasources/movie_remote_datasource.dart';
import 'package:movie_application/features/movies/data/repositories/movie_repository_impl.dart';
import 'package:movie_application/features/movies/domain/repositories/movie_repository.dart';
import 'package:movie_application/features/movies/domain/usecases/get_movies.dart';
import 'package:movie_application/features/movies/presentation/bloc/movie_bloc.dart';

import 'package:http/http.dart' as http;
final sl = GetIt.instance;

Future<void> init() async {
  
  sl.registerFactory(() => MovieBloc(getMovies: sl()));

  sl.registerLazySingleton(()=> GetMovies(sl()));

  sl.registerLazySingleton<MovieRepository>(()=> MovieRepositoryImpl(remoteDataSource: sl()));
  
  sl.registerLazySingleton<MovieRemoteDatasource>(()=> MovieRemoteDatasourceImpl(client: sl()));

  sl.registerLazySingleton(() => http.Client());

}