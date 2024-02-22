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
  
  List<Movie>? _trendingMovies;
  List<Movie>? _nowPlayingMovies;
  List<Movie>? _upcomingMovies;
  List<Movie>? _topRatedMovies;
  List<Movie>? _popularMovies;
  String selectedCategory = 'Now Playing';

  @override
  void initState() {
    super.initState();
    fetchMovies();
  }

  Future<void> fetchMovies() async {
    _trendingMovies = await _tmdbService.fetchTrendingMovies();
    _nowPlayingMovies = await _tmdbService.fetchNowPlayingMovies();
    _upcomingMovies = await _tmdbService.fetchUpcomingMovies();
    _topRatedMovies = await _tmdbService.fetchTopRatedMovies();
    _popularMovies = await _tmdbService.fetchPopularMovies();
    setState(() {});
  }

  Widget _buildMoviesGridView(List<Movie>? movies) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
        childAspectRatio: 2 / 3,
      ),
      itemCount: movies?.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        final movie = movies![index];
        return Card(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image.network(
              'https://image.tmdb.org/t/p/w500${movie.posterPath}',
              fit: BoxFit.cover,
            ),
          ),
        );
        
      },
    );
  }

  Widget _buildSelectedCategoryGridView() {
    if (selectedCategory == 'Now Playing') {
      return _buildMoviesGridView(_nowPlayingMovies);
    } else if (selectedCategory == 'Upcoming') {
      return _buildMoviesGridView(_upcomingMovies);
    } else if (selectedCategory == 'Top Rated') {
      return _buildMoviesGridView(_topRatedMovies);
    } else if (selectedCategory == 'Popular') {
      return _buildMoviesGridView(_popularMovies);
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20,),
            const Text('What do you want to watch?', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
            SizedBox(height: 5,),
            CarouselSlider.builder(
              itemCount: _trendingMovies?.length ?? 0,
              itemBuilder: (BuildContext context, int index, int realIndex) {
                final movie = _trendingMovies![index];
                return ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                    fit: BoxFit.cover,
                  ),
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
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        selectedCategory = 'Now Playing';
                      });
                    },
                    child: const Text('Now Playing', style: TextStyle(fontSize: 10),),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        selectedCategory = 'Upcoming';
                      });
                    },
                    child: Text('Upcoming', style: TextStyle(fontSize: 10),),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        selectedCategory = 'Top Rated';
                      });
                    },
                    child: Text('Top Rated', style: TextStyle(fontSize: 10),),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        selectedCategory = 'Popular';
                      });
                    },
                    child: Text('Popular', style: TextStyle(fontSize: 10),),
                  ),
                ],
              ),
            ),
            _buildSelectedCategoryGridView(),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomeScreen(),
  ));
}
