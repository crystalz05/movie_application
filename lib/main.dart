import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_application/core/usecases/usecase.dart';
import 'package:movie_application/features/movies/domain/usecases/get_movies.dart';
import 'package:movie_application/features/movies/presentation/bloc/movie_bloc.dart';
import 'package:movie_application/features/movies/presentation/pages/main_page.dart';

import 'injection_container.dart' as di;


Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await di.init();

  // final getMovies = di.sl<GetMovies>();
  // final result = await getMovies(MovieParams(search: "spiderman"));
  //
  // result.fold(
  //       (failure) => print("FAILURE: $failure"),
  //       (movies) => print("SUCCESS: ${movies.length} movies found"),
  // );


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: BlocProvider(
          create: (context) =>di.sl<MovieBloc>(),
          child: const MainPage(),
      ),
    );
  }
}