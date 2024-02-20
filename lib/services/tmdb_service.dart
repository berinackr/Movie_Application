import 'package:dio/dio.dart';
import '../models/movie.dart';

class TMDBService {
  final Dio _dio = Dio();
  final String _apiKey = '60d0b0e59106f498c84072f97b3982fc'; // Kendi TMDB API anahtarınızı buraya yerleştirin.

  Future<List<Movie>> fetchTrendingMovies() async {
    try {
      final response = await _dio.get(
        'https://api.themoviedb.org/3/trending/movie/week?api_key=$_apiKey',
      );
      final List<Movie> movies = (response.data['results'] as List)
          .map((json) => Movie.fromJson(json))
          .toList();
      return movies;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return [];
    }
  }

  Future<List<Movie>> fetchNowPlayingMovies() async {
    try {
      final response = await _dio.get(
        'https://api.themoviedb.org/3/movie/now_playing?api_key=$_apiKey',
      );
      final List<Movie> movies = (response.data['results'] as List)
          .map((json) => Movie.fromJson(json))
          .toList();
      return movies;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return [];
    }
  }

  Future<List<Movie>> fetchPopularMovies() async {
    try {
      final response = await _dio.get(
        'https://api.themoviedb.org/3/movie/popular?api_key=$_apiKey',
      );
      final List<Movie> movies = (response.data['results'] as List)
          .map((json) => Movie.fromJson(json))
          .toList();
      return movies;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return [];
    }
  }

  Future<List<Movie>> fetchUpcomingMovies() async {
  try {
    final response = await _dio.get(
      'https://api.themoviedb.org/3/movie/upcoming?api_key=$_apiKey',
    );
    final List<Movie> movies = (response.data['results'] as List)
        .map((json) => Movie.fromJson(json))
        .toList();
    return movies;
  } catch (error, stacktrace) {
    print("Exception occured: $error stackTrace: $stacktrace");
    return [];
  }
}

}
