

import 'package:movie_application/core/usecases/usecase.dart';
import 'package:movie_application/features/movies/domain/usecases/get_movies.dart';
import 'package:movie_application/features/movies/presentation/bloc/movie_event.dart';
import 'package:movie_application/features/movies/presentation/bloc/movie_state.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {

  final GetMovies getMovies;

  MovieBloc({required this.getMovies}): super(MovieInitial()){
    on<LoadMovieEvent>(_onLoadMovies);
  }

  Future<void> _onLoadMovies(
      LoadMovieEvent event,
      Emitter<MovieState> emit,
      )async {

    emit(MovieLoading());

    final failureOrMovies = await getMovies(MovieParams(search: event.search));

    failureOrMovies.fold(
        (failure) => emit(MovieError(message: "Failed to fetch movies")),
        (movies) => emit(MovieLoaded(movies: movies))
    );
  }
}