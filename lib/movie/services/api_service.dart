import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:toonflix/movie/model/movie_detail_model.dart';
import 'package:toonflix/movie/model/movie_model.dart';

const String popular = "popular";
const String nowPlaying = "now-playing";
const String comingSoon = "coming-soon";

class ApiService {
  static const String baseUrl = "https://movies-api.nomadcoders.workers.dev";

  static const String detail = "movie";

  static Future<List<MovieModel>> getMovies({String type = "popular"}) async {
    List<MovieModel> movieInstances = [];
    final url = Uri.parse('$baseUrl/$type');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final movies = body['results'];

      for (var movie in movies) {
        final instance = MovieModel.fromJson(movie);
        movieInstances.add(instance);
      }
      return movieInstances;
    }
    throw Error();
  }

  static Future<MovieDetailModel> getMovieById({
    required String id,
  }) async {
    final url = Uri.parse("$baseUrl/$detail?id=$id");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final movie = jsonDecode(response.body);
      return MovieDetailModel.fromJson(movie);
    }
    throw Error();
  }
}
