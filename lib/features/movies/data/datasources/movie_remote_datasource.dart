
import 'dart:convert';

import 'package:movie_application/features/movies/data/models/MovieModel.dart';
import 'package:http/http.dart' as http;


abstract class MovieRemoteDatasource {
  Future<List<MovieModel>> getMovies(String search);
}

class MovieRemoteDatasourceImpl implements MovieRemoteDatasource {

  final http.Client client;

  static const baseUrl = "https://imdb.iamidiotareyoutoo.com";

  MovieRemoteDatasourceImpl({
    required this.client
  });

  @override
  Future<List<MovieModel>> getMovies(String search) async {
    final uri = Uri.parse('$baseUrl/search?q=$search');

    print('Making request to: $uri'); // Debug

    try {
      final response = await client.get(uri);

      print('Response status: ${response.statusCode}'); // Debug
      print('Response body: ${response.body}'); // Debug

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonMap = json.decode(response.body);
        final List<dynamic> moviesJson = jsonMap['description'] ?? [];

        if (moviesJson.isEmpty) {
          throw Exception("No movies found in response");
        }

        return moviesJson.map((json) => MovieModel.fromJson(json)).toList();
      } else {
        throw Exception("HTTP ${response.statusCode}: ${response.body}");
      }
    } catch (e) {
      print('Exception in getMovies: $e');
      rethrow;
    }
  }
}