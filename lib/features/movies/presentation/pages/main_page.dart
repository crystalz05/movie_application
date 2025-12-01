
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_application/core/components/url_launcher.dart';
import 'package:movie_application/features/movies/presentation/bloc/movie_bloc.dart';
import 'package:movie_application/features/movies/presentation/bloc/movie_event.dart';
import 'package:movie_application/features/movies/presentation/bloc/movie_state.dart';

class MainPage extends StatefulWidget{
  const MainPage({super.key});

  @override
  State<StatefulWidget> createState() => _MainPageState();

}

class _MainPageState extends State<MainPage>{

  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text("Movies Application"),
          centerTitle: true,
          backgroundColor: Theme.of(context).colorScheme.background,
        ),
        body: BlocBuilder<MovieBloc, MovieState> (
          builder: (context, state) {

            if(state is MovieInitial){
              context.read<MovieBloc>().add(LoadMovieEvent(search: "Spiderman"));
              return const Center(child: CircularProgressIndicator());
            }

            if(state is MovieLoading){
              return const Center(child: CircularProgressIndicator());
            }

            if(state is MovieError){
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(state.message, style: TextStyle(color: Colors.red)),
                    SizedBox(height: 16),
                    ElevatedButton(onPressed: () {
                      context.read<MovieBloc>().add(LoadMovieEvent(search: "Spiderman"));
                    },
                        child: Text("Retry"))
                  ],
                ),
              );
            }

            if(state is MovieLoaded){
              return Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            TextField(
                              controller: _searchController,
                              decoration: InputDecoration(
                                  hintText: "Search movies",
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(100))
                              ),
                              maxLines: 1,
                            ),
                            Positioned(
                                right: 1,
                                // top: 0,
                                child:
                            ElevatedButton(onPressed: (){
                              final query = _searchController.text.trim();
                              if(query.isNotEmpty){
                                context.read<MovieBloc>().add(LoadMovieEvent(search: query));
                              }
                              },
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size(100, 50)
                                ),
                                child: Text("Search"))
                            )
                          ],
                        )
                      ),
                      Expanded(
                        child: ListView.builder(
                            itemCount: state.movies.length,
                            itemBuilder: (context, index){

                              final movies = state.movies[index];

                              return Card(
                                clipBehavior: Clip.hardEdge,
                                child: Padding(
                                    padding: EdgeInsets.all(0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Image.network(
                                          movies.posterUrl,
                                        ),
                                        Padding(padding: EdgeInsets.all(16),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                    mainAxisSize: MainAxisSize.max,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      Expanded(child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                              movies.title,
                                                              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)
                                                          ),
                                                          Text("${movies.year}"),
                                                        ],
                                                      ),
                                                      ),
                                                      SizedBox(width: 18),
                                                      Column(
                                                        crossAxisAlignment: CrossAxisAlignment.end,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Text("Rank: "),
                                                              Text("${movies.rank}", style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                                                            ],
                                                          )
                                                        ],
                                                      )
                                                    ]),
                                                // Text("ACTORS"),
                                                // Text("ALIAS"),
                                                // Text("IMDB LINK"),
                                                Divider(indent: 24, endIndent: 24),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        Text("ACTORS: ", style: Theme.of(context).textTheme.titleMedium),
                                                        Text(movies.actors)
                                                      ],
                                                    ),
                                                    Row(
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        Text("ALIAS: ", style: Theme.of(context).textTheme.titleMedium),
                                                        Text(movies.alias)
                                                      ],
                                                    ),
                                                    Row(
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        Text("IMBD LINK: ", style: Theme.of(context).textTheme.titleMedium),
                                                        GestureDetector(
                                                          onTap: ()=> Utils.openUrl(movies.imdbUrl),
                                                          child: Text("Visit IMDB"),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                )
                                              ],
                                            )
                                        ),
                                      ],
                                    )
                                ),
                              );
                            }
                        ),
                      )
                    ],
                  )
              );
            }
            return SizedBox();
          }
        )
    );
  }
}