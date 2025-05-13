

class Movie {
  final int id;
  final String originalTitle;
  final String posterPath;
  final DateTime releaseDate;

  Movie({
    required this.id,
    required this.originalTitle,
    required this.posterPath,
    required this.releaseDate,
  });

  Movie.fromJson(Map<String, dynamic> json)
    : id = json["id"],
    originalTitle = json["original_title"],
    posterPath = json["poster_path"],
    releaseDate = DateTime.parse(json["release_date"]);
}