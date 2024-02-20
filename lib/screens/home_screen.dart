import 'package:flutter/material.dart';
import 'package:movie_application/models/movie.dart';
import 'package:movie_application/services/tmdb_service.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TMDBService _tmdbService = TMDBService();
  //late TabController _tabController;
  List<Movie>? _trendingMovies;

  @override
  void initState() {
    super.initState();
    fetchTrendingMovies();
  }

  Future<void> fetchTrendingMovies() async {
    final List<Movie> movies = await _tmdbService.fetchTrendingMovies();
    setState(() {
      _trendingMovies = movies;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trending Movies'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Center(
              child: _trendingMovies == null
                  ? CircularProgressIndicator()
                  : CarouselSlider.builder(
                      itemCount: _trendingMovies!.length,
                      itemBuilder: (BuildContext context, int index, int realIndex) {
                        final movie = _trendingMovies![index];
                        return Image.network(
                          'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                          fit: BoxFit.cover,
                        );
                      },
                      options: CarouselOptions(
                        aspectRatio: 16 / 9,
                        viewportFraction: 0.4,
                        initialPage: 0,
                        enableInfiniteScroll: false,
                        reverse: false,
                        autoPlay: false,
                        enlargeCenterPage: true,
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
            ),
          ),
          
          Expanded(
            child: _buildVerticalListView(),
          ),
        ],
      ),
    );
  }

  Widget _buildVerticalListView() {
    return ListView.builder(
      itemCount: _trendingMovies?.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        final movie = _trendingMovies![index];
        return ListTile(
          leading: Image.network(
            'https://image.tmdb.org/t/p/w200${movie.posterPath}',
            fit: BoxFit.cover,
            width: 50,
          ),
          title: Text(movie.title),
        );
      },
    );
  }
}
