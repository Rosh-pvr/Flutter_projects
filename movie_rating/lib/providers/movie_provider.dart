import 'package:flutter/foundation.dart';
import '../models/movie.dart';

class MovieProvider with ChangeNotifier {
  final List<Movie> _movies = [
    Movie(
      title: 'Harry Potter',
      imageUrl: 'https://m.media-amazon.com/images/M/MV5BNmQ0ODBhMjUtNDRhOC00MGQzLTk5MTAtZDliODg5NmU5MjZhXkEyXkFqcGdeQXVyNDUyOTg3Njg@._V1_.jpg',
    ),
    Movie(
      title: 'Marvel Avengers',
      imageUrl: 'https://m.media-amazon.com/images/M/MV5BNDYxNjQyMjAtNTdiOS00NGYwLWFmNTAtNThmYjU5ZGI2YTI1XkEyXkFqcGdeQXVyMTMxODk2OTU@._V1_.jpg',
    ),
    Movie(
      title: 'Superman',
      imageUrl: 'https://m.media-amazon.com/images/M/MV5BNzY2ZDQ2MTctYzlhOC00MWJhLTgxMmItMDgzNDQwMDdhOWI2XkEyXkFqcGdeQXVyNjc1NTYyMjg@._V1_.jpg',
    ),
    Movie(
      title: 'The Conjuring',
      imageUrl: 'https://m.media-amazon.com/images/M/MV5BZjU5OWVlN2EtODNlYy00MjNlLWJhMDEtYzY1OTQwOTQxY2Q4XkEyXkFqcGdeQXVyMTkxNjUyNQ@@._V1_.jpg',
    ),
  ];

  List<Movie> get movies => [..._movies];

  void rateMovie(int index, double rating) {
    if (index >= 0 && index < _movies.length) {
      final movie = _movies[index];
      movie.totalRatings++;
      movie.rating = ((movie.rating * (movie.totalRatings - 1)) + rating) / movie.totalRatings;
      notifyListeners();
    }
  }
} 