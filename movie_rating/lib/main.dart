import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/movie_provider.dart';
import 'widgets/movie_card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => MovieProvider(),
      child: MaterialApp(
        title: 'Movie Rating App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
        home: const MovieListScreen(),
      ),
    );
  }
}

class MovieListScreen extends StatelessWidget {
  const MovieListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie Ratings'),
        centerTitle: true,
      ),
      body: Consumer<MovieProvider>(
        builder: (ctx, movieProvider, child) {
          return ListView.builder(
            itemCount: movieProvider.movies.length,
            itemBuilder: (ctx, index) {
              final movie = movieProvider.movies[index];
              return MovieCard(
                movie: movie,
                onRate: (rating) {
                  movieProvider.rateMovie(index, rating);
                },
              );
            },
          );
        },
      ),
    );
  }
}
