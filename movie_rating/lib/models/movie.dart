class Movie {
  final String title;
  final String imageUrl;
  double rating;
  int totalRatings;

  Movie({
    required this.title,
    required this.imageUrl,
    this.rating = 0.0,
    this.totalRatings = 0,
  });
} 