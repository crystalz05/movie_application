import 'package:flutter/material.dart';
import 'package:movie_application/core/usecases/usecase.dart';
import 'package:movie_application/features/movies/domain/usecases/get_movies.dart';

import 'injection_container.dart' as di;


Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await di.init();

  final getMovies = di.sl<GetMovies>();
  final result = await getMovies(MovieParams(search: "spiderman"));

  result.fold(
        (failure) => print("FAILURE: $failure"),
        (movies) => print("SUCCESS: ${movies.length} movies found"),
  );


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
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget{
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Movie Application", style: TextStyle(fontWeight: FontWeight.bold),),
      centerTitle: true),
      body: const Center(
        child: Text("Hello World New"),
      ),
    );
  }
}